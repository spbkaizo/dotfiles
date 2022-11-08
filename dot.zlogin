export PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin:/opt/diet/sbin:/usr/local/avr/bin

# Python/Pip
export PATH=$PATH:/home/simonb/.local/bin


if [ ! -f /usr/share/games/fortune/kaizo-quotes ]; then                                                                                                                                       
    wget -O kaizo-quotes https://kaizo.org/misc/kaizo-quotes.html && \
        doas install -m 0644 kaizo-quotes \
        /usr/share/games/fortune/ && \
        cd /usr/share/games/fortune && \
        doas strfile kaizo-quotes && \
        rm -f -- kaizo-quotes
fi     

if [[ "$OSTYPE" == "openbsd"* ]]; then 
    if [ ! -f /usr/share/games/fortunes/kaizo-quotes ]; then
        ftp https://kaizo.org/misc/kaizo-quotes.html && \
            doas install -m 0644 kaizo-quotes.html \
            /usr/share/games/fortunes && \
            cd /usr/share/games/fortunes && \
            strfile kaizo-quotes
    fi
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
