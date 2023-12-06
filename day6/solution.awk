BEGIN {FS=":"}
{
    table[$1] = $2
}

END {

    split(table["Time"], times, " ")
    split(table["Distance"], distances, " ")

    for (i in times) {
        t = times[i]
        d = distances[i]

        discriminant = t^2 - 4*d
        if (discriminant <=0) { margins[i] = 0 }
        else {
            sqt_d = sqrt(discriminant)
            lower = (t-sqt_d)/2
            upper = (t+sqt_d)/2

            lower = int(lower)+1
            upper = (upper%1 == 0)? upper-1 : int(upper)

            margins[i] = upper-lower+1
        }

    }
    for (i in margins) { print margins[i] }
}
