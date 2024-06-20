long_braai <- function(retailer) {
    braai_price <- retailer %>%
        select(-c(product_hash, product_name)) %>%
        group_by(price_date) %>%
        distinct(category, .keep_all = TRUE)

    wide_df <- braai_price %>%
        spread(key = category, value = prices) %>%
        na.omit()

    long_df <- pivot_longer(wide_df,
                            cols = -price_date,
                            names_to = "category",
                            values_to = "prices")

    return(long_df)
}