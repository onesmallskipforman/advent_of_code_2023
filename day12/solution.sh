#!/bin/zsh

solveP1() {
    cat $1 | awk -f p1.awk | awk '{s+=$1} END {print s}'
}

solveP2() {

paste \
    <(cat $1 | awk '{print $1 "#" " " $2 }' | awk -f p1.awk) \
    <(cat $1 | awk '{print "#" $1 " " "1," $2 }' | awk -f p1.awk) \
    <(cat $1 | awk '{print "#" $1 " " $2 }' | awk -f p1.awk) \
    <(cat $1 | awk '{print $1 "#" " " $2 ",1" }' | awk -f p1.awk) \
    <(cat $1 | awk '{print "#" $1 "#" " " $2 }' | awk -f p1.awk) \
    <(cat $1 | awk '{print "#" $1 "#" " " "1,"$2 }' | awk -f p1.awk) \
    <(cat $1 | awk '{print "#" $1 "#" " " $2",1" }' | awk -f p1.awk) \
    <(cat $1 | awk '{print "#" $1 "#" " " "1,"$2",1" }' | awk -f p1.awk) \
    <(cat $1 | awk -f p1.awk) > results_$1

    # | awk '{s=0; s += ($1 && $2)? $1+$2:0; s+= ($3 && $4)? $3+$4:0; print s " " $5}' \
    # | awk '{print ($1)? ($1^4 * $2) : $2^5 }' \
    # | awk '{s+=$1} END {print s}'


    # cat results.txt \
    # | awk '{s=0; s += ($1 && $2)? $1+$2:0; s+= ($3 && $4)? $3+$4:0; print s " " $5}' \
    # | awk '{print ($1)? ($1^4 * $2) : $2^5 }' \
    # | awk '{s+=$1} END {print s}'

}

# solveP1 sample.txt
solveP1 input.txt
#
# solveP2 sample.txt
# solveP2 input.txt
#
# echo "Part 1: $(solveP1 input.txt)"
# echo "Part 2: $(solveP2 input.txt)"
