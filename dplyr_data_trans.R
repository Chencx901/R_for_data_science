library(tidyverse)
library(nycflights13)

# filter rows
filter(flights,month == 1,day == 1)
filter(flights,month %in% c(11,12))
# is.na()
df <- tibble(x = c(1,3,NA))
filter(df,is.na(x)|x>=1)

# arrange() - arrange rows，change order
arrange(flights,year,month,day)
arrange(flights,desc(arr_delay)) # desc() descending order

# select - select variabels by names
select(flights,year,month,day)
# same as flights[c('year','month','day')]
#select a group of variables eg:vars between year and carrier
# names(flight) get column names
select(flights,year:carrier) # same as flights[c(1:10)]
select(flights,-(year:day)) # except year and day
# starts_with("abc")/ends_with("xyz")/contains("ijk")/matches("(.)\\1")
# num_range("x",1:3) matches x1,x2,x3
select(flights, time_hour, air_time, everything()) # move to start
# one_of(vars) 

# mutate() - create new variables
flights_sml <- select(flights,year:day,ends_with('delay'),
                      distance,air_time)
mutate(flights_sml,gain = arr_delay-dep_delay,
       hours = air_time/60,
       speed = distance/hours)
transmute(flights_sml,gain = arr_delay-dep_delay,
          hours = air_time/60,
          speed = distance/hours) # show only new vars

# ranking
# min_rank row_number dense_rank percent_rank cume_dist ntile


# summarize() - grouped summaries;
summarize(flights,delay = mean(dep_delay,na.rm = TRUE))
# pair_with group_by()
by_date <- group_by(flights,year,month,day)
summarize(by_date,delay = mean(dep_delay,na.rm=TRUE))
# pipe
# oridnary
by_dest <- group_by(flights,dest)
delay <- summarize(by_dest,count = n(),dist = mean(distance,na.rm = TRUE),
                   delay = mean(arr_delay,na.rm = TRUE))
delay <- filter(delay,count > 20,dest != 'HNL')
ggplot(data = delay,mapping = aes(x = dist,y = delay))+
    geom_point(mapping = aes(size = count),alpha = 1/3)+
    geom_smooth(se = FALSE)
# using pipe
delays <- flights %>% group_by(dest) %>% 
    summarize(count = n(),dist = mean(distance,na.rm = TRUE),
              delay = mean(arr_delay,na.rm = TRUE)) %>% 
    filter(count >= 20,dest!='HNL')

not_cancelled <- flights %>%
    filter(!is.na(dep_delay), !is.na(arr_delay))
delays1 <- not_cancelled %>%
    group_by(tailnum) %>%
    summarize(
        delay = mean(arr_delay, na.rm = TRUE),
        n = n()
    )
delays1 %>% filter(n >25) %>%
    ggplot(mapping = aes(x = n,y = delay))+
    geom_point(alpha = 1/10)

# Lahman example
batting <- as_tibble(Lahman::Batting)
batters <- batting %>% group_by(playerID) %>% summarize(ba = sum(H,na.rm = TRUE)/sum(AB,na.rm = TRUE),ab = sum(AB,na.rm = TRUE))
batters %>%　filter(ab > 100) %>% ggplot(mapping = aes(x = ab,y = ba)) +geom_point()+geom_smooth(se = FALSE)


# summarize function
# mean/sum/count/median/sd/IQR/mad/min/quantile(x,0.25)/max/first/nth(x,2)/last(x)/sum(!is.na)/n_distinct(x)
# ungroup()