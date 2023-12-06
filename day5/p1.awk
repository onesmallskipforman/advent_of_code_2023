# function clear(src, dest) {
#     for (i in src) {
#         src[i] = (src[i] in dest)? dest[src[i]] : src[i]
#     }
#     delete dest
# }

# {
#     if ($1 ~ /seeds:/) {
#         for (i=2;i<=NF;i++) { source[i-2] = $i }
#         for (i in source) { destination[source[i]] = source[i] }
#     } else if ($1 ~ /[0-9]/) {
#         for (i in source) {
#             src_start = $2
#             range = $3
#             dest_start = $1
#             if (source[i] >= src_start && source[i] <= src_start + range ) {
#                 destination[source[i]] = dest_start + (source[i] - src_start)
#             }
#         }
#     } else {
#         clear(source, destination)
#         # print ""
#         # for (i in source) print source[i]
#     }
# }


function assignArray(a, b) {
    for (i in b) {
        a[i] = b[i]
    }
    for (i=length(b); i<length(a); i++) {
        delete a[i]
    }
}


{
    if ($1 ~ /seeds:/) {
        for (i=2;i<=NF;i++) { source[$i] = $i }
        for (i in source) { destination[i] = source[i] }
    } else if ($1 ~ /[0-9]/) {
        for (i in source) {
            src_start = $2
            range = $3
            dest_start = $1
            if (source[i] >= src_start && source[i] < src_start + range ) {
                destination[i] = dest_start + (source[i] - src_start)
            }
        }
    } else {
        assignArray(source, destination)
    }
}


END {
    assignArray(source, destination)

    for (i in source) {
        min = (source[i] < min || !length(min))? source[i]:min
    }
    print min
}
