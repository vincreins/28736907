studio_recording <- function(data) {
    library(dplyr)

    cleaned_data <- data %>% mutate(name = tolower(name)) %>%
        filter(!grepl("live", name, useBytes = TRUE)) %>%
        arrange(name, popularity) %>%
        distinct(name, .keep_all = TRUE)

    return(cleaned_data)
}
