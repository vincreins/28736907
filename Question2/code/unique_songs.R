unique_songs <- function(data) {
    library(dplyr)

    cleaned_data <- data %>%
        filter(!grepl("-", name, useBytes = TRUE)) %>%
        filter(!grepl("([(])", name, useBytes = TRUE)) %>%
        mutate(name = tolower(name)) %>%
        arrange(name, popularity) %>%
        distinct(name, .keep_all = TRUE)

    return(cleaned_data)
}
