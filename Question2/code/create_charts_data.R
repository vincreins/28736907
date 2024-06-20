create_charts_data <- function(charts, spotify_info) {
    charts_spotify <<- merge(x = charts, y = spotify_info, by.x = "song", by.y = "name") %>%
        distinct(song, .keep_all = TRUE)

    charts_duration <<- charts_spotify %>%
        group_by(year) %>%
        summarise(mean_duration = mean(duration_ms, na.rm = TRUE))
    assign("charts_spotify", charts_spotify, envir = parent.frame())
}