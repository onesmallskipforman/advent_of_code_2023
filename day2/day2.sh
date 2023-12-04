#!/bin/zsh

processRow() {
    local DATA=$1
    local COLOR=$2
    local MAX=$3
    echo $DATA | sed -r "s/([0-9]* )$COLOR|./\1/g; s/:/ /g" | awk "{s=0;for(i=1; i<=NF; i++) {s=s||(\$i>$MAX)} print s}"
}

# This could/should be faster. For G games and C colors this program will run GxC shubshells
processColors() {
    while read -r data; do
        local ROWNUM=$(echo $data | sed -r 's/^Game ([0-9]*):.*/\1/g')
        local B=$(processRow $data "blue" 14)
        local R=$(processRow $data "red" 12)
        local G=$(processRow $data "green" 13)
        # echo $R $G $B
        [[ $R == 0 ]] && [[ $G == 0 ]] && [[ $B == 0 ]] && echo $ROWNUM
    done
}

rowMin() {
    local DATA=$1
    local COLOR=$2
    echo $DATA | sed -r "s/([0-9]* )$COLOR|./\1/g; s/:/ /g" | awk '{s=0;for(i=1; i<=NF; i++) {s=($i>s)? $i:s} print s}'
}

processMins() {
    while read -r data; do
        local ROWNUM=$(echo $data | sed -r 's/^Game ([0-9]*):.*/\1/g')
        local B=$(rowMin $data "blue")
        local R=$(rowMin $data "red")
        local G=$(rowMin $data "green")
        echo $R $G $B | awk '{s=$1; for(i=2; i<=NF; i++) {s=s*$i} print s}'
        # [[ $R == 0 ]] && [[ $G == 0 ]] && [[ $B == 0 ]] && echo $ROWNUM
    done
}

# TODO: pull awk summation helper out of this
PART1=$(cat input.txt | processColors | awk '{s+=$1} END {print s}')
PART2=$(cat input.txt | processMins   | awk '{s+=$1} END {print s}')
echo "Part 1: $PART1"
echo "Part 2: $PART2"
