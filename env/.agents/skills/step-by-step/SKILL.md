---
name: step-by-step
description: Implement code changes through an approval-gated walkthrough. Use when the user wants to work one step at a time, review exact proposed changes before implementation, or approve each change separately.
disable-model-invocation: true
---

# Step by Step

Work through the task as a sequence of small, approval-gated steps. The user controls when implementation advances.

## Establish the plan

Explore the codebase and gather facts before proposing implementation. Finding facts is the agent’s responsibility; reserve questions for decisions that require user judgment.

Present a short ordered plan so the user can see the likely sequence. Treat the plan as revisable: later evidence or user feedback may change it.

Do not apply implementation changes until the user approves the first step.

## Preview one step

Present exactly one step at a time using this structure:

```markdown
## Step N overview

**<One sentence describing the change and its purpose.>**

### Proposed changes

<Show the relevant file moves, new files, and exact or representative diffs.>

### Verification

<List the targeted checks that will run after implementation.>

**Do you approve Step N as shown?**
```

The preview must make the scope clear enough for the user to decide:

- Name every affected file.
- Show file moves explicitly.
- Show meaningful code changes as diffs or complete snippets.
- Explain non-obvious trade-offs briefly.
- Identify behavior that must remain unchanged.
- State what is deliberately outside the step.

A preview is discussion, not implementation. Incorporate the user’s feedback and present a revised preview when they request changes. Wait for explicit approval of the revised version.

## Apply the approved step

After approval:

1. Apply only the changes shown in the preview.
2. Preserve unrelated worktree changes.
3. Run the targeted verification.
4. Report what changed and the verification result.
5. Preview the next step and wait again.

Use concise completion reporting:

```markdown
Step N is complete.

- <Result>
- <Result>
- <Tests/type checking/formatting status>
```

## Handle verification failures

A failed check does not authorize unreviewed changes.

Diagnose the failure. If the fix changes code beyond the approved preview:

1. Explain the failure in one sentence.
2. Show the exact corrective diff.
3. State whether it affects behavior.
4. Ask for approval before applying it.

Use this structure:

```markdown
Step N is applied, but verification found <specific issue>.

### Proposed correction — not yet applied

<exact correction>

No behavior changes.

**Do you approve this correction?**
```

After approval, apply the correction and rerun the relevant checks.

Small formatting changes also require a preview when they were not included in the approved step. Prefer letting the formatter describe the exact changes, then show those changes to the user before applying them.

## Keep steps small

Each step should represent one coherent decision or transformation. Split a step when it combines independently reversible changes, such as:

- file organization and behavior changes;
- architecture and product changes;
- interface design and implementation;
- refactoring and unrelated cleanup.

Keep closely coupled mechanical changes together, such as a file move and the import updates required by that move.

## Respond to design feedback

Push back when a suggestion would weaken locality, create a shallow module, introduce a hypothetical seam, or misname a responsibility. Explain the concern and recommend an alternative.

When the user’s suggestion improves the design, say so directly and revise the step. Do not defend the original proposal merely because it came first.

## Finish

The walkthrough is complete when:

- every approved step is applied;
- targeted tests pass;
- type checking passes;
- formatting and lint checks pass;
- stale paths and imports are removed;
- whitespace validation passes for the changed scope;
- no planned decision remains unresolved.

Summarize the final structure and verification results. Do not begin another architectural candidate without the user choosing it.
