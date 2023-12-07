function cardMap(c) {
    m = ""
    switch (c) {
        case "A": m = "C" ;break
        case "K": m = "B" ;break
        case "Q": m = "A" ;break
        case "T": m = "9" ;break
        case "9": m = "8" ;break
        case "8": m = "7" ;break
        case "7": m = "6" ;break
        case "6": m = "5" ;break
        case "5": m = "4" ;break
        case "4": m = "3" ;break
        case "3": m = "2" ;break
        case "2": m = "1" ;break
        case "J": m = "0" ;break
    }
    return m
}

function handMap(h) {
    # TODO: this shouldnt be hard-coded and could be made based on the number of cards
    rank = 7
    delete dict

    for (i in h) {
        card = h[i]
        dict[card] += 1
    }


    distinct = length(dict)
    max = 0
    for (i in dict) {
        max = (dict[i] > max && i != "J")? dict[i] : max
    }

    # add wildcard jokers to max and subtract from distinct
    # be careful to not lower distinct if j is the only key
    # need to be careful with 'J in dict' in awk because mentioning it at all prior will declare it
    if ("J" in dict) {
        max += dict["J"]
        distinct -= (length(dict) > 1)? 1:0
    }

    points = max + (length(h) - distinct)

    # print max
    return points
}

{

    split($1, cards, "")
    mapping = ""

    for (i in cards) {
        mapping =  mapping cardMap(cards[i])
    }


    print handMap(cards), mapping, $1, $2
}
