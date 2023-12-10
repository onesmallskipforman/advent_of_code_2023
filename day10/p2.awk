


BEGIN {
    delete network; delete start_nodes; delete end_nodes
    start_regex = "..A"
    end_regex = "..Z"
}


{
    if (NR-1 == 0) { split($0, instructions, ""); next }
    if ($1 ~ start_regex) { start_nodes[length(start_nodes)] = $1 }
    if ($1 ~ end_regex) { end_nodes[length(end_nodes)] = $1 }

    network[$1]["L"] = $2
    network[$1]["R"] = $3
}

# getting tired of this global variable nonsense lol
function allEnds(nodes,   i) {

    for (i in nodes) {
        if (nodes[i] !~ end_regex) { return 0 }
    }
    return 1
}

# TODO: give this script and P1 and easy way to specify all starting patterns and then you can generalize


function findPath(start_str, end_regex, instruction_idx, network, map) {

    steps = 0
    current_node = start_str

    do {
        current_node = network[current_node][instructions[instruction_idx]]
        instruction_idx = (instruction_idx)%length(instructions) + 1
        steps++
    } while (current_node !~ end_regex)
    map[start_str]["end"] = current_node
    map[start_str]["steps"] = steps
    map[start_str]["index"] = steps%length(instructions) + 1
}

END {
    delete map
    for (i in start_nodes) {
        findPath(start_nodes[i], end_regex, 1, network, map)
        # print start_nodes[i]" -> "map[start_nodes[i]]["end"]", "map[start_nodes[i]]["steps"] " steps"
    }
    # print " "
    for (j in start_nodes) {

        end_idx = map[start_nodes[j]]["index"]
        end_str = map[start_nodes[j]]["end"]
        findPath(end_str, end_regex, end_idx, network, map)
        # print end_str" -> "map[start_nodes[j]]["end"]", "map[start_nodes[j]]["steps"] " steps"
    }


    # well it appears the z->z cycles are the same step lengths as the a->z
    # paths required to get to each z, and they are all equal to the length of
    # the instructions, which is 281, which is prime lol, so this solution is
    # extremely input-specific

    # AND each a->z path's steps are 281 * another prime number

    for (i in start_nodes) {
        # print start_nodes[i]
        print map[start_nodes[i]]["steps"]
    }
    # YOU need to pipe this to something that calculates LCM
    # this will work with python3.9+ : python3 -c "import math,sys; vals = list(map(int, sys.stdin.read().split())); print(math.lcm(vals))"
}




# find all individual A->Z paths
# find all individual Z->Z paths
# construct
