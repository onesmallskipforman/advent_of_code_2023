#!/usr/bin/awk

function window(s) {

}

BEGIN {i=0}
{s[i]=$0;i++}
END {
    for (i in s) {
        j=0
        while (j<length(s[i])) {
            # if ( substr(s[i],j,1) ~ /[^0-9\.]/ ) print substr(s[i],j,1)

            str = substr(s[i],j)
            match(str, /[0-9]*/)
            match_str = substr(str, RSTART, RLENGTH)
            print ""
            print match_str
            print RLENGTH
            if (RLENGTH>0) {

                # using negative indeces with the second arge of substr just starts at first char of the str

                for (x=-1;x<=RLENGTH;x++) { for (y=-1;y<=1;y++) {
                    char = substr(s[i+y],-1,1)
                    print j+x, i+y, s[i+y], char
                    if (char ~ /[^0-9\.]/) print match_str
                }}


                # print substr(str, RSTART, RLENGTH)
                j+=RLENGTH+1
            } else {
                j++
            }
            # print s[i-1]
            # print s[i]
            # print s[i+1]
            # print ""
        }
    }
}
