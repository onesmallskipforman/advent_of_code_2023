#!/bin/zsh



# only 12 red cubes, 13 green cubes, and 14 blue cubes

MAXRED=12
MAXGREEN=13


# if not exceeded, print game number


aboveMax() {
    COLOR=$1
    LIMIT=$2
    cat input.txt | head -n1 | grep -o "[1-9]* $COLOR" | awk "{s = s || (\$1 > $LIMIT)? 1:0;next} END {print s}"
}

aboveMax 'blue' 14

# MAXBLUE=14
# head -n1 | grep -o '[1-9]* blue' | awk "{(\$1 > s)? \$1 : s;next} END {print s}"
