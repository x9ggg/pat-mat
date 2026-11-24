# 设置 pat&mat

完成标准：`patmat doctor` 输出"全部就绪"，并且用户在 herdr 侧边栏看到你的名片。

1. **安装**。先告诉用户 `patmat install` 会改动什么，他同意后运行本 skill 目录下的 `scripts/patmat install`：

   - 把 `patmat` 命令链到 `~/.local/bin`，所有 CLI 共用这一个入口。
   - 对本机每家已适配的 CLI（Claude Code、Codex、Grok）：把本 skill 链进它的全局 skill 目录，在它的全局指令文件末尾追加名片指针，装上它的 herdr 集成。
   - 在 herdr 配置里加入显示名片的侧边栏行，并让 herdr 重载配置。

   命令可以重复执行：已就位的跳过，被别的东西占着的路径不覆盖。herdr 未安装时，先带用户按 https://herdr.dev 安装。

2. **补齐**。处理 install 输出里标着"跳过""未完成""注意"的每一项，以及它不处理的三种情况：

   - **其余 CLI**（Kimi、Antigravity 等）：从它的文档或 `--help` 找到全局 skill 目录和全局指令文件，把本 skill 目录软链进前者，把 `patmat pointer` 的输出追加到后者。没有 skill 机制的 CLI 只加指针，它靠消息信封里自带的说明参与协作。
   - **用户自定义过侧边栏**：把 `$short`、`$role`、`$doing` 加进他现有的 `[ui.sidebar.agents]` rows，短名排在最前，然后运行 `herdr server reload-config`。名字由内置的 `agent` token 显示。
   - **沙箱**：CLI 的沙箱可能拦住 herdr 的 unix socket，症状是 `patmat who` 报 `Operation not permitted`；在每家要用的 CLI 里运行一次 `patmat who` 探测。Codex 的 workspace-write 沙箱默认拦截（0.172 实测），在 `~/.codex/config.toml` 里这样设置后可以连通，代价是放开该沙箱的全部网络访问：

     ```toml
     [sandbox_workspace_write]
     network_access = true
     ```

     其他 CLI 按同样的思路放行 `~/.config/herdr/herdr.sock`。放宽权限由用户决定：向他说明代价，他同意后再改。

3. **验收**。在 herdr 里运行 `patmat doctor` 直到"全部就绪"。运行 `patmat card --short "<短名>" --role "<你负责什么>" --doing "设置 pat&mat"`，请用户确认侧边栏出现了这张名片。最后请用户在每家 CLI 里新开一个会话，问一句"现在有哪些 agent 在线"：它运行了 `patmat who`，说明这家 CLI 已经认识 pat&mat。已经开着的旧会话要重启后才会读到新加的指针。
