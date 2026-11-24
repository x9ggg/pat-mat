# pat&mat

pat&mat 是一个 skill，让同一个 [herdr](https://github.com/herdrdev/herdr) 中不同项目、不同 coding agent CLI 里的 agent 协作。herdr 是开源终端工作区管理器。

## 能做什么

- 跨项目对话：向其他 agent 提问或请它办事，答复直接回到提问者的对话。
- 跨 CLI 协作：启动另一家 CLI 作为子 agent，交给它修改或评审任务。
- 在 herdr 侧边栏显示各 agent 的短名、职责和正在做的事。
- 不用学习命令，像平时一样对 agent 说话即可。

## 安装

前提：macOS，已安装 [herdr](https://github.com/herdrdev/herdr)、`jq` 和至少一家受支持的 coding agent CLI。

1. 克隆仓库：

   ```bash
   git clone https://github.com/x9ggg/pat-mat ~/pat-mat
   ```

2. 按使用的 CLI，复制对应命令创建软链接；用多家就分别执行。目标路径已存在时，请先检查。

   ```bash
   # Claude Code
   mkdir -p ~/.claude/skills && ln -sn ~/pat-mat ~/.claude/skills/pat-mat
   # Codex
   mkdir -p ~/.agents/skills && ln -sn ~/pat-mat ~/.agents/skills/pat-mat
   # Grok
   mkdir -p ~/.grok/skills && ln -sn ~/pat-mat ~/.grok/skills/pat-mat
   ```

3. 运行 `herdr` 进入 herdr，再在 pane 里启动你的 CLI（`claude`、`codex` 或 `grok`）。

   然后对它说：**“帮我设置 pat&mat”**。它会按 [SETUP.md](SETUP.md) 检查并带你完成剩余设置；修改全局文件前会展示改动并征得你的同意。设置完成后，在每家 CLI 中新开会话，让新指令生效。

## 怎么用

1. 在 herdr 里为两个项目各打开一个 pane（其中一个是数据库项目），在每个项目目录中启动已设置好 pat&mat 的 agent。
2. 在其中一个对话里说：**“问一下数据库那边能不能清空测试表。”** 它会找到负责数据库的 agent 并发问。
3. 在对方 pane 可以看到收到的消息；对方答复后，回复会回到提问者的对话。herdr 侧边栏会显示各 agent 的短名和职责。如果某个 agent 停在确认界面，按提示到对应 pane 处理即可。

走通后，还可以说：

- **“现在有哪些 agent 在线？”**
- **“让 Codex 修这个 bug。”**
- **“找 Grok 评审一下这个 diff。”**

## 支持情况

Claude Code、Codex、Grok 已在 macOS + herdr 0.9.5 上实测；Kimi、Antigravity 尚未实测。

## 许可证

[MIT](LICENSE)
