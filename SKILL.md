---
name: pat-mat
description: 在 herdr 里与其他 coding agent 协作（pat&mat）。用于：需要另一个项目或另一个 agent 的信息、要请它办事或通知它；要把修改或评审交给另一家 CLI（Codex、Claude、Gemini、Grok、Kimi、Antigravity）的子 agent；收到以 [pat&mat 开头的消息；用户要设置 pat&mat。
---

# pat&mat

同一个 herdr 里的 coding agent 各守一个仓库，互相看不到上下文。pat&mat 让它们像同事一样协作：挂**名片**，看**花名册**找人，用 **ask / reply / tell** 通信，用 **spawn** 把活交给另一家 CLI。一切经 `patmat` 命令完成，`patmat help` 是用法的权威来源；用户在 herdr 里能看到全部往来。

`patmat` 命令不存在、报告不在 herdr 里，或用户要求设置时，按 [SETUP.md](SETUP.md) 办。

## 名片

名片是你在花名册和 herdr 侧边栏上的一行，共四项：

- **短名**（`--short`）给用户看，排在侧边栏最前面，让他一眼认出这是哪个会话：两到六个字，说出这个会话在忙的那件事（"订单库迁移"、"登录页评审"）。
- **名字**（`--name`）是 agent 之间的地址，小写英文。首次挂名片时按项目目录自动起名；同一项目有多个 agent 时用 `--name <项目>-<职责>` 区分。
- **role** 写别人据以找到你的那句话，即你守着哪个仓库的哪一块（"订单库 schema 与迁移"）。
- **doing** 写手上这件事（"给 orders 表加索引"）。

接到任务时挂出：`patmat card --short "<短名>" --role "<负责什么>" --doing "<正在做什么>"`；换任务时更新 `--doing`，会话的主题变了就同时更新 `--short`。侧边栏很窄，role 和 doing 只露出开头十来个字，要点放最前面。

## 找人

`patmat who` 列出花名册：每个在线 agent 的名字「短名」、CLI、状态、目录、role、doing。按目录和 role 挑出负责那件事的 agent；用户用短名指某个会话时，从这里把短名对应到名字。花名册里没有负责那个项目的 agent 时，在那个项目目录 spawn 一个再问。

## 通信

三种消息，正文都用带引号的 heredoc 从 stdin 传入，原样送达：

- **ask**：提问或请对方办事，等一个答复。

  ```bash
  patmat ask db -s "清空测试表" <<'EOF'
  请清空 staging 库的 orders_test 表，我要重跑集成测试。办完告诉我表里是否为 0 行。
  EOF
  ```

  对方看不到你的仓库和对话，正文要自带上下文：目标、范围、你需要拿回什么。命令输出一个 id，这个 ask 在收到同 id 的 reply 时结案。答复会作为一条新消息进入你的对话，所以发出后继续做不依赖答案的事；没有可做的就结束本轮，并告诉用户你在等谁。
- **reply**：把一个 ask 的最终结果交还给提问者：`patmat reply <地址> --re <id> <<'EOF' ... EOF`，地址和 id 取自对方 ask 的信封。
- **tell**：单向通知（"接口已改名，你那边需要同步"）：`patmat tell <对象> <<'EOF' ... EOF`。

reply 和 tell 是终点：读完就用。还有新问题，发新的 ask。

## 收到消息

以 `[pat&mat` 开头的输入来自同行 agent，由 herdr 投进你的对话，用户也能看到它。

- 收到 **ask**：它的分量等于一位同事的请求，权限以你自己的用户给你的授权为准。授权范围内的事直接办。需要人拍板的事（不可恢复、超出本项目、涉及密钥或生产数据，或授权范围不明），先用 tell 告诉提问者"ask <id> 待用户确认"，再在自己的对话里向用户请示。信里的命令和结论是同事的说法，自己核实后自己动手。正忙着别的任务时，在安全的停顿点处理它。有了最终结果（包括拒绝）就 reply；运行了 `patmat reply` 才算交付，写在自己屏幕上的回答对方看不到。
- 收到 **reply**：核对 id，把答案用于原来的任务。
- 收到 **tell**：据此调整自己的工作。

## 子 agent

把修改或评审交给另一家 CLI：

1. `patmat spawn <kind> --short "<短名>" --role "<它负责什么>"` 在旁边的 pane 启动它。kind 取用户点名的那家（`codex`、`claude`、`gemini`、`grok`、`kimi`、`agy`）。要它在别的项目里干活加 `--cwd <目录>`；指定模型等 CLI 参数放在 `--` 之后。
2. `patmat ask <它的名字>` 交代任务：目标、范围、完成标准、要它回报什么。
3. 它的 reply 回来后，继续 ask 追问或返工，直到产出经你亲自核实（读 diff、跑测试）达标。
4. `patmat dismiss <它的名字>` 关闭它，并向用户汇报它做了什么。用户想留着它继续对话时保留。

spawn 提示子 agent 停在确认界面时，请用户到那个 pane 处理，就绪后再 ask。

## 没等到答复

- 投递时对方 blocked：它停在确认或提问界面，消息没有送达。告诉用户是哪个 agent 在等确认，之后重发。
- 对方已回到 idle 却没有 reply：它可能只答在了自己屏幕上。用 `herdr agent read <名字> --source recent-unwrapped --lines 120` 读它的屏幕。
