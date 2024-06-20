filter_cpi_data <- function(cpi_sa) {
    filtered_cpi <- cpi_sa %>%
        filter(grepl("CPS00000", H03)) %>%
        distinct(H03, .keep_all = TRUE) %>%
        t() %>%
        as.data.frame() %>%
        slice(-(1:11)) %>%
        rownames_to_column(var = "month")

    return(filtered_cpi)
}