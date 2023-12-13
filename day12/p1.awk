BEGIN {delete points}


function conditionRegex(conditions, current_con) {
    regex = "^\\.*"
    for (i in conditions) {
        # print conditions[i]
        for (j=1;j<=conditions[i];j++) {
            regex = regex "#"
        }
        if (i < length(conditions)  ) regex = regex "\\.+"
    }
    regex = regex "\\.*$"
    return regex
}


function eval(record, conditions, total, r_damaged, r_operational) {

    # print record
    # base case

    total_damaged = 0; for(i in conditions) {total_damaged+= conditions[i]}
    if (!match(record, /\?/) || ( total_damaged > totalChar(record, "#") + totalChar(record, "?") ) ) {
        regex = conditionRegex(conditions)
        return match(record, regex)
    }
    else {
        r_operational = record
        r_damaged = record
        sub(/\?/, ".", r_operational)
        sub(/\?/, "#", r_damaged)
        # print "r_operational:", r_operational
        # print "r_damaged:", r_damaged
        total += eval(r_damaged, conditions)
        total += eval(r_operational, conditions)
        return total
    }

}


function totalChar(str, char, total) {
    total = 0
    for (i=1;i<=length(str);i++) {
        if (substr(str, i, 1) == char) {
            total++
        }
    }

    return total
}

{

    record = $1
    # conditions = $2

    split($2, conditions, ",")
    # print record
    # print conditions[1]


    regex = conditionRegex(conditions)
    # print regex

    # if (match(record, /\?/)) {
    #     r_operational = record
    #     r_damaged = record
    #     sub("?", ".", r_operational)
    #     sub("?", "#", r_damaged)
    #     print r_damaged
    #     print r_operational
    #     print record
    #     print " "
    # }

    # match(record, /(\?)/, matches)
    # print record


    # print totalChar(record, "#")
    # print totalChar(record, "?")
    # print matches[0]
    # print length(matches)
    # print  " "
    print e = eval(record, conditions)
    sum += e
}

# END{print sum}




# part 2: four cases
# 1: record + #, conditions
# 2: # + record, conditions
# 3: record + #, conditions + [1]
# 4: # + record, [1] + conditions
