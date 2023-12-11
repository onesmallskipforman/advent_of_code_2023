#!/bin/zsh

solveP1() {
    cat $1 | awk '/^\.*$/{print $0} {print $0}' | sed 's/./& /g' | datamash transpose -t" " | sed 's/ //g; /^$/d' |awk '/^\.*$/{print $0} {print $0}' | sed 's/./& /g' | datamash transpose -t" " | sed 's/ //g; /^$/d' | awk -f p1.awk
}

solveP2() {

    ROWS=$(cat $1 | awk '/^\.*$/{print NR}' | tr '\n' ' ')
    COLS=$(cat $1 | sed 's/./& /g' | datamash transpose -t" " | sed 's/ //g; /^$/d' | awk '/^\.*$/{print NR}' | tr '\n' ' ')

    cat <(echo "R $ROWS") <(echo "C $COLS") <(cat $1 | sed 's/./& /g') | awk -f p2.awk
}

# solveP1 sample.txt
# solveP1 input.txt

# solveP2 sample.txt
# solveP2 input.txt

echo "Part 1: $(solveP1 input.txt)"
echo "Part 2: $(solveP2 input.txt)"
