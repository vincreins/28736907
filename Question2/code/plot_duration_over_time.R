plot_duration_over_time <- function(charts_spotify, coldplay_cleaned, metallica_cleaned) {
    library(lubridate)

    charts_spotify$Year <- year(as.Date(charts_spotify$date))


    charts_duration <- charts_spotify %>%
        group_by(Year) %>%
        summarise(mean_duration = mean(duration_ms, na.rm = TRUE))
    charts_duration$identifier <- "Charts"


    coldplay_cleaned$Year <- year(as.Date(coldplay_cleaned$release_date))
    metallica_cleaned$Year <- year(as.Date(metallica_cleaned$release_date))


    coldplay_duration <- coldplay_cleaned %>%
        group_by(Year) %>%
        summarise(mean_duration = mean(duration_ms, na.rm = TRUE))
    coldplay_duration$identifier <- "Coldplay"

    metallica_duration <- metallica_cleaned %>%
        group_by(Year) %>%
        summarise(mean_duration = mean(duration, na.rm = TRUE))
    metallica_duration$mean_duration <- metallica_duration$mean_duration * 1000
    metallica_duration$identifier <- "Metallica"


    merged2 <- bind_rows(coldplay_duration, metallica_duration, charts_duration)


    ggplot(merged2, aes(x = Year, y = mean_duration, group = identifier, color = identifier)) +
        geom_line(size = 1) +
        labs(x = "Release Date", y = "Mean Duration (ms)", title = "Song Duration Over Time") +
        theme_minimal() +
        labs(color = 'Source')
}