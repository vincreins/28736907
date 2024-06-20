perform_gender_correlation <- function(data) {
    library(knitr)
    splitted_gender <- split(data, data$Gender)
    corr <- cor.test(x = splitted_gender$M$Count, y = splitted_gender$F$Count, method = "spearman")


    rho <- corr$estimate
    p_value <- corr$p.value


    correlation_table <- data.frame(
        "Correlation Coefficient (rho)" = rho,
        "p-value" = p_value
    )


    print(knitr::kable(correlation_table, format = "markdown"))


    return(corr)
}