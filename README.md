# my-dotfiles

個人用 dotfiles。複数の端末で共有する。

## `.gitconfig` の構成

`.gitconfig` は **共有部分** と **端末固有部分** に分割している。

- `.gitconfig` (このリポジトリ / 共有): alias, core, delta, merge, credential など、どの端末でも共通の設定。末尾で `~/.gitconfig.local` を `[include]` している。
- `~/.gitconfig.local` (端末ごと / 非共有): `user.signingkey`, `gpg.ssh.program` など端末固有の設定。dotfiles の `.gitignore` に登録済みで、リポジトリには含めない。

### 新しい端末でのセットアップ

1. リポジトリを clone し、`.gitconfig` を `~/.gitconfig` にシンボリックリンクする。
2. `~/.gitconfig.local` を新規作成し、その端末固有の設定を書く。

`~/.gitconfig.local` の例 (macOS + 1Password で SSH 署名する場合):

```gitconfig
[user]
	signingkey = ssh-ed25519 AAAA...（その端末で使う公開鍵）
[gpg]
	format = ssh
[gpg "ssh"]
	program = /Applications/1Password.app/Contents/MacOS/op-ssh-sign
```

### 動作確認

```sh
git config --get user.signingkey
git config --get gpg.format
git config --get gpg.ssh.program
```

いずれも期待値が返れば OK。

## herdr の pane に Claude Code のセッション概要を表示する

Claude Code は自身のセッションタイトルを OSC エスケープで端末タイトルに書き出す。
herdr はそれを `terminal_title_stripped`（先頭の状態グリフを除いた文字列）として
保持しているので、herdr 側はそれを表示するだけでよい。

表示先は 2 箇所あり、配布経路が分かれている。

| 表示先 | 必要なもの | どこにあるか |
| --- | --- | --- |
| agent パネルの行 | `[ui.sidebar.agents.rows_by_agent]` の設定 | このリポジトリの `.config/herdr/config.toml` |
| pane ボーダー | Claude Code の hook | [snaka/claude-skills](https://github.com/snaka/claude-skills) の `herdr-pane-title` プラグイン |

pane ボーダーは端末タイトルではなく pane のメタデータを描画するため、hook が
`herdr pane current` で読み出した値を `herdr pane report-metadata` で書き戻す必要がある。
この hook は以前このリポジトリに置いていたが、`~/.claude/settings.json` への登録が
端末ごとの手作業になり絶対パスも埋め込む必要があったため、プラグインに移した。
プラグインなら登録定義がスクリプトと同居し、パスは `${CLAUDE_PLUGIN_ROOT}` で解決される。

### 新しい端末でのセットアップ

1. `herdr` と `jq` を入れる (`jq` が無いと hook は何もせず終了し、原因が見えない)。
2. herdr の設定をシンボリックリンクする。

   ```sh
   mkdir -p ~/.config/herdr
   ln -sfn "$PWD/.config/herdr/config.toml" ~/.config/herdr/config.toml
   ```

3. `herdr integration install claude` を実行する。
   これが生成する `~/.claude/hooks/herdr-agent-state.sh` は herdr が管理・上書きする
   ファイルなので、**他の端末からコピーしない**（herdr のバージョンとずれると壊れる）。
4. pane ボーダーにも出すなら、プラグインを入れる。

   ```
   /plugin marketplace add snaka/claude-skills
   /plugin install herdr-pane-title@snaka-skills
   ```

### 動作確認

```sh
herdr pane current --pane "$HERDR_PANE_ID" | jq -r '.result.pane.terminal_title_stripped'
```

herdr の pane 内で実行してセッションのタイトルが返り、agent パネルの行と pane ボーダーに
同じ文字列が出れば OK。
