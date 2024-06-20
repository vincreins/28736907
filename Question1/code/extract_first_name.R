library(dplyr)

extract_first_name <- function(data, Name_column){
    data <- data %>%
        mutate(first_name = sapply(strsplit(as.character(data[[Name_column]]), " "), `[`, 1))
}
