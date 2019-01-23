s <- 1:12

pareto <- function(s) {
m <- NULL
z <- NULL
i <- 0

while(length(m) != length(s)) {
  i <- i + 1
  n <- sample(x = s, size = 1)
  idx <- i
  if(!n %in% m){
    k <- i
    z <- append(z, k)
    m <- append(m, n)
  }
}

tibble(m, z) %>% 
  select(z) %>% 
  slice(12)
}

n <- map(1:10000, ~pareto(s = 1:12)) %>% unlist

tibble(n) %>% 
  ggplot(aes(x = n)) +
  geom_histogram(aes(y=..count../sum(..count..))) +
  geom_density(bw = 4)


