

function cardMap(c) {
    m = ""
    switch (c) {
        case "A": m = "C" ;break
        case "K": m = "B" ;break
        case "Q": m = "A" ;break
        case "J": m = "9" ;break
        case "T": m = "8" ;break
        case "9": m = "7" ;break
        case "8": m = "6" ;break
        case "7": m = "5" ;break
        case "6": m = "4" ;break
        case "5": m = "3" ;break
        case "4": m = "2" ;break
        case "3": m = "1" ;break
        case "2": m = "0" ;break
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
        max = (dict[i] > max)? dict[i] : max
    }
    points = max + (length(h) - distinct)

    return points
    # return points
}




{

    split($1, cards, "")
    mapping = ""

    for (i in cards) {
        mapping =  mapping cardMap(cards[i])
    }


    print handMap(cards), mapping, $1, $2
}

# END {
# }
