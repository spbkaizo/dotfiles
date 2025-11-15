# === PATH Configuration ===
export GOPATH=$HOME/src/gocode
export PATH=$HOME/go/bin:$GOPATH/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:/usr/local/sbin:$PATH

[[ "$OSTYPE" == "linux-gnu"* ]] && export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.local/bin

# === Python ===
export PYTHONIOENCODING=utf8

# === Editor & MPD ===
export EDITOR=vim

# === Start ssh-agent and add keys if not already running ===
if [[ -z "$SSH_AUTH_SOCK" || ! -S "$SSH_AUTH_SOCK" ]]; then
  eval "$(ssh-agent -s)" > /dev/null
  for key in ~/.ssh/id_{rsa,ed25519}; do
    [[ -f $key ]] && ssh-add "$key" > /dev/null 2>&1
  done
fi

# === Go Tools Bootstrap ===
command -v ls-go &>/dev/null || go install github.com/acarl005/ls-go@latest
