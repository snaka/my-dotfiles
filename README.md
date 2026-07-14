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
