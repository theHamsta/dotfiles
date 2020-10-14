
function __complete_bit
    set -lx COMP_LINE (commandline -cp)
    test -z (commandline -ct)
    and set COMP_LINE "$COMP_LINE "
    /home/stephan/go/bin/bitcomplete
end
complete -f -c bit -a "(__complete_bit)"

