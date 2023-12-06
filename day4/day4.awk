BEGIN { FS = "\\||:"; current_card=1; }
{
    split($2,a," ")
    split($3,b," ")
    delete matchdict
    for(i in a) {matchdict[a[i]] = 0}
    for(i in b) if (b[i] in matchdict) {matchdict[b[i]]+=1}

    # for (i in matchdict) print i, matchdict[i]

    s=0
    for (i in matchdict) {s+=matchdict[i]}
    total += (s)? 2^(s-1):0

    cardtotals[current_card]+=1
    for (j=1;j<=s;j++) {cardtotals[current_card+j]+=cardtotals[current_card]}
    current_card+=1

    # print s
    # print cardtotals[3]
}


# END { print total }
END {
    total_cards=0
    for(i in cardtotals) {total_cards+=cardtotals[i]}
    print total_cards
}
