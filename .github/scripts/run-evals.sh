#!/usr/bin/env bash
# Runs the eval suite against a Hex context preview, comments the results on
# the PR, and fails if any blocking case doesn't pass.
#
# Expects the `ci` CLI profile that hex-inc/action-context-toolkit logs in with.
# Required env: PREVIEW_ID, SUITE_PATH. Optional: PREVIEW_LINK, PR_NUMBER,
# GITHUB_TOKEN (for the PR comment), NON_BLOCKING_CASES (space-separated ids),
# HEX_PROFILE (default ci), POLL_SECONDS (default 20), MAX_WAIT_SECONDS (default 2700).
set -euo pipefail

: "${PREVIEW_ID:?PREVIEW_ID is required}"
: "${SUITE_PATH:?SUITE_PATH is required}"
PROFILE="${HEX_PROFILE:-ci}"
POLL_SECONDS="${POLL_SECONDS:-20}"
MAX_WAIT_SECONDS="${MAX_WAIT_SECONDS:-2700}"
NON_BLOCKING_CASES="${NON_BLOCKING_CASES:-}"
MARKER="<!-- hex-pr-evals -->"

run_json=$(hex --profile "$PROFILE" --json eval run "$SUITE_PATH" --preview-id "$PREVIEW_ID")
run_id=$(jq -r '.eval_suite_run_id' <<<"$run_json")
run_url=$(jq -r '.url' <<<"$run_json")
if [[ -z "$run_id" || "$run_id" == "null" ]]; then
  echo "::error::hex eval run returned no run id: $run_json"
  exit 1
fi
echo "Eval run $run_id: $run_url"

waited=0
while :; do
  result=$(hex --profile "$PROFILE" --json eval get "$run_id")
  status=$(jq -r '.status' <<<"$result")
  case "$status" in
    RUNNING | PENDING | QUEUED | CREATED) ;;
    *) break ;;
  esac
  if ((waited >= MAX_WAIT_SECONDS)); then
    echo "::error::Eval run $run_id still $status after ${MAX_WAIT_SECONDS}s"
    exit 1
  fi
  sleep "$POLL_SECONDS"
  waited=$((waited + POLL_SECONDS))
done

pass_pct=$(jq -r '.pass_percentage // "n/a"' <<<"$result")
echo "Eval run finished: $status, ${pass_pct}% pass"

# One row per case: id, status, passes/attempts, and whether it gates the PR.
rows=$(jq -r --arg nb " $NON_BLOCKING_CASES " '
  .case_runs[]
  | select(.status != "SKIPPED")
  | .case_id as $id
  | [ $id,
      .status,
      "\(.result.passCount // 0)/\(.number_of_attempts)",
      (if ($nb | contains(" \($id) ")) then "no" else "yes" end) ]
  | @tsv' <<<"$result")

blocking_failures=$(awk -F'\t' '$4 == "yes" && $2 != "PASS" { print $1 }' <<<"$rows")

if [[ "$status" != "COMPLETED" ]]; then
  verdict="🔴 Eval run ended with status \`$status\`."
elif [[ -n "$blocking_failures" ]]; then
  verdict="🔴 Baseline cases failed: $(paste -sd, - <<<"$blocking_failures" | sed 's/,/, /g')"
else
  verdict="🟢 All baseline cases passed."
fi

table=$(awk -F'\t' '{
  icon = ($2 == "PASS") ? "✅" : ($4 == "yes" ? "❌" : "⚠️")
  printf "| %s `%s` | %s | %s | %s |\n", icon, $1, $2, $3, $4
}' <<<"$rows")

body="$MARKER
### Hex evals: \`$SUITE_PATH\`
$verdict

**${pass_pct}%** pass overall. [Eval run]($run_url)${PREVIEW_LINK:+ · [Context preview]($PREVIEW_LINK)}

| Case | Status | Passed | Blocks merge |
|---|---|---|---|
$table"

echo "$body"
if [[ -n "${GITHUB_STEP_SUMMARY:-}" ]]; then
  echo "$body" >>"$GITHUB_STEP_SUMMARY"
fi

# Post or update a single results comment on the PR.
if [[ -n "${PR_NUMBER:-}" && -n "${GITHUB_TOKEN:-}" && -n "${GITHUB_REPOSITORY:-}" ]]; then
  comment_id=$(gh api --paginate "repos/$GITHUB_REPOSITORY/issues/$PR_NUMBER/comments" \
    --jq ".[] | select(.body | contains(\"$MARKER\")) | .id" | head -n1)
  if [[ -n "$comment_id" ]]; then
    gh api -X PATCH "repos/$GITHUB_REPOSITORY/issues/comments/$comment_id" -f body="$body" >/dev/null
  else
    gh api -X POST "repos/$GITHUB_REPOSITORY/issues/$PR_NUMBER/comments" -f body="$body" >/dev/null
  fi
fi

if [[ "$status" != "COMPLETED" || -n "$blocking_failures" ]]; then
  exit 1
fi
