export PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin:/opt/diet/sbin:/usr/local/avr/bin

# Python/Pip
export PATH=$PATH:/home/simonb/.local/bin

fortune kaizo-quotes
echo ""

export PYTHONIOENCODING=utf8

echo -n "New Random Password: "
pwgen -1 32 -s

echo -n "Current external IP: "
curl https://wtfismyip.com/text
