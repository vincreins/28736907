
movie_appearance_change <- function(data, HBO_Credits, HBO_Titles){
    hbo <- HBO_Credits %>%
        inner_join(
            HBO_Titles %>%
                group_by(release_year) %>%
                arrange(desc(tmdb_popularity)) %>%
                slice(1:5),
            by = "id"
        )
    data <- data %>%
        mutate(in_movie = ifelse(
            Name %in% hbo$first_name & (Year - 1 %in% hbo$release_year | Year %in% hbo$release_year),
            1,
            0
        ))

    Popular_Names_with_following_year <- data %>%
        left_join(hbo %>%
                      mutate(following_year = release_year + 1) %>%
                      select(first_name, following_year),
                  by = c("Name" = "first_name", "Year" = "following_year")) %>%
        group_by(Name) %>%
        arrange(Year) %>%
        mutate(change_in_count = Count - lag(Count),
               relative_change = ifelse(!is.na(Count) & !is.na(lag(Count)),
                                        ((Count - lag(Count)) / lag(Count)) * 100, NA_real_)) %>%
        ungroup() %>%
        filter(!is.na(change_in_count)) %>%
        na.omit()

    model <- lm(relative_change ~ in_movie, data = Popular_Names_with_following_year)

    print(summary(model))

    plot <- ggplot(Popular_Names_with_following_year, aes(x = Year, y = relative_change, color = factor(in_movie))) +
        geom_line() +
        labs(x = "Year", y = "Relative Change (%)", color = "In Movie") +
        theme_minimal()

    print(plot)
}
