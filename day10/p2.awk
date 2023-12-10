function loadLine(line, lines) {
    split(line, line_array, "")

    len = length(lines)
    for (i in line_array) {
        lines[len+1][i] = line_array[i]
    }
}

BEGIN {delete lines; delete start}
{
    if (match($0, "S")) {
        start[0] = NR
        start[1] = RSTART
    }
    loadLine($0, lines)


    line_strings[NR] = $0
}

function windowMap(char) {
    switch (char) {
        case "|": return "NS";
        case "-": return "EW";
        case "L": return "NE";
        case "J": return "NW";
        case "7": return "SW";
        case "F": return "SE";
        case "S": return "NSEW";
    }
}

function inverseMap(char) {
    switch (char) {
        case "NS": return "|";
        case "EW": return "-";
        case "NE": return "L";
        case "NW": return "J";
        case "SW": return "7";
        case "SE": return "F";
        case "NSEW": return "S";
    }
}


function deduceStart(start, lines) {
    row = start[0]
    col = start[1]
    n = (windowMap(lines[row-1][col]) ~ /S/)? "N" : ""
    s = (windowMap(lines[row+1][col]) ~ /N/)? "S" : ""
    e = (windowMap(lines[row][col+1]) ~ /W/)? "E" : ""
    w = (windowMap(lines[row][col-1]) ~ /E/)? "W" : ""

    mapping = n s e w
    return inverseMap(mapping)
}


function deducePaths(lines, point, next_pt) {

    n_line = point[0] - 1; n_char = point[1]
    s_line = point[0] + 1; s_char = point[1]
    e_line = point[0]    ; e_char = point[1] + 1
    w_line = point[0]    ; w_char = point[1] - 1

    # window map is relative to to char's position, so from
    # out current position we want the opposite direction
    p_mapped = windowMap(lines[point[0]][point[1]])
    # print p_mapped
    is_path_north = windowMap(lines[n_line][n_char]) ~ /S/ && p_mapped ~ /N/
    is_path_south = windowMap(lines[s_line][s_char]) ~ /N/ && p_mapped ~ /S/
    is_path_east  = windowMap(lines[e_line][e_char]) ~ /W/ && p_mapped ~ /E/
    is_path_west  = windowMap(lines[w_line][w_char]) ~ /E/ && p_mapped ~ /W/

    # TODO: filter by allowed directions of current character

    if(is_path_north && !visited[n_line","n_char]) { next_pt[0] = n_line ; next_pt[1] = n_char }
    if(is_path_south && !visited[s_line","s_char]) { next_pt[0] = s_line ; next_pt[1] = s_char }
    if(is_path_east  && !visited[e_line","e_char]) { next_pt[0] = e_line ; next_pt[1] = e_char }
    if(is_path_west  && !visited[w_line","w_char]) { next_pt[0] = w_line ; next_pt[1] = w_char }
}

# seems like associate array "for-in" loops dont get affected when changing the loop variable within the loop
function printLoop(lines, visited) {


    for (i in lines) {
        filtered_line = ""
        for (j in lines[i]) {
            next_char = (visited[i","j] || lines[i][j] == "I")? lines[i][j] : " "
            filtered_line = filtered_line next_char #(visited[i","j])? lines[i][j] : " "
            # print filtered_line
        }
        print filtered_line
    }
}

END {
    delete visited; delete next_pt; delete current


    start_char = deduceStart(start, lines)
    sub("S", start_char, line_strings[start[0]])

    current[0] = start[0]
    current[1] = start[1]

    visited[start[0]","start[1]] = 1
    while (next_pt[0] != current[0] && next_pt[1] != current[1]) {
        deducePaths(lines, current, next_pt)
        visited[next_pt[0]","next_pt[1]] = 1
        current[0] = next_pt[0]
        current[1] = next_pt[1]
        delete next_pt
    }

    total_interior = 0
    for (i in lines) {
        interior = 0
        for (j=1; j <= length(lines[i]); j++) {

            # match all corners (and treat S as a corner piece as well)
            if (visited[i","j] == 1 && match(substr(line_strings[i], j), /^\||^F\-*J|^L\-*7/ )) {
                interior = !interior
                j += RLENGTH-1
            } else if (interior && !visited[i","j]) {
                total_interior++;
                lines[i][j] = "I"
            }
        }
    }

    # printLoop(lines, visited)
    print total_interior
}
