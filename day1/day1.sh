#!/bin/zsh
# NOTE: this script is currently not posix-compliant due to the following line
# SUBSTR_PAD_FILTER=$(cat ids.txt | awk '{print $1}' | tr '\n' '|' | sed 's/|$// ; s/.*/s\/\\(&\\)\/<\\1>\/g/;s/|/\\|/g' | cat && echo '; s/<\(.\)/\1\1/g;s/\(.\)>/\1\1/g')
# Pieces of the sed filter get removed when running in dash (with sh)

PART1=$(cat input.txt | sed 's/[^1-9]//g' | awk '{print substr($0,1,1) substr($0,length($0),1)}' | awk '{s+=$1} END {print s}')

NON_NUMBER_FILTER=$(cat ids.txt | awk '{print $1}' | tr '\n' ' ' | sed 's/.*/s\/\\(&[1-9]\\) [a-z]\/\\1\/g/; s/ /\\\|/g')
WORD_TO_NUM_FILTER=$(cat ids.txt | sed 's/^\([^ ]*\) \(.\)/s\/\1\/\2\/g/g' | tr '\n' ';')
SUBSTR_PAD_FILTER=$(cat ids.txt | awk '{print $1}' | tr '\n' '|' | sed 's/|$// ; s/.*/s\/\\(&\\)\/<\\1>\/g/;s/|/\\|/g' | cat && echo '; s/<\(.\)/\1\1/g;s/\(.\)>/\1\1/g')

PART2=$(cat input.txt | sed "$SUBSTR_PAD_FILTER" | sed "$NON_NUMBER_FILTER" | sed "$WORD_TO_NUM_FILTER" | awk '{print substr($0,1,1) substr($0,length($0),1)}' | awk '{s+=$1} END {print s}')

echo "Part 1: $PART1"
echo "Part 2: $PART2"
