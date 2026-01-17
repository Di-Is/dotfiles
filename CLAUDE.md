# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Chezmoi-managed dotfiles for cross-platform (Linux, macOS, Windows) development environment configuration.

## Commands

```bash
chezmoi diff          # Preview changes
chezmoi apply         # Apply changes
chezmoi apply --force # Re-run scripts
chezmoi add <file>    # Add file to management
```

## Chezmoi Naming Conventions

- `.tmpl` suffix → Go template (uses `{{ .chezmoi.os }}` etc.)
- `dot_` prefix → Target file starts with `.`
- `private_` prefix → Mode 0600
- `executable_` prefix → Mode 0755
- `symlink_` prefix → Creates symlink

## Key Files

- `.chezmoiignore` - Feature flags via `CHEZMOI_*` env vars
- `dot_config/mise/config.toml.tmpl` - Tool definitions (70+ tools)
- `_cross_platform/` - Shared configs symlinked per platform

## Coding Guidelines

- Prioritize type-safe programming
- Comments and docstrings in English
- Remove unused code
- Think in English, respond in Japanese
