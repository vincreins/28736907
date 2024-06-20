plot_ingredients <- function(data) {
    index_ingredients <- data %>% filter(grepl("Index", type))
    ingredients <- transform_ingredients(index_ingredients)

    assign("ingredients", ingredients, envir = parent.frame())

    ggplot(ingredients, aes(x = date, y = value, group = Ingredient, color = Ingredient)) +
        geom_line() + ggtitle("Price changes of braaibroodje ingredients over time") +
        xlab("Year") + ylab("Index")



}
