library(tidyverse)
library(patchwork)
#theme_set(ggdist::theme_ggdist())
theme_set(theme_minimal())

d <- read_csv("life-expectancy/2019-Table01.csv")
d <- d %>% 
  head(., -2) %>%
  mutate(age_start = sub("\\–.*", "", age))
d$age_start[dim(d)[1]] <- "100"
d$age_start <- as.numeric(d$age_start)

d <- d %>%
  mutate(ex_life_at = ex_life + age_start)

p1 <- ggplot(d, aes(age_start, ex_life_at))
p1 <- p1 + geom_line(size = 0.2) + xlab("Age") + ylab("Life Expectancy") +
  ggtitle("Total population: United States, 2019", subtitle = "Source: CDC")

p2 <- ggplot(d, aes(age_start, surv/100000))
p2 <- p2 + geom_line(size = 0.2) + xlab("Age") + ylab("Next Year Survival") 

print(p1 + p2)

