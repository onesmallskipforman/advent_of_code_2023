#!/bin/zsh

solveP1() {
    cat $1 | awk -f p1.awk
}

solveP2() {
    cat $1 | awk -f p2.awk
}

echo "Part 1: $(solveP1 input.txt)"
echo "Part 2: $(solveP2 input.txt)"
