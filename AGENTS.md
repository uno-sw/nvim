# Repository Guidelines

## Project Structure & Module Organization

This repository is a personal Neovim configuration written in Lua. `init.lua` is the entry point and loads core modules from `lua/`. General editor settings live in `lua/options.lua`, global mappings in `lua/keymaps.lua`, and Lazy.nvim bootstrap/configuration in `lua/config/lazy.lua`. Plugin specifications are grouped under `lua/plugins/` by feature, such as `lsp.lua`, `cmp.lua`, `treesitter.lua`, and `tree.lua`. Filetype-specific overrides live in `ftplugin/`, for example `ftplugin/go.lua` and `ftplugin/dart.lua`. `lazy-lock.json` pins plugin versions and should be updated intentionally.

## Build, Test, and Development Commands

- `nvim --headless "+Lazy! sync" +qa`: install or update plugins according to the Lazy.nvim specs and lockfile.
- `nvim --headless "+lua require('options')" +qa`: quick syntax/load check for a core module.
- `nvim --headless "+checkhealth" +qa`: run Neovim health checks after plugin, LSP, or provider changes.
- `git diff -- lua/ ftplugin/ init.lua lazy-lock.json`: review only configuration-related changes before committing.

There is no separate build step; changes are loaded by restarting Neovim or sourcing the edited Lua module.

## Coding Style & Naming Conventions

Use Lua with 2-space indentation, matching `lua/options.lua`. Prefer small, focused modules and keep plugin setup in `lua/plugins/<feature>.lua`. Use lowercase filenames that describe the feature or filetype. Prefer `vim.o`, `vim.opt`, `vim.g`, and `vim.keymap.set` over legacy Vimscript-style commands when practical. Keep comments brief and only where they clarify non-obvious behavior, such as terminal integration or plugin bootstrapping.

## Testing Guidelines

No formal test suite is present. Validate changes with headless Neovim commands before committing. For plugin edits, run `nvim --headless "+Lazy! sync" +qa` and confirm `lazy-lock.json` changes are expected. For mappings, options, or autocmds, start Neovim normally and verify the affected workflow interactively. Name any future tests or scripts by the behavior they validate, not by implementation details.

## Commit & Pull Request Guidelines

Current history uses short messages such as `wip`, `update`, and `Update plugins`. Prefer more descriptive imperative commits going forward, for example `Update LSP plugin config` or `Add Dart filetype settings`. Pull requests should summarize the user-facing editor behavior changed, list validation commands run, mention any plugin lockfile updates, and include screenshots only for visible UI/theme changes.

## Agent-Specific Instructions

Do not overwrite local user edits. Before changing shared configuration files, inspect the relevant module and keep edits scoped to the requested behavior.
