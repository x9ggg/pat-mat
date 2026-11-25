# pat&mat

[English](README.md) | 简体中文

pat&mat 是一个 skill，让 [herdr](https://github.com/herdrdev/herdr) 里的 coding agent 跨项目、跨 CLI 协作。herdr 是一个开源终端工作区管理器。

## 能做什么

- 让 agent 相互提问或交办任务，答复会回到发起对话的窗口。
- 启动另一个 CLI agent，交给它任务或请它评审改动。
- 在 herdr 侧边栏显示各 agent 的短名、职责和正在做的事。
- 不用学习命令，直接用日常语言协调 agent。

skill 文档和 `patmat` 输出都是英文。agent 会用你的语言转述，名片信息和消息也用你的语言写。

## 安装

需要 macOS、[herdr](https://github.com/herdrdev/herdr)、`curl`、`git`、`jq` 和至少一个受支持的 coding agent CLI。

1. 运行安装命令：

   ```bash
   curl -fsSL https://raw.githubusercontent.com/x9ggg/pat-mat/main/install.sh | bash
   ```

   安装器会克隆或更新 `~/pat-mat`，配置已安装的 Claude Code、Codex、Grok 和 herdr 侧边栏。重复运行可以更新。请留意输出中跳过的步骤和 PATH 提示。
2. 运行 `herdr`，在 pane 里启动或重启 agent。它接到任务后会挂出名片。
3. 如果安装有未完成的步骤，或你使用其他 CLI、自定义侧边栏或沙箱，对 agent 说 **“帮我设置 pat&mat”**，它可以按 [SETUP.md](SETUP.md) 帮你处理。

## 第一次使用

1. 在 herdr 里打开两个 pane，分别在项目目录中启动已配置的 agent。各交给它们一个任务，让它们挂出名片。
2. 在其中一个 agent 的对话里说：**“问一下［另一个 agent 的短名］正在做哪个项目。”** 短名可以在侧边栏看到。
3. 在另一个 pane 里查看收到的消息。对方的答复会回到第一个对话。如果 agent 需要确认，在它的 pane 里处理即可。

侧边栏显示各 agent 的短名、职责和正在做的事。短名是给你看的标签，不超过 12 列宽（约 6 个汉字或 12 个英文字母）；名字则是 agent 之间互相联系的地址。

还可以说：

- **“现在有哪些 agent 在线？”**
- **“让 Codex 修这个 bug。”**
- **“找 Grok 评审一下这个 diff。”**

## 支持情况

Claude Code、Codex、Grok 已在 macOS + herdr 0.9.5 上实测；Kimi、Antigravity 尚未实测。

## 许可证

[MIT](LICENSE)
