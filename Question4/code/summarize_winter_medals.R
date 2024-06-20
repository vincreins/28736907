summarize_winter_medals <- function(winter_data) {

    winter_medals <- winter_data %>%
        group_by(Event, Gender, Medal, Discipline, Year) %>%
        distinct(Event, Country, .keep_all = TRUE) %>%
        ungroup()


    country_medals_winter <- winter_medals %>%
        group_by(Country, Year) %>%
        count(Medal)


    winter_medals_total <- country_medals_winter %>%
        group_by(Country, Year) %>%
        summarise(Medals = sum(n)) %>%
        ungroup()

    return(winter_medals_total)


}
