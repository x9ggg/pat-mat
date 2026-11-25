# pat&mat

[English](README.md) | 简体中文

pat&mat 是一个 skill，让同一个 [herdr](https://github.com/herdrdev/herdr) 中不同项目、不同 coding agent CLI 里的 agent 协作。herdr 是开源终端工作区管理器。

## 能做什么

- 跨项目对话：向其他 agent 提问或请它办事，答复直接回到提问者的对话。
- 跨 CLI 协作：启动另一家 CLI 作为子 agent，交给它修改或评审任务。
- 在 herdr 侧边栏显示各 agent 的短名、职责和正在做的事。
- 不用学习命令，像平时一样对 agent 说话即可。

skill 说明文档是英文。`patmat` 输出支持中英双语：locale 为中文（`zh*`）时输出中文，否则输出英文；可用 `patmat lang zh` 或 `patmat lang en` 切换，或用环境变量 `PATMAT_LANG` 只对当前 shell 生效。

## 安装

前提：macOS，已安装 [herdr](https://github.com/herdrdev/herdr)、`git`、`jq` 和至少一家受支持的 coding agent CLI。

1. 运行安装命令：

   ```bash
   curl -fsSL https://raw.githubusercontent.com/x9ggg/pat-mat/main/install.sh | bash
   ```

   它会克隆或更新 `~/pat-mat`，然后为已安装的 Claude Code、Codex、Grok 配置命令和 skill 软链接、按需追加全局指令、安装 herdr 集成并配置侧边栏。可以重复执行以更新；被占用的链接路径会跳过。请留意输出中跳过、未完成或 PATH 相关的提示。
2. 运行 `herdr`，在 pane 里启动或重启你的 CLI。agent 接到任务时会自动挂出名片。
3. 如果使用其他 CLI、自定义过侧边栏或需要配置沙箱，对 agent 说 **“帮我设置 pat&mat”**，它会按 [SETUP.md](SETUP.md) 带你处理。

## 第一次使用

1. 在 herdr 里为两个项目各打开一个 pane（其中一个是数据库项目），在每个项目目录中启动已配置的 agent，并分别交给它们一个任务，让它们挂出名片。
2. 在另一个 agent 的对话里说：**“问一下数据库那边能不能清空测试表。”**
3. 在数据库 agent 的 pane 里可以看到收到的消息；对方答复后，回复会回到提问者的对话。侧边栏会显示各 agent 的短名和职责。如果某个 agent 停在确认界面，按提示到对应 pane 处理即可。

短名是给你看的两到六个字标签，排在侧边栏最前；名字是 agent 之间互相联系的地址。

还可以说：

- **“现在有哪些 agent 在线？”**
- **“让 Codex 修这个 bug。”**
- **“找 Grok 评审一下这个 diff。”**

## 支持情况

Claude Code、Codex、Grok 已在 macOS + herdr 0.9.5 上实测；Kimi、Antigravity 尚未实测。

## 许可证

[MIT](LICENSE)
