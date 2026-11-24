# 设置 pat&mat

完成标准：`patmat doctor` 输出"全部就绪"，并且用户在 herdr 侧边栏看到你的名片。每一步先告诉用户要做什么；改动用户的全局文件前，给他看改动内容并等他同意。

1. **体检**。运行本 skill 目录下的 `scripts/patmat doctor`，得到缺项清单，后面的步骤只处理清单里的缺项。herdr 未安装时，带用户按 https://herdr.dev 安装，请他在 herdr 里重新启动你，再从这一步继续。

2. **命令上 PATH**。把 `scripts/patmat` 软链到 PATH 上的目录（doctor 的缺项里给出了命令，默认 `~/.local/bin`）。所有 CLI 共用这一个入口，消息信封里的回复命令靠它才能执行。

3. **herdr 集成**。对 doctor 报缺的每家 CLI 运行 `herdr integration install <id>`。herdr 靠集成准确识别该 CLI 是在工作、空闲还是等人确认。

4. **侧边栏**。让 herdr 配置文件 `[ui.sidebar.agents]` 的 rows 包含 `$short`、`$role`、`$doing`，短名排在最前，然后运行 `herdr server reload-config`。名字由内置的 `agent` token 显示（起名后它显示名字，未起名时显示 CLI 种类）。用户没有自定义过 rows 时写入：

   ```toml
   [ui.sidebar.agents]
   rows = [
     ["state_icon", "machine", "workspace", "tab"],
     ["$short", "agent", "$role"],
     ["$doing"],
   ]
   ```

   已有自定义 rows 时，把这三个 token 加进他现有的布局。

5. **让每家 CLI 认识 pat&mat**。问用户平时用哪几家 CLI，对每一家做两件事：把本 skill 目录软链进它的全局 skill 目录；在它的全局指令文件末尾加入名片指针。

   | CLI | 全局 skill 目录 | 全局指令文件 |
   | --- | --- | --- |
   | Claude Code | `~/.claude/skills/` | `~/.claude/CLAUDE.md` |
   | Codex | `~/.agents/skills/` | `~/.codex/AGENTS.md` |
   | Grok | `~/.grok/skills/` | `~/.grok/AGENTS.md` |

   Kimi、Antigravity 和其余 CLI：从它的文档或 `--help` 找到这两个位置。没有 skill 机制的 CLI 只加指针，它靠消息信封里自带的说明参与协作。

   名片指针原文：

   ```markdown
   在 herdr 里工作时（环境变量 HERDR_ENV=1），接到任务先运行 `patmat card --short "<两到六个字的短名，让用户一眼认出这个会话>" --role "<你负责什么>" --doing "<正在做什么>"` 挂出名片，换任务时更新 --doing。要与其他 agent 协作，或收到以 [pat&mat 开头的消息时，使用 pat-mat skill；没有该 skill 时运行 `patmat help`。
   ```

6. **沙箱**。CLI 的沙箱可能拦住 herdr 的 unix socket，症状是 `patmat who` 报 `Operation not permitted`；在每家要用的 CLI 里运行一次 `patmat who` 探测。Codex 的 workspace-write 沙箱默认拦截（0.172 实测），在 `~/.codex/config.toml` 里这样设置后可以连通，代价是放开该沙箱的全部网络访问：

   ```toml
   [sandbox_workspace_write]
   network_access = true
   ```

   其他 CLI 按同样的思路放行 `~/.config/herdr/herdr.sock`。放宽权限由用户决定：向他说明代价，他同意后再改。

7. **验收**。重跑 `patmat doctor` 直到"全部就绪"。运行 `patmat card --short "<短名>" --role "<你负责什么>" --doing "设置 pat&mat"`，请用户确认侧边栏出现了这张名片。最后请用户在每家 CLI 里新开一个会话，问一句"现在有哪些 agent 在线"：它运行了 `patmat who`，说明这家 CLI 已经认识 pat&mat。已经开着的旧会话要重启后才会读到新加的指针。
