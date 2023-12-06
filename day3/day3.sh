#!/bin/zsh



cat sample_p1.txt | awk 'i=0 BEGIN {i+=1; print $0} END {print $i}' file
