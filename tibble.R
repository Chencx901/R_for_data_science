library(tidyverse)
# coerce to tibble
as_tibble(iris)
# create tibble
tibble(x = 1:5,
       y = 1,
       z = x^2+y)
# tribble
tribble(~x,~y,~z,
        #--/--/----
        "a",2,3.6,
        "b",1,8.5)
# subsetting
df <- tibble(
    x = runif(5),
    y = rnorm(5)
)
df$x
df[["x"]]
df[[1]]
# use . in pipe
df %>% .$x
df %>% .[['x']]
# as.data.frame(tb) turn back into dataframe

#######################################################
### data import###
heights <- read_csv('C:/Users/Administrator/Documents/GitHub/r4ds/data/heights.csv')
