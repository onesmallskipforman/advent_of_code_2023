#!/bin/zsh

solveP1() {
    cat $1 | awk -f p1.awk
}

solveP2() {
    cat $1 | awk -f p2.awk
}


solveP1 sample_p1_a.txt
solveP1 sample_p1_b.txt
solveP1 input.txt

solveP2 sample_p2_a.txt
solveP2 sample_p2_b.txt
solveP2 sample_p2_c.txt
solveP2 input.txt




echo "Part 1: $(solveP1 input.txt)"
echo "Part 2: $(solveP2 input.txt)"
