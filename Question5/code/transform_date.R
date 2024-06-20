transform_date <- function(date_str) {
    year <- substr(date_str$month, 5, 8)
    month <- substr(date_str$month, 3, 4)
    return(paste0(year, "-", month))
}
