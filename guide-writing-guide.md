---
name: Guide-Writing Guide — How to Build Workspace Context and Guides
description: >
  Use when someone wants to write or improve workspace context or a workspace guide, set up context
  for a new domain, improve agent accuracy, or understand best practices for context authoring in
  Hex. Retrieves on: "help me write a guide", "write my workspace context", "how do I add context",
  "the agent keeps getting it wrong", "set up context for revenue", "context strategy", "how do I
  teach the agent about my data", "workspace guide best practices".
---

# Guide-Writing Guide

This guide helps you write workspace context and workspace guides from inside Hex — no CLI or
external tools needed. The Hex agent can read your endorsed assets, run queries against your
warehouse, and draft context assets with you in a Notebook session.

---

## First: context or guide?

| If it applies to… | Use |
|--------------------|-----|
| Every question the agent gets | **Workspace context** (one file, always loaded) |
| A specific domain or question type | **Workspace guide** (retrieved only when relevant) |

When in doubt: *would this rule change the answer to an unrelated question?* If yes → context. If
no → guide.

**Keep OUT of workspace context** — each has a better home:
- Golden tables → **endorsements**
- Tables to ban → **exclude from AI** (text bans are unreliable)
- Full warehouse directory → **warehouse descriptions**
- Metric formulas → **guides or semantic models**
- Semantic model logic → **the model itself**

---

## Workspace context structure (~300 lines / 800 words max)

Four sections that work well. Keep it tight — crowded context drowns out descriptions and guides.

```markdown
# Business Context
What the company does, what this workspace supports, the main subject areas, and the decisions it
informs. Be specific — specificity helps the agent interpret ambiguous questions.

# Data Conventions & Structure
Which schemas are production-grade; naming signals (dim_/fct_/agg_/mart_, raw_/dev_); which to
avoid; column conventions. Describe patterns, not a table directory.

# Recurring Mistakes
Named anti-patterns with the reason why: e.g. "Revenue summed from line-item tables over-counts —
always use fct_revenue." Include SQL examples for correct filters.

# Analysis Preferences
Default filters (exclude test/internal), preferred chart types, validation steps. Write filters as
real SQL snippets, not prose.
```

**Language rules:** use "Always" / "Never" — not "try to" or "prefer." Describe **when and how**
to use data, not what it is (that's what warehouse descriptions are for).

---

## Workspace guide structure (~150 lines / 350 words per guide)

Each guide opens with retrieval frontmatter. Write the `description` with the terms users actually
type, or the agent won't fetch it when it's needed.

```markdown
---
name: Revenue & Subscription Metrics
description: How ARR, MRR, churn, and renewals are calculated. Use when questions mention
  revenue, ARR, MRR, churn, renewals, or subscription value.
---
```

Then these sections:

- **Canonical Metrics** — each metric's formula, the required source table, and the trap to avoid.
- **Join Patterns** — required keys per entity pair; what not to join on.
- **Schema Preferences** — source-of-record table(s) for this domain; tables to avoid.
- **Risk Areas** — confirmed anti-patterns, each with why + correct behavior.
- **Example Questions** — 2–3 in the user's own words, to aid retrieval.

---

## Domain endorsement pattern (do this before writing guides)

Endorsed assets narrow the pool the agent draws from. Good descriptions on those assets do the
routing — you shouldn't need to spell out a table list in your guide.

1. Endorse all tables, projects, and semantic models for a domain.
2. On each endorsed asset, write a description with domain keywords: *"Use for ARR, MRR, and
   churn questions. Source of record for subscription value."*
3. Enable **Endorsed Mode** (Settings → AI & agents) so Explorer users are automatically restricted
   to endorsed assets in Threads.

If you feel the urge to add a routing table to workspace context, that's a signal your
descriptions need work — fix those instead.

---

## Bootstrap your first draft with the Notebook Agent

Paste this into a new Hex notebook and run it with the Notebook Agent to generate a first draft
of your workspace context and a domain guide interactively:

---

*You are helping me write workspace context and a domain guide for our Hex workspace. Work through
this step by step.*

*Step 1 — Ask me four questions, one at a time, and wait for my answer before asking the next:*
*1. What does our company do, and what kinds of decisions does this workspace support?*
*2. How is our data structured? Describe the production schemas, any naming conventions
   (dim_/fct_/agg_/mart_), and layers I should know about.*
*3. What mistakes does the agent make most often? What queries or answers have been wrong, and why?*
*4. What are our standard analysis preferences — default filters, chart types, validation steps?*

*Step 2 — Using my answers, draft a workspace context file with these four sections: Business
Context, Data Conventions & Structure, Recurring Mistakes, Analysis Preferences. Keep it under 300
lines. Use "Always" / "Never" language. Don't include table endorsements, exclude lists, or metric
formulas — those belong elsewhere.*

*Step 3 — Suggest 2–3 domains where a guide would help most (based on my answers). Ask me to pick
one, then gather the information needed: the key metrics and their formulas, the source tables,
the join patterns, and the biggest risk areas. Draft the guide with proper frontmatter.*

---

Iterate from there. Context doesn't need to be perfect on day one — run it against real questions,
watch for wrong answers, and tighten the specific rules that caused them.

---

## After you've written your guides

**Getting them into Hex — pick your path:**

- **Right now, manually:** Data → Context Studio → Guides → New guide → paste and save. For workspace context: Settings → AI & agents → Workspace context.
- **Hex CLI:** Run `hex guide publish` from a repo that contains your guide files and a `hex_context.config.json`. The reserved filename `hex.md` maps to workspace context.
- **GitHub Actions:** Use `hex-inc/action-context-toolkit` to auto-publish on merge. `hex guide preview` runs on PRs; `hex guide publish` runs on merge to main. Guides become read-only in Hex but version-controlled in Git.

If you're just getting started, paste manually and come back to set up the CLI or GitHub Action once you're iterating regularly.

**Keeping them sharp:**
- Check **Context Studio → Suggestions** periodically — Hex auto-generates improvement recommendations from conversation patterns and feedback.
- Run `hex suggestion list` in the CLI to pull suggestions into your terminal and close the loop.
