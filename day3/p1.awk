function getMatch(str, regex) {
    match(str, regex)
    return substr(str, RSTART, RLENGTH)
}

# NOTE: substr indexes from 1

function substr0(str, idx, len) {

    if (idx < 0) { len = len + idx }
    return substr(str, idx+1, len)
}

function processWindow(l1, l2, l3) {
    sum = 0

    # TODO: you could just use match to advance to the next number
    for (i=0; i<length(l2); i++) {

        char = substr0(l2, i, 1)
        if (char ~ /[0-9]/) {

            # find full number
            num =  getMatch(substr0(l2, i, length(l2)-i), "[0-9]*")
            len_of_num = length(num)

            surrounding_chars = substr0(l1, i-1, len_of_num+2) \
                                substr0(l3, i-1, len_of_num+2) \
                                substr0(l2, i-1, 1) substr0(l2, i+len_of_num, 1)

            if (surrounding_chars ~ /[^0-9\.]/) {
                sum += num
            }
            i += len_of_num-1
        }
    }
    return sum
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
    totals += processWindow(line1, line2, line3)
}

END {

    # feels hacky to put the last run here
    totals += processWindow(line2, line3, "")
    print totals
}
