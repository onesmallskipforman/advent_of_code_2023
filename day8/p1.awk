


BEGIN {delete network}


{
    if (NR-1 == 0) { split($0, instructions, ""); next }
    # if (NR-1 == 1) { current_node = $1 }
    network[$1]["L"] = $2
    network[$1]["R"] = $3
    # print $1 $2 $3
    # for (i in network ) for (j in network[i]) print i, j, network[i][j]

    #
    # if ($1 != "ZZZ") {
    #     all_paths_to[$2][length(all_paths_to[$2])] = $1 " L"
    #     all_paths_to[$3][length(all_paths_to[$3])] = $1 " R"
    # }


}



END {
    current_node = "AAA"
    instruction_idx = 1 # i guess split()'s array is also indexed from 1
    steps = 0
    while (current_node != "ZZZ") {
        current_node = network[current_node][instructions[instruction_idx]]
        instruction_idx = (instruction_idx)%length(instructions) + 1
        steps++
    }
    print steps

    # for (i in all_paths_to) {
    #     print "All paths to " i
    #     for (j in all_paths_to[i]) {
    #         print all_paths_to[i][j]
    #     }
    # }

    # for (i in all_paths_to["ZZZ"]) { print all_paths_to["ZZZ"][i] }
}
