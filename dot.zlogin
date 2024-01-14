# Set initial path
export PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin
export PATH=${HOME}/go/bin:${HOME}/src/gocode/bin/:$PATH:~/bin/:/usr/local/bin:/usr/local/sbin
export GOPATH=$HOME/src/gocode

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    export PATH=$PATH:/usr/local/go/bin
fi

# Python/Pip
export PATH=$PATH:/home/simonb/.local/bin


if [[ ! ( -f /usr/share/games/fortune/kaizo-quotes || -f /usr/share/games/fortunes/kaizo-quotes || /opt/homebrew/share/games/fortunes/kaizo-quotes ) ]]; then
    rm -rf -- /tmp/$$ /tmp/$$-kaizo-quotes
    wget -O /tmp/$$-kaizo-quotes.tar.gz https://kaizo.org/misc/kaizo-quotes.tar.gz && \
        mkdir /tmp/$$ && \
        tar -C /tmp/$$/ -xvf /tmp/$$-kaizo-quotes.tar.gz
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        doas install -m 0644 /tmp/$$/kaizo-quotes /usr/share/games/fortunes/kaizo-quotes
        doas install -m 0644 /tmp/$$/kaizo-quotes.dat /usr/share/games/fortunes/kaizo-quotes.dat 
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install fortune
        install -m 0644 /tmp/$$/kaizo-quotes /opt/homebrew/share/games/fortunes/kaizo-quotes
        install -m 0644 /tmp/$$/kaizo-quotes.dat /opt/homebrew/share/games/fortunes/kaizo-quotes.dat
    elif [[ "$OSTYPE" == "freebsd"* ]] then
        mkdir /usr/local/share/games/fortune/
        install -m 0644 /tmp/$$/kaizo-quotes /usr/local/share/games/fortune/kaizo-quotes
        install -m 0644 /tmp/$$/kaizo-quotes.dat /usr/local/share/games/fortune/kaizo-quotes.dat
    else
        doas install -m 0644 /tmp/$$/kaizo-quotes /usr/share/games/fortune/kaizo-quotes
        doas install -m 0644 /tmp/$$/kaizo-quotes.dat /usr/share/games/fortune/kaizo-quotes.dat 
    fi
fi

# bootstrap ls-go.  assume go is already installed via a package manager.
ls-go &> /dev/null || go install github.com/acarl005/ls-go@latest

# install speedtest-go
which speedtest-go &> /dev/null || go install github.com/showwin/speedtest-go@latest

if [[ "$OSTYPE" == "openbsd"* ]]; then 
    /usr/games/fortune /usr/share/games/fortune/kaizo-quotes
else
    fortune kaizo-quotes
fi

uprecords &> /dev/null && uprecords

echo ""

export PYTHONIOENCODING=utf8

echo -n "New Random Password: "
pwgen -1 32 -s

echo -n "Current external IPv4: "
curl -4 https://wtfismyip.com/text 
echo -n "Current external IPv6: "
curl -6 https://wtfismyip.com/text

export EDITOR=vim
export MPD_HOST=myhyfy.av.kaizo.lan
