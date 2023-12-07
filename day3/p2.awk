# NOTE: I was experiencing match passing with [0-9] but not [0-9]* if the first
# (leftmost) char was not [0-9]. not sure why yet
function getMatch(str, regex) {
    match(str, regex)
    return substr(str, RSTART, RLENGTH)
}

# NOTE: substr indexes from 1
function substr0(str, idx, len) {

    if (idx < 0) { len = len + idx }
    return substr(str, idx+1, len)
}

function expandNumInStr(str, idx, parts) {

    left_str  = substr0(str, 0, idx)
    right_str = substr0(str, idx+1, length(str)-(idx-1))

    left_match  = getMatch(left_str, "[0-9]*$")
    right_match = getMatch(right_str, "^[0-9]*")

    # if middle index is a number, join left and right into one number
    # print str
    middle = substr0(str, idx, 1)
    if (middle ~ /[0-9]/) {
        # print "one num"
        parts[length(parts)] = left_match middle right_match
        # print parts[length(parts)-1]
        # print ""
    } else {
        # print "two nums"
        # print left_match
        # print right_match
        if (length(left_match)) { parts[length(parts)] = left_match }
        if (length(right_match)) { parts[length(parts)] = right_match }
        # print parts[length(parts)-1]
        # print parts[length(parts)-2]
        # print ""
    }
}

# NOTE: awk seems quirky but i might be missing something.
# using i as the loop variable here sometimes caused the loop in
# processGearWindow below to get stuck at the same value when printArr
# was called within the loop
#
# seems like running printArr resets i to 0 in the processGearWindow loop
# why? my guess is that printArr deletes i, setting it back to zero
# WHAT: https://www.gnu.org/software/gawk/manual/html_node/Variable-Scope.html#Controlling-Variable-Scope
function printArr(a,   i) {
    for (i in a) {print a[i]}
}

function processGearWindow(l1, l2, l3) {
    total = 0

    # TODO: you could just use match to advance to the next gear (marked by '*')
    for (i=0; i<length(l2); i++) {

        char = substr0(l2, i, 1)
        if (char ~ /\*/) {

            delete parts

            expandNumInStr(l1, i, parts)
            expandNumInStr(l2, i, parts)
            expandNumInStr(l3, i, parts)
            total += (length(parts) == 2)? parts[0]*parts[1] : 0
            # printArr(parts)
        }
    }
    return total
}

BEGIN {
    line1 = ""
    line2 = ""
    line3 = ""
}

{
    line1 = line2
    line2 = line3
    line3 = $0
    totals += processGearWindow(line1, line2, line3)
}

END {
    # feels hacky to put the last run here
    totals += processGearWindow(line2, line3, "")
    print totals
}
