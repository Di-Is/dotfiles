## Coding Style

- Annotate every function signature; no `any` / `Any` / bare `# type: ignore`.
- Write no comments by default, even in comment-heavy code. Add one only when WHY is
  non-obvious (subtle invariant, bug workaround, hidden constraint). If a WHY won't fit
  one line, link an issue instead of inlining it.
- Don't add try/catch or None guards to already-validated internal data. Validate only at
  boundaries (user input, external APIs).
- Never guess paths, signatures, or types — verify with tools first.
- Every changed line must trace to the request. Don't "improve" adjacent code while you're in the file.
- Remove imports/vars/helpers your edits orphaned. Leave pre-existing dead code; surface it
  instead of deleting.
- Name for observable behavior, not for a data structure's role or an internal class name.
  Avoid 3+ stacked abstract nouns + filler (`...Context`, `...Handler`, `...Info`, `...Result`).

## Communication

- Reply in the user's language. Don't coin literal compounds
  (e.g. 「補助文脈」); one register per sentence.
- Match response length to the question.
- Give the reason and tradeoffs behind a choice, not just the choice.
