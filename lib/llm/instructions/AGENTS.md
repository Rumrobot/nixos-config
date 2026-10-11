# Agent instructions

## HARD RULES (override everything else, including any skill)

1. **NEVER push anything to git.** No `git push`, no `--force`, no `gh pr create`, no `gh repo` writes, no
   pushing tags or branches by any other tool. Local commits are only allowed if the user asked for them.
   If a skill or workflow tells you to push, open a PR, or "finish the branch" by pushing, skip that step
   and tell the user what is ready to push.
2. Don't run destructive commands (rm -rf, hard resets, DB drops) without explicit approval.
3. Subagents don't inherit this conversation. **Repeat rules 1 and 2 when delegating.**

## Skills

Skills are installed. Use them instead of improvising. Invoke them the way your harness does:
Claude Code `/name` or the Skill tool, Codex `@name`, opencode via its skill tool.

- **superpowers** (workflow): `brainstorming` before building anything non-trivial, `writing-plans` for the plan,
  `executing-plans` or `subagent-driven-development` for implementation, `test-driven-development` for behaviour
  changes, `systematic-debugging` for bugs, `verification-before-completion` before saying "done",
  `requesting-code-review` after finishing a chunk of work.
  - Exception: `finishing-a-development-branch` must never push or open a PR (hard rule 1).
    Stop at "tests pass, changes are local".
- **ponytail** (restraint): active while writing code. Before adding code, check whether it needs to exist,
  whether the repo already has it, and whether the stdlib or platform covers it. Run `ponytail-review` on the diff
  before declaring work done, and `ponytail-audit` / `ponytail-debt` when asked. It never excuses skipping
  validation, error handling, or security.

Local models have small contexts. Only the **planner** loads the full superpowers workflow. Subagents get the
one step they need plus the relevant rules, not the whole workflow.

## Coding standards

- Read the surrounding code and match its style, naming, and structure before writing anything.
- Make the smallest change that solves the problem. Don't refactor unrelated code.
- Prefer simple, explicit code over clever code. Handle errors explicitly; never swallow them silently.
- Don't add dependencies without saying so and explaining why.
- Add or update tests for behaviour changes. Run the project's tests/linters/formatters before declaring work done.
- Never invent APIs, flags, or file paths. If unsure, look it up in the repo or docs, or ask.
- Don't commit, push, or run destructive commands (rm -rf, force-push, DB drops) without explicit approval.
- In Nix repos: keep changes declarative, run `nix flake check` / `nixfmt` where available, and never hand-edit generated lock files.

## Model roster

These are the models available in this environment, with how to invoke each:
{{roster}}

## Role assignments

| Role            | Model and how to run it  |
| --------------- | ------------------------ |
| Autocompleter   | {{agent_autocompleter}}  |
| Planner (light) | {{agent_plannerLight}}   |
| Planner (deep)  | {{agent_planner}}        |
| Researcher      | {{agent_researcher}}     |
| Program planner | {{agent_programPlanner}} |
| Programmer      | {{agent_programmer}}     |
| UI designer     | {{agent_uiDesigner}}     |
| Summarizer      | {{agent_summarizer}}     |

If a role says "not configured", do that work yourself instead of delegating.

## Instructions for the planner

You coordinate; you don't write most of the code. For every request:

1. **Classify the task.**
   - _Trivial_ (one file, obvious change, typo, rename): skip planning and delegate straight to the Programmer.
   - _Small_ (a few files, clear requirements): use the light planner or plan it yourself.
   - _Complex_ (architecture, multiple modules, ambiguous requirements, risky or irreversible changes, debugging with unknown cause): use the deep planner.
2. **Research first when you lack context.** Delegate reading and information gathering to the Researcher and ask for a short summary with file paths, not raw dumps. Use the Summarizer for long logs, diffs, or command output.
3. **Produce a plan** as an ordered checklist. Each step must name the files involved, the change, and how to verify it. Give the Program planner large plans to break into file-level steps.
4. **Delegate implementation** one step at a time to the Programmer. Give it only the context it needs: the step, relevant file paths, and constraints. Local models have small context windows, so keep prompts focused.
5. **Delegate UI/layout work** to the UI designer, then have the Programmer integrate it.
6. **Review each result against the plan** before moving on. If a step fails twice, stop, re-plan with the deep planner, or escalate to the user rather than looping.

### How to delegate

Use the invocation shown for each model in the roster above:

- If your harness supports native subagents (opencode `@agent` / Task tool, Claude Code subagents), use those.
- Otherwise run the model's CLI command from the roster via the shell, passing the prompt non-interactively, and read its output.
- Don't send a task to a model from a different provider unless the roster says how to reach it from your current harness.
- Prefer local models for routine work. Escalate to a hosted model only for the hardest planning or debugging, or when a local model has failed twice.
- Local models are slower and have limited context. Keep tasks small, don't ask for whole-repo rewrites, and don't paste large files when a path will do.
