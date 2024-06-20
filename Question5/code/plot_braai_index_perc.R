plot_braai_index_perc <- function(index_braai_monthly,  third_variable) {
    library(zoo)

    merged_sa_braai <- merge(index_braai_monthly, third_variable, by = "month")

    merged_long <- merged_sa_braai %>%
        na.omit() %>%
        pivot_longer(cols = c(perc_change, diff_cpi),
                     names_to = "variable",
                     values_to = "values") %>%
        filter(variable %in% c("perc_change", "diff_cpi")) %>%
        select(month, variable, values)

    ggplot(merged_long, aes(x = as.yearmon(month), y = values, group = variable, color = variable)) +
        geom_line() + ggtitle("Accuracy of the braaibrodje index") +
        xlab("Year") + ylab("Perentage change month over month") + scale_color_hue(labels = c("CPI", "Braaibroodje"))
}
