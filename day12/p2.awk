

function map(str) {

    switch (str) {
        case "dot": return "dot";
        case "out": return "in";
        case "in": return "out";
    }

}

function eval(r, start, len, term, i) {

    if (len == 1) {return r[start]["dot"]}

    # print start", "len
    for (i in r["dot"]) {
        # print i
        term += r[start][i] * eval(r, map(i), len-1)
    }
    return term

}

{

    r["dot"]["dot"] = $9
    r["dot"]["out"] = $1
    r["dot"]["in"] = $4
    r["out"]["in"] = $7
    r["out"]["dot"] = $3
    r["out"]["out"] = $5
    r["in"]["out"] = $6
    r["in"]["in"] = $8
    r["in"]["dot"] = $2

    s+=eval(r, "dot", 5)
    # exit
}



END {
    print s
    # print eval(r, "dot", 5)
}
