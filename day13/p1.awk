

function min(a, b) { return (a<b)? a:b }
function rev(str, i, out) {
    out = ""
    for (i=1;i<=length(str);i++) {
        out = substr(str, i, 1) out
    }
    return out
}


function hasReflection(str, start_idx)
{
    left = substr(str, 1, start_idx)
    right = substr(str, start_idx+1 )
    mirror_len = min(length(left), length(right))
    # if (length(left) < length(right)) return 0
    # mirror_len = length(right)

    return (substr( rev(left), 1, mirror_len ) == substr( right, 1, mirror_len ))
}

function findRelfectionInArr(arr, i, j, total) {
    total = 0
    hits = 0
    delete hit_arr
    for (j=1;j<=length(arr[1])-1;j++) {
        is_reflection = 1
        for (i=1;i<=length(arr);i++) {

            # hasReflection($i, j)
            #
            # # mirror_len = min(j, length($1) - j)
            # left = substr($i, 1, j)
            # right = substr($i, j+1, length($1))
            #
            # mirror_len = min(length(left), length(right))

            # print $i
            # print left
            # print right
            # print substr( rev(left), 1, mirror_len )
            # print substr( right, 1, mirror_len )

            is_reflection = is_reflection && hasReflection(arr[i], j)
            # print is_reflection
            # print " "

        }


        if (is_reflection) { # && hits == 0) {
            # if (hits == 1) { print total, j }
            # hits++
            total+=j
            # break
        }
        if (is_reflection) {
            hit_arr[length(hit_arr)+1] = j
            hits++
        }

    }
    if (hits > 1) {
        for (i in hit_arr) print hit_arr[i]
        printArrOfStr(arr)
        print " "
    }
    return total


}

function transpose(arr_of_str, arr_tp, i, j) {
    # delete arr_tp

    for (i=1;i<=length(arr_of_str[1]);i++) {
        # print i
        # arr_tp[i] = ""
        # print length(arr_of_str)
        # print arr_of_str[length(arr_of_str)]
        for (j=1;j<=length(arr_of_str);j++) {
            # print length(arr_of_str)
            arr_tp[i] = arr_tp[i] substr(arr_of_str[j],i,1)
        }
    }
}

function printArrOfStr(arr, i) {
    for (i in arr) print arr[i], i
}


function areArraysEqual(a, b, i) {
    if (length(a) != length(b) ) {return 0}

    equal = 1
    for (i=1;i<=length(a);i++) {
        # print i
        equal = equal && (a[i] == b[i])
    }
    return equal
}

BEGIN {RS=""; FS="\n"; eq=1}
{
    delete arr; for(i=1;i<=NF;i++) {arr[i] = $i}
    delete tp; transpose(arr, tp)
    # delete tp2; transpose(tp, tp2)
    # printArrOfStr(arr)
    # print "->"
    # printArrOfStr(arr)
    # print "="
    # printArrOfStr(tp2)
    # print " "
    # eq = eq && areArraysEqual(arr, tp2)

    # NOTE: there will only be one line of reflection
    # if (findRelfectionInArr(arr) && 100*findRelfectionInArr(tp)) {
    #     print "both"
    #
    #     print "column:",findRelfectionInArr(arr)
    #     print "row:",findRelfectionInArr(tp)
    #     printArrOfStr(arr)
    #     # exit
    # }
    total += findRelfectionInArr(arr) + 100*findRelfectionInArr(tp)
}


END {
    # print eq
    print total
}


# important lesson: nested functions do not quite have the same benefit as composed functions
