# Setting up pat&mat

Done when: `patmat doctor` prints "All set." (Chinese output: "全部就绪。"), and the user sees your card in the herdr sidebar.

1. **Install**. First tell the user what `patmat install` will change; once they agree, run `scripts/patmat install` from this skill's directory:

   - Links the `patmat` command into `~/.local/bin`, one entry point shared by every CLI.
   - For each supported CLI on this machine (Claude Code, Codex, Grok): links this skill into its global skill directory, appends the card pointer to the end of its global instruction file, and installs its herdr integration.
   - Adds sidebar rows that show the card to the herdr config, and has herdr reload its config.

   The command is safe to rerun: what is already in place is skipped, and paths occupied by something else are left untouched. When herdr is not installed, first walk the user through installing it from https://herdr.dev.

   `patmat` output follows a `zh*` locale and is English otherwise; when the user wants the other language, run `patmat lang zh` or `patmat lang en`.

2. **Fill the gaps**. Handle every item the install output marks "skipped", "todo", or "note" (Chinese output: 跳过, 未完成, 注意), plus the three cases it does not handle:

   - **Other CLIs** (Kimi, Antigravity, etc.): find the global skill directory and the global instruction file in its docs or `--help`, symlink this skill directory into the former, and append the output of `patmat pointer` to the latter. A CLI without a skill mechanism gets only the pointer; it takes part through the instructions carried in each message envelope.
   - **User-customized sidebar**: add `$short`, `$role`, `$doing` to their existing `[ui.sidebar.agents]` rows, with the short name first, then run `herdr server reload-config`. The name is shown by the built-in `agent` token.
   - **Sandbox**: a CLI's sandbox may block herdr's unix socket; the symptom is `patmat who` reporting `Operation not permitted`. Probe by running `patmat who` once in each CLI you will use. Codex's workspace-write sandbox blocks it by default (verified on 0.172); this setting in `~/.codex/config.toml` lets it through, at the cost of opening all network access for that sandbox:

     ```toml
     [sandbox_workspace_write]
     network_access = true
     ```

     For other CLIs, allow `~/.config/herdr/herdr.sock` along the same lines. Loosening permissions is the user's call: explain the cost, and change it once they agree.

3. **Verify**. Run `patmat doctor` inside herdr until it prints "All set.". Run `patmat card --short "<short name>" --role "<what you own>" --doing "setting up pat&mat"`, and ask the user to confirm the card appears in the sidebar. Finally, ask the user to open a new session in each CLI and ask "which agents are online right now": if it runs `patmat who`, that CLI knows pat&mat. Sessions already open read the newly added pointer only after a restart.
