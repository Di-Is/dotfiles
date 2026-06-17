## Coding Style

- Prefer type-safe code.
- Write no comments by default. Add one only when WHY is non-obvious (subtle invariant, bug workaround, hidden constraint). If a WHY won't fit one line, link an issue instead of inlining it.
- Convey structure through naming and modularity.
- Don't add try/catch or None guards to already-validated internal data. Validate only at boundaries (user input, external APIs).
- Never guess paths, signatures, or types — verify with tools first.
- Every changed line must trace to the request. Don't "improve" adjacent code while you're in the file.
- Remove imports/vars/helpers your edits orphaned. Leave pre-existing dead code; surface it instead of deleting.
- Name the behavior, not a data structure's role. Avoid 3+ stacked abstract nouns + filler (`...Context`, `...Handler`, `...Info`, `...Result`).
- Descriptions state what a value represents — not internal class names or implementation rationale.

## Communication

- Use the phrasing a native domain expert would; avoid word-by-word translation from English.
- Don't coin literal compounds (e.g. 「補助文脈」). One register per sentence.
- Think in English; reply in the user's language.
- Match response length to the question.
- Give the reason and tradeoffs behind a choice, not just the choice.
