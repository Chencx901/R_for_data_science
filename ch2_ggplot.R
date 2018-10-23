# import packages
library(tidyverse)

# data
mpg

# ggplot- scatter plot
ggplot(data = mpg)+geom_point(mapping = aes(x = displ,y = hwy))
# ?mpg - help dataset
# add aesthetic mapping
ggplot(data = mpg)+geom_point(mapping = aes(x = displ,y = hwy,color = class))
# alpha:transparency/shape:shape
# facets - one variable
ggplot(data = mpg)+geom_point(mapping = aes(x = displ,y = hwy))+facet_wrap(~class,nrow = 2) #equal to c('class')
# facets-two vars
ggplot(data = mpg)+geom_point(mapping = aes(x = displ,y = hwy))+facet_wrap(drv~cyl) # equal to c('drv','cyl')
# !!!vars(c('drv','cyl')) create 2 panels seperately!!!

# change to geom_smooth
ggplot(data = mpg)+geom_smooth(mapping = aes(x = displ,y = hwy))