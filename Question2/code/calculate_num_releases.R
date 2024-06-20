calculate_num_releases <- function(coldplay_data, metallica_data) {

    coldplay_data$identifier <- "Coldplay"
    metallica_data$identifier <- "Metallica"


    merged <- bind_rows(coldplay_data, metallica_data)


    releases <- merged %>%
        group_by(release_date, identifier) %>%
        summarise(num_releases = n())

    return(releases)
}