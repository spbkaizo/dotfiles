export PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin:/opt/diet/sbin:/usr/local/avr/bin

# Python/Pip
export PATH=$PATH:/home/simonb/.local/bin


if [ ! -f /usr/share/games/fortune/kaizo-quotes ]; then                                                                                                                                       
    wget -O /tmp/$$-kaizo-quotes.tar.gz https://kaizo.org/misc/kaizo-quotes.tar.gz && \
        mkdir /tmp/$$ && \
        tar -C /tmp/$$/ -xvf /tmp/$$-kaizo-quotes.tar.gz && \
        doas install -m 0644 /tmp/$$/kaizo-quotes /usr/share/games/fortune/kaizo-quote && \
        doas install -m 0644 /tmp/$$/kaizo-quotes.dat /usr/share/games/fortune/kaizo-quotes.dat 
fi

# bootstrap ls-go.  assume go is already installed via a package manager.
ls-go &> /dev/null || go install github.com/acarl005/ls-go@latest

if [[ "$OSTYPE" == "openbsd"* ]]; then 
    /usr/games/fortune kaizo-quotes
else
    fortune kaizo-quotes
fi

echo ""

export PYTHONIOENCODING=utf8

echo -n "New Random Password: "
pwgen -1 32 -s

echo -n "Current external IP: "
curl https://wtfismyip.com/text
