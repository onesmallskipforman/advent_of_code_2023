#!/bin/zsh

solveP1() {
    cat $1 | awk -f solution.awk | awk 'BEGIN{s=1}{s*=$1} END {print s}'
}


solveP2() {
    cat $1 | sed -r 's/([0-9]*)[ ]*/\1/g' | awk -f solution.awk
}


# solveP1 sample.txt
# solveP1 input.txt

solveP2 sample.txt
solveP2 input.txt



echo "Part 1: $(solveP1 input.txt)"
echo "Part 2: $(solveP2 input.txt)"
