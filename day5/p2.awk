# map is within source
# s <= m && m+m_r <= s+s_r
# (s, s_r)
# (m, m_r)
# split as (s, m-s), (m, m_r)->mapped, (m+m_r, s+s_r-(m+m_r))

# map is on right side of source
# s <= m && m <= s+s_r && s+s_r <= m+m_r
# (s, s_r)
# (m, m_r)
# split as (s, m-s), (m, s+s_r-m)->mapped

# map is on left side of  source
# m <= s && s <= m+m_r && m+m_r <= s+s_r
# (s, s_r)
# (m, m_r)
# split as (s, m+m_r-s)->mapped, (m+m_r, s+s_r-(m+m_r))

function assignPair(a, p0, p1) {
    a[0] = p1
    a[1] = p2
}

function splitRanges(src, map, dest_start, mapped, unmapped) {
    s   = src[0]
    s_r = src[1]
    m   = map[0]
    m_r = map[1]

    # map is strictly within source
    if (s < m && m+m_r < s+s_r)
    {
        unmapped[0][0] = s
        unmapped[0][1] = m-s

        mapped[0] = m+(dest_start-m)
        mapped[1] = m_r


        unmapped[1][0] = m+m_r
        unmapped[1][1] = s+s_r-(m+m_r)
    }
    # map is on right side of source
    else if (s <= m && m <= s+s_r && s+s_r <= m+m_r)
    {
        if (m-s>0) {
            unmapped[0][0] = s
            unmapped[0][1] = m-s
        }

        mapped[0] = m+(dest_start-m)
        mapped[1] = s+s_r-m
    }
    # map is on left side of  source
    else if (m <= s && s <= m+m_r && m+m_r <= s+s_r)
    {
        mapped[0] = s+(dest_start-m)
        mapped[1] = m+m_r-s

        # rewrite this function to deal with each side of the source range
        if (s+s_r-(m+m_r) > 0) {
            unmapped[0][0] = m+m_r
            unmapped[0][1] = s+s_r-(m+m_r)
        }
    }
    # map covers source (or is equal to source)
    else if (m <= s && s+s_r <= m+m_r)
    {
        mapped[0] = s+(dest_start-m)
        mapped[1] = s_r

    }
    else {
        unmapped[0][0] = s
        unmapped[0][1] = s_r
    }
}

function printArrayOfPairs(a) {
    for (i in a) {
        print i ", " a[i][0] ", " a[i][1]
    }
}

function clearArray(a) {
    for (i in a) delete a[i]
}

function assignArray(a, b) {
    for (i in b) {
        a[i] = b[i]
    }
    for (i=length(b); i<length(a); i++) {
        delete a[i]
    }
}

function assignArray2d(a, b) {
    for (i in b) {
        a[i][0] = b[i][0]
        a[i][1] = b[i][1]
    }
    len_a = length(a)
    for (i=length(b); i<len_a; i++) {
        delete a[i]
    }
}

function concatArray(a, b) {
    for (i in b) {
        a[length(a)] = b[i]
    }
}

# could generalize this
function concatArray2d(a, b) {
    for (i in b) {
        a[length(a)][0]   = b[i][0]
        a[length(a)-1][1] = b[i][1]
    }
}



BEGIN {
# note: you can declare awk variables just my naming them
# x
# m[3] (only declares third element
# deleting will declare as array (this feels like a hack)
    delete source
    delete destination
    delete mapped_totals
    delete unmapped_totals
}
{
    if ($1 ~ /seeds:/) {
        j = 0
        for (i=2;i<=NF;i+=2) {
            source[j][0] = $i
            source[j][1] = $(i+1)
            j++
        }
        assignArray2d(destination, source)
    }

    else if ($1 ~ /[0-9]/) {
        for (i in source) {

            # TODO: clean this up
            map_src_start = $2
            map_range = $3
            map_dest_start = $1
            map[0] = map_src_start
            map[1] = map_range

            src[0] = source[i][0]
            src[1] = source[i][1]

            delete mapped
            delete unmapped
            splitRanges(src, map, map_dest_start, mapped, unmapped)
            if (length(mapped) > 0) {
                mapped_totals[length(mapped_totals)][0]  = mapped[0]
                mapped_totals[length(mapped_totals)-1][1] = mapped[1]
            }
            concatArray2d(unmapped_totals,unmapped)
        }
        assignArray2d(source, unmapped_totals)
        delete unmapped_totals
    } else if (length($0) == 0) {
        concatArray2d(source, mapped_totals)
        delete mapped_totals
        delete unmapped_totals
    }
}


END {
        concatArray2d(source, mapped_totals)
        min = source[0][0]
        for (i in source) {
            min = (source[i][0] < min)? source[i][0] : min
        }
        print min
}
