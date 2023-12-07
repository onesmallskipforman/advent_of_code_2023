#!/bin/zsh

solveP1() {
    cat $1 | awk -f p1.awk | sort | awk 'BEGIN {rank=1;total=0} {total+= rank*$4; rank++} END {print total}'
}


solveP2() {
    cat $1 | awk -f p2.awk | sort | awk 'BEGIN {rank=1;total=0} {total+= rank*$4; rank++} END {print total}'
}


solveP1 sample.txt
solveP1 input.txt

solveP2 sample.txt
solveP2 input.txt



echo "Part 1: $(solveP1 input.txt)"
echo "Part 2: $(solveP2 input.txt)"
