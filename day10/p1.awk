


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

function intermediatePipeMap(char1, char2) {
}



function deducePaths(lines, point, next_pt) {
    # identify connecting pipes (will be exactly 2)

    # deduce missing pipe from the two connecting pipes

    # sx = start[0]
    # sy = start[1]


    # north_regex = /[\|LJ]/
    # south_regex = /[\|7F]/
    # east_regex  = /[\-LF]/
    # west_regex  = /[\-J7]/

    n_line = point[0] - 1; n_char = point[1]
    s_line = point[0] + 1; s_char = point[1]
    e_line = point[0]    ; e_char = point[1] + 1
    w_line = point[0]    ; w_char = point[1] - 1

    # window map is relative to to char's position, so from
    # out current position we want the opposite direction
    p_mapped = windowMap(lines[point[0]][point[1]])
    print p_mapped
    is_path_north = windowMap(lines[n_line][n_char]) ~ /S/ && p_mapped ~ /N/
    is_path_south = windowMap(lines[s_line][s_char]) ~ /N/ && p_mapped ~ /S/
    is_path_east  = windowMap(lines[e_line][e_char]) ~ /W/ && p_mapped ~ /E/
    is_path_west  = windowMap(lines[w_line][w_char]) ~ /E/ && p_mapped ~ /W/

    # TODO: filter by allowed directions of current character

    if(is_path_north && !visted[n_line","n_char]) { next_pt[0] = n_line ; next_pt[1] = n_char }
    if(is_path_south && !visted[s_line","s_char]) { next_pt[0] = s_line ; next_pt[1] = s_char }
    if(is_path_east  && !visted[e_line","e_char]) { next_pt[0] = e_line ; next_pt[1] = e_char }
    if(is_path_west  && !visted[w_line","w_char]) { next_pt[0] = w_line ; next_pt[1] = w_char }

    # print is_path_north, is_path_south, is_path_east, is_path_west
    # print s_line, s_char
    # print lines[s_line][s_char]
    # print windowMap(lines[s_line][s_char])
}

END {

    delete visited; delete next_pt; delete current

    current[0] = start[0]
    current[1] = start[1]
    print start[0], start[1]

    visted[start[0]","start[1]] = 1

    loop_len = 0
    while (next_pt[0] != current[0] && next_pt[1] != current[1]) {
        deducePaths(lines, current, next_pt)
        visted[next_pt[0]","next_pt[1]] = 1
        current[0] = next_pt[0]
        current[1] = next_pt[1]
        print next_pt[0], next_pt[1], lines[next_pt[0]][next_pt[1]]

        print loop_len
        loop_len += 1; delete next_pt
    }
    print int(loop_len/2)
}




#
#
#
# BEGIN {delete network}
#
#
# {
#     if (NR-1 == 0) { split($0, instructions, ""); next }
#     # if (NR-1 == 1) { current_node = $1 }
#     network[$1]["L"] = $2
#     network[$1]["R"] = $3
#     # print $1 $2 $3
#     # for (i in network ) for (j in network[i]) print i, j, network[i][j]
#
#     #
#     # if ($1 != "ZZZ") {
#     #     all_paths_to[$2][length(all_paths_to[$2])] = $1 " L"
#     #     all_paths_to[$3][length(all_paths_to[$3])] = $1 " R"
#     # }
#
#
# }
#
#
#
# END {
#     current_node = "AAA"
#     instruction_idx = 1 # i guess split()'s array is also indexed from 1
#     steps = 0
#     while (current_node != "ZZZ") {
#         current_node = network[current_node][instructions[instruction_idx]]
#         instruction_idx = (instruction_idx)%length(instructions) + 1
#         steps++
#     }
#     print steps
#
#     # for (i in all_paths_to) {
#     #     print "All paths to " i
#     #     for (j in all_paths_to[i]) {
#     #         print all_paths_to[i][j]
#     #     }
#     # }
#
#     # for (i in all_paths_to["ZZZ"]) { print all_paths_to["ZZZ"][i] }
# }
