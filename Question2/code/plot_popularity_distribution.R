plot_popularity_distribution <- function(data) {
    ggplot(data, aes(x = album, y = popularity, color = album)) +
        geom_boxplot() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
        labs(x = NULL, y = "Popularity", title = "Popularity Distribution of Coldplay Albums") +
        theme(axis.title.x = element_blank(),
              axis.text.x = element_blank(),
              axis.ticks.x = element_blank()) +
        labs(color = 'Album')
}
