transform_ingredients <- function(index_ingredients) {
    index_ingredients %>%
        mutate(Ingredient = sapply(strsplit(as.character(type), " "), function(x) paste(x[-1], collapse = " ")))
}