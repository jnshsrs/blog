library(tidyverse)
titanic <- read_csv(file = "~/miscellaneous-datasets/titanic.csv") 

bootstrap_mean <- function(x, bootstrap_replicates = 1000) {
  n <- length(x)
  v <- c()
  for(i in seq(bootstrap_replicates)) {
    bootstrap_samples <- sample(x = x, size = n, replace = TRUE)
    m <- mean(bootstrap_samples, na.rm = TRUE)
    v <- append(v, m)
  }
  return(v) 
}

bootstrap_se <- function(x) {
  sd(bootstrap_mean(x))
}

bootstrap_ci <- function(x, bootstrap_replicates) {
  bootstrap_means <- bootstrap_mean(x)
  ci <- sd(bootstrap_means) * 1.96 * c(-1, 1) + mean(x)
  print(glue::glue("Mean: {round(mean(x), 2)} 95% CI({round(ci[1], 2)} - {round(ci[2], 2)})"))
  return(ci)
}

x <- rnorm(1000)
cis <- bootstrap_ci(x)
ses <- bootstrap_se(x)

titanic %>% 
  group_by(sex) %>% 
  summarise(mean = mean(age, na.rm = TRUE), se = bootstrap_se(age), n = n()) %>% 
  mutate(ci = se * 1.96) %>% 
  mutate(lower = mean - ci, upper = mean + ci)


plot(c(1, 1) , Hmisc::smean.cl.normal(x = titanic$age)[c(2, 3)], type = "l", ylim = c(25, 45))
points(1, 29.8, pch = 20)
  
par(mfrow = (c(1, 1)))
