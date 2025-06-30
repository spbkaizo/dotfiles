# === PATH Configuration ===
export GOPATH=$HOME/src/gocode
export PATH=$HOME/go/bin:$GOPATH/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:/usr/local/sbin:$PATH

[[ "$OSTYPE" == "linux-gnu"* ]] && export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.local/bin

# === Python ===
export PYTHONIOENCODING=utf8

# === Editor & MPD ===
export EDITOR=vim
export MPD_HOST=myhyfy.av.kaizo.lan

# === Start ssh-agent and add keys if not already running ===
if [[ -z "$SSH_AUTH_SOCK" || ! -S "$SSH_AUTH_SOCK" ]]; then
  eval "$(ssh-agent -s)" > /dev/null
  for key in ~/.ssh/id_{rsa,ed25519}; do
    [[ -f $key ]] && ssh-add "$key" > /dev/null 2>&1
  done
fi

# === Fortune: Install kaizo-quotes if not present ===
if ! ls /usr/share/games/fortune/kaizo-quotes /usr/share/games/fortunes/kaizo-quotes /opt/homebrew/share/games/fortunes/kaizo-quotes /usr/local/share/games/fortune/kaizo-quotes &> /dev/null; then
  TMPDIR="/tmp/kaizo.$$"
  mkdir -p "$TMPDIR"
  curl -sSL -o "$TMPDIR/kaizo-quotes.tar.gz" https://kaizo.org/misc/kaizo-quotes.tar.gz && tar -C "$TMPDIR" -xzf "$TMPDIR/kaizo-quotes.tar.gz"

  case "$OSTYPE" in
    linux-gnu*) doas install -m 0644 "$TMPDIR"/kaizo-quotes{,.dat} /usr/share/games/fortunes/ ;;
    darwin*) install -m 0644 "$TMPDIR"/kaizo-quotes{,.dat} /opt/homebrew/share/games/fortunes/ ;;
    freebsd*) 
      doas mkdir -p /usr/local/share/games/fortune/
      doas install -m 0644 "$TMPDIR"/kaizo-quotes{,.dat} /usr/local/share/games/fortune/
      ;;
    *) doas install -m 0644 "$TMPDIR"/kaizo-quotes{,.dat} /usr/share/games/fortune/ ;;
  esac
fi

# === Show quote and uptime records if available ===
[[ "$OSTYPE" == "openbsd"* ]] && /usr/games/fortune /usr/share/games/fortune/kaizo-quotes
command -v uprecords &>/dev/null && uprecords

# === Go Tools Bootstrap ===
command -v ls-go &>/dev/null || go install github.com/acarl005/ls-go@latest
command -v speedtest-go &>/dev/null || go install github.com/showwin/speedtest-go@latest

# === Informational Output ===
echo ""
echo -n "New Random Password: "; pwgen -1 32 -s
echo -n "Current external IPv4: "; curl -s4 https://wtfismyip.com/text
echo -n "Current external IPv6: "; curl -s6 https://wtfismyip.com/text
