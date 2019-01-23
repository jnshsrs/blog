sim_chisq <- function(data, expected, r = 1e4, fun = rpois, ...) {
  
  n <- sum(data)
  r <- 1e3
  
  test_stat <- sum((data - expected)^2 / expected)
  
  # binom
  # sim <- map(seq(r), ~ map_int(expected[- length(expected)], ~rbinom(prob = .x/n, n = 1, size = n)))
  # sim <- map(seq(r), ~ map_int(expected[- length(expected)], ~rbinom(prob = .x/n, n = 1, size = n)))
  
  # dbinom
  sim <- map(seq(r), ~ map_int(expected[- length(expected)], ~qbinom(prob = .x/n, size = n, p = runif())))
  
  sim <- map(sim, ~ append(.x, n - sum(.x)))
  
  sim_chisq <- map_dbl(sim, ~ sum((.x - expected)^2/expected))
  
  hist(sim_chisq, freq = F, las = 1, breaks = 100)
  
  chisq.test(x = data, p = expected, rescale.p = TRUE)
  
  p_value_sim <- sum(sim_chisq > test_stat) / length(sim_chisq)
  
  p_value_exact <- chisq.test(x = data, p = expected, rescale = TRUE) %>% pluck("p.value")
  
  den <- density(x = sim_chisq, from = 0, bw = 1.2)
  
  list <- list("test_stat" = test_stat,
               "p_value_sim" = p_value_sim,
               "p_value_exact" = p_value_exact,
               "density" = den)
  
  return(list)
  
}


data <- c(130, 120, 80, 70)
expected <- rep(100, 4)
simulation <- sim_chisq(data, expected)
lines(simulation$density)
x <- seq(0, 30, by = .1)
y <- dchisq(x = x, df = 3)

lines(x, y, col = "red")



# übergeordnete Funktion berechnet test statistik
# set test statistik

# set generator


# generator function
# takes data

# generate
# simulation


# Binomial Distribution
expected <- table(mtcars$cyl) %>% prop.table()
data <- table(mtcars$cyl)
data <- c(10, 5, 17) 

sim_chisq <- function(data, expected, r = 1e4, fun = rpois, ...) {
  
  n <- sum(data)
  p <- expected
  expectd <- p * n
  reps <- 20
  
  test <- chisq.test(x = data, p = expected)
  test_stat <- test$statistic
  p_value <- test$p.value
  
  mu <- n * p
  sigma <- mu * (1 - p)
  
  rnorm(n = 1, sigma[1])^2
  rnorm(n = 1, sigma[2])^2
  rnorm(n = 1, sigma[3])^3
  
  sim <- map(.x = sigma, ~rnorm(n = 500, mean = 0, .x)^2)
  hist(reduce(sim, `+`))
  
  
  # quadrieren
  
  # 
  
  chi_stat <- function(o, e) (o - e)^2 / e
  sim <- map2(sim, expected * n, chi_stat)
  sim <- reduce(sim, `+`)
  
  hist(sim, freq = FALSE, las = 1, breaks = sqrt(20000))
  x <- seq(0, 60, by = .1)
  lines(x, dchisq(x = x, df = 8), col = "red")
  
  p_value
  sum(sim > test_stat) / length(sim)
  
  # invoke_map(list(, rnorm), list(list(n = 10), list(n = 5)))
  
  # pois
  sim <- map(seq(r), ~ map_dbl(expected[- length(expected)], ~rpois(n = 1, lambda = .x)))
  
  # binom
  # sim <- map(seq(r), ~ map_int(expected[- length(expected)], ~rbinom(.x/n, n = 1, size = n)))
  
  sim <- map(sim, ~ append(.x, n - sum(.x)))
  
  sim_chisq <- map_dbl(sim, ~ sum((.x - expected)^2/expected))
  
  hist(sim_chisq, main = glue::glue("df={df}"), freq = F, las = 1, breaks = 100, ...)
  
  chisq.test(x = data, p = expected, rescale.p = TRUE)
  
  p_value_sim <- sum(sim_chisq > test_stat) / length(sim_chisq)
  
  p_value_exact <- chisq.test(x = data, p = expected, rescale = TRUE) %>% pluck("p.value")
  
  list <- list("test_stat" = test_stat, "p_value_sim" = p_value_sim, "p_value_exact" = p_value_exact, "df" = df)
  
  return(list)
  
}
# Binomial Distribution
expected <- table(mtcars$cyl) %>% prop.table()
data <- table(mtcars$cyl)
data <- c(10, 5, 17) 

sim_chisq <- function(data, expected, r = 1e4, fun = rpois, ...) {
  
  n <- sum(data)
  p <- expected
  expectd <- p * n
  reps <- 20
  
  test <- chisq.test(x = data, p = expected)
  test_stat <- test$statistic
  p_value <- test$p.value
  
  mu <- n * p
  sigma <- mu * (1 - p)
  
  rnorm(n = 1, sigma[1])^2
  rnorm(n = 1, sigma[2])^2
  rnorm(n = 1, sigma[3])^3
  
  sim <- map(.x = sigma, ~rnorm(n = 500, mean = 0, .x)^2)
  hist(reduce(sim, `+`))
  
  
  # quadrieren
  
  # 
  
  chi_stat <- function(o, e) (o - e)^2 / e
  sim <- map2(sim, expected * n, chi_stat)
  sim <- reduce(sim, `+`)
  
  hist(sim, freq = FALSE, las = 1, breaks = sqrt(20000))
  x <- seq(0, 60, by = .1)
  lines(x, dchisq(x = x, df = 8), col = "red")
  
  p_value
  sum(sim > test_stat) / length(sim)
  
  # invoke_map(list(, rnorm), list(list(n = 10), list(n = 5)))
  
  # pois
  sim <- map(seq(r), ~ map_dbl(expected[- length(expected)], ~rpois(n = 1, lambda = .x)))
  
  # binom
  # sim <- map(seq(r), ~ map_int(expected[- length(expected)], ~rbinom(.x/n, n = 1, size = n)))
  
  sim <- map(sim, ~ append(.x, n - sum(.x)))
  
  sim_chisq <- map_dbl(sim, ~ sum((.x - expected)^2/expected))
  
  hist(sim_chisq, main = glue::glue("df={df}"), freq = F, las = 1, breaks = 100, ...)
  
  chisq.test(x = data, p = expected, rescale.p = TRUE)
  
  p_value_sim <- sum(sim_chisq > test_stat) / length(sim_chisq)
  
  p_value_exact <- chisq.test(x = data, p = expected, rescale = TRUE) %>% pluck("p.value")
  
  list <- list("test_stat" = test_stat, "p_value_sim" = p_value_sim, "p_value_exact" = p_value_exact, "df" = df)
  
  return(list)
  
}
