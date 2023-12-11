BEGIN {FS=""; delete points}

{
    for (i=1; i<=NF; i++){ if ($i == "#") {
        len = length(points)
        points[len+1][0] = NR
        points[len+1][1] = i
    } }
}

function abs(v) { return v < 0 ? -v : v }
function distance(point1, point2) {
    return abs(point1[0] - point2[0]) + abs(point1[1] - point2[1])
}

END {
    sum = 0
    for (i=1; i<=length(points); i++) {
        for (j=i+1; j<=length(points); j++) {
                sum += distance(points[i], points[j])
        }
    }
    print sum
}
