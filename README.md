# pat&mat

English | [简体中文](README.zh-CN.md)

pat&mat is a skill that lets coding agents collaborate across projects and CLI tools in [herdr](https://github.com/herdrdev/herdr), an open-source terminal workspace manager.

## What it does

- Connect agents so they can ask each other questions or hand off work, with replies returning to the original conversation.
- Start another CLI agent to work on a task or review changes.
- Show each agent’s short name, role, and current task in the herdr sidebar.
- Let you coordinate agents in plain language, without learning commands.

The skill documentation and `patmat` output are in English. Your agent relays them in your language and writes card details and messages in your language.

## Install

Requires macOS, [herdr](https://github.com/herdrdev/herdr), `curl`, `git`, `jq`, and at least one supported coding agent CLI.

1. Run the installer:

   ```bash
   curl -fsSL https://raw.githubusercontent.com/x9ggg/pat-mat/main/install.sh | bash
   ```

   It clones or updates `~/pat-mat` and configures installed Claude Code, Codex, Grok, and Antigravity CLIs and the herdr sidebar. You can rerun it to update. Check the output for skipped steps and PATH notices.
2. Run `herdr`, then start or restart your agent in a pane. It will post a card when it receives a task.
3. If setup reports unfinished steps, or you use another CLI, a custom sidebar, or a sandbox, tell your agent **“Set up pat&mat.”** It can follow [SETUP.md](SETUP.md).

## First use

1. In herdr, open two panes and start a configured agent in each project directory. Give each agent a task so it posts a card.
2. In one agent’s conversation, say: **“Ask [the other agent’s short name] what project it is working on.”** Use the short name shown in the sidebar.
3. Watch the message arrive in the other pane. Its reply returns to the first conversation. If an agent needs confirmation, respond in its pane.

The sidebar shows each agent’s short name, role, and current task. The short name is a label for you, at most 12 columns wide (about 6 CJK characters or 12 Latin letters); the agent name is the address agents use to contact each other.

You can also say:

- **“Which agents are online?”**
- **“Have Codex fix this bug.”**
- **“Ask Grok to review this diff.”**

## Support

Claude Code, Codex, Grok, and Antigravity have been tested on macOS with herdr 0.9.5. Kimi has not yet been tested.

## License

[MIT](LICENSE)
