library(tidyverse)

# gather-Gather columns into key-value pairs
table4a
table4a %>% gather('1999','2000',key = 'year',value = 'cases') # 1999 应该是列值，key 重新给命名;原先的value应该归到cases列
# key : name of variable whose values form the colunms names /value:name of variable whose values spread over cells

# spread - Spread a key-value pair across multiple columns
table2
table2 %>% spread(key = type,value = count) # key 展开,对应值填充

# spearate - one col into multi
table3
table3 %>% separate(rate,c("cases","population"),convert = TRUE)

# unite - multi into one
table5
table5 %>% unite(col = new,century,year,sep = '')

# missing value
stocks <- tibble(
    year = c(2015,2015,2015,2015,2016,2016,2016),
    qtr = c(1,2,3,4,2,3,4),
    return = c(1.88,0.59,0.35,NA,0.92,0.17,2.66)
) 
stocks %>% spread(year,return) %>% gather(year,return,'2015','2016',na.rm = TRUE)

# combine - Complete a data frame with missing combinations of data.
stocks %>% complete(year,qtr)
#fill() - last obs forward

######################## case study ########################
who %>% names() # get names

# seems "new_sp_m014"-"newrel_f65" like values not variables?? gather
who1 <-who %>% gather(new_sp_m014:newrel_f65,key = "key",value = "cases",na.rm = TRUE)
who1 %>% count(cases)
who2 <- who1 %>% mutate(key = stringr::str_replace(key,"newrel","new_rel"))
who3 <- who2 %>% separate(key,into = c("new","type","sexage"),sep = "_") # separate 
who4 <- who3 %>% select(-new,-iso2,-iso3)
who5 <- who4 %>% separate(sexage,into = c('sex','age'),sep = 1)
