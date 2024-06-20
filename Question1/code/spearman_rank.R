spearman_rank <- function(Data, Gender, Year){
    current_year <- Data %>%
        filter(Gender == Gender, Year == Year) %>%
        arrange(desc(Count)) %>% mutate(Rank = row_number()) %>%
        select(Name, Rank)

    correlations <- data.frame()

    for(next_year in (Year+1):(Year+3)){
        next_year_data <- Data %>%
            filter(Gender == Gender, Year == next_year) %>%
            arrange(desc(Count)) %>%
            mutate(Rank = row_number()) %>%
            select(Name, Rank)

        merged_data <- current_year %>%
            inner_join(next_year_data, by ="Name",
                       suffix = c(".current", ".next"))

        spearman_correlation <- cor.test(merged_data$Rank.current,
                                         merged_data$Rank.next,
                                         method = "spearman")
        correlations <- rbind(correlations, data.frame(Year = Year, next_year = next_year, spearman_correlation = spearman_correlation$estimate))

    }
    return(correlations)
}


