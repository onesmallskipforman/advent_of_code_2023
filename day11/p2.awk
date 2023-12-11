

BEGIN {delete rows; delete cols; delete points}
/^R.*$/ { for(i=2;i<=NF;i++) {rows[i-1] = $i} }
/^C.*$/ { for(i=2;i<=NF;i++) {cols[i-1] = $i} }
/[^RC]/ {
    for (i=1; i<=NF; i++){if ($i == "#") {
        len = length(points)
        points[len+1][0] = NR-2
        points[len+1][1] = i
    } }
}

function distance(point1, point2) {
    return abs(point1[0] - point2[0]) + abs(point1[1] - point2[1])
}
function abs(v) {
    return v < 0 ? -v : v
}

function max(a, b) { return a > b ? a:b }
function min(a, b) { return a < b ? a:b }
function between(x, a, b) { return min(a, b) < x && x < max(a, b) }

function addDistance(point1, point2, rows, cols, mult) {
    total = 0
    for (i_r in rows) {if (between(rows[i_r], point1[0], point2[0])) { total += mult-1 }}
    for (i_c in cols) {if (between(cols[i_c], point1[1], point2[1])) { total += mult-1 }}
    return total
}

END {
    sum = 0
    for (i=1; i<=length(points); i++) {
        for (j=i+1; j<=length(points); j++) {
                sum += distance(points[i], points[j]) + addDistance(points[i], points[j], rows, cols, 1000000)
        }
    }
    print sum

}
