library(dplyr)

get_top_baby_names <- function(baby_names, top_n = 25) {
    baby_top <- baby_names %>%
        group_by(Year, Gender, Name) %>%
        summarise(Count = sum(Count), .groups = 'drop') %>%
        group_by(Gender, Year) %>%
        arrange(desc(Count)) %>%
        slice(1:top_n) %>%
        arrange(Year, Gender, desc(Count)) %>%
        mutate(rank = 1:top_n)

    return(baby_top)
}
