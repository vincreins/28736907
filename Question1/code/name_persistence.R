library(dplyr)

name_persistence <- function(baby_names, years, intercept){
    baby_years <- baby_names %>% mutate(Year_future = Year - years)
    baby_future <- merge(baby_names, baby_years, by.x = c("Year", "Name"), by.y = c("Year_future", "Name")) %>%
        group_by(Year) %>%
        summarise(corr = cor.test(Count.x, Count.y, method = "spearman")$estimate) %>%
        ungroup()

    ts_plot <- ggplot(baby_future, aes(x = Year, y = corr)) +
        geom_line(color = "blue") +  # Adjust line color
        labs(title = "Time Series of Rank Correlation",
             x = "Year",
             y = "Spearman Rank Correlation") +
        geom_vline(xintercept = intercept, linetype = "dashed", color = "red") +
        theme_minimal() +
        theme(
            plot.title = element_text(size = 16, face = "bold"),
            axis.title.x = element_text(size = 14),
            axis.title.y = element_text(size = 14),
            axis.text.x = element_text(size = 12),
            axis.text.y = element_text(size = 12),
            legend.position = "none"
        )

        ts_plot
    }


