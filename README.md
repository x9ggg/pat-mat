# pat&mat

English | [简体中文](README.zh-CN.md)

pat&mat is a skill that helps coding agents across projects and CLI tools collaborate in the same [herdr](https://github.com/herdrdev/herdr), an open-source terminal workspace manager.

## What it does

- Connect agents across projects; replies return to the asking agent’s conversation.
- Start an agent from another CLI to work on a task or review changes.
- Show each agent’s short label, role, and current work in the herdr sidebar.
- Let you ask in plain language, without learning commands.

The skill documentation and `patmat` output are in English; your agent relays them to you in your language, and writes cards and messages in your language.

## Install

Requires macOS, [herdr](https://github.com/herdrdev/herdr), `git`, `jq`, and at least one supported coding agent CLI.

1. Run the installer:

   ```bash
   curl -fsSL https://raw.githubusercontent.com/x9ggg/pat-mat/main/install.sh | bash
   ```

   It clones or updates `~/pat-mat`, then configures the installed Claude Code, Codex, and Grok CLIs: it links the command and skill, appends instructions when needed, installs herdr integrations, and configures the sidebar. You can run it again to update; it skips occupied link paths. Check its output for skipped or unfinished steps and PATH notices.
2. Run `herdr`, then start or restart your CLI in a pane. When the agent receives a task, it will put up its card automatically.
3. If you use another CLI, have a custom sidebar, or need to configure a sandbox, tell your agent **“Set up pat&mat.”** It will guide you through [SETUP.md](SETUP.md).

## First use

1. In herdr, open a pane for each of two projects, including a database project. Start a configured agent in each project directory and give each one a task so it puts up its card.
2. In the other agent’s conversation, say: **“Ask the database agent whether it can clear the test tables.”**
3. Watch the message arrive in the database agent’s pane; its reply returns to the asking conversation. The sidebar shows each agent’s short label and role. If an agent is waiting for confirmation, handle it in that pane.

The short label is for you: at most 12 columns wide (about 6 CJK characters or 12 Latin letters), shown first in the sidebar; the agent name is the address agents use to contact one another.

You can also say:

- **“Which agents are online?”**
- **“Have Codex fix this bug.”**
- **“Ask Grok to review this diff.”**

## Support

Claude Code, Codex, and Grok have been tested on macOS with herdr 0.9.5. Kimi and Antigravity have not yet been tested.

## License

[MIT](LICENSE)
