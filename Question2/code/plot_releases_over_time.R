plot_releases_over_time <- function(data) {
    ggplot(data, aes(x = as.Date(release_date, "%Y"), y = num_releases, group = identifier, color = identifier)) +
        geom_line(size = 1) +
        labs(x = "Release Date", y = "Titles Released", title = "Releases Over Time") +
        theme_minimal() +
        labs(color = 'Band')
}