plot_largest_contributors <- function(commit_clean) {

    largest_contributors <- commit_clean %>%
        arrange(desc(Total.bilateral.commitments...billion.)) %>%
        slice(1:10)

    ggplot(largest_contributors, aes(x = reorder(Country, desc(Total.bilateral.commitments...billion.)), y = Total.bilateral.commitments...billion., fill = factor(EU.member))) +
        scale_fill_manual(name = "EU Member", values = c("0" = "grey", "1" = "blue")) +
        geom_bar(stat = "identity") +
        labs(x = "Country", y = "Total Bilateral Commitments ($ billion)",
             title = "Highest Contributors to Ukraine's Aid") +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
}