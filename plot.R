# read csv file
library(readr)
library(dplyr)
library(lubridate)

# price_df <- read_csv(file = 'data/2019-07-27.csv')
# price_df %>% mutate(price_per_mm = `当日成交金额（万元）` / `当日成交面积（㎡）`,
#                     price_per_house = `当日成交金额（万元）` / `当日签约（套）`,
#                     date = ) -> price_df

start_date = ymd('2019-07-15')
days = today() - start_date
day_range <- c(days:1)
today() - day_range -> day_range
paste0('data/',day_range, '.csv') -> file_path

price_df_all <- NULL
for(i in 1: days){
  if(file.exists(file_path[i])){
    price_df <- read_csv(file = file_path[i])
    price_df <- price_df %>% mutate(date = day_range[i])
    
    price_df_all <- rbind(price_df_all, price_df)
  }
}

price_df_all %>% mutate(price_per_mm = `当日成交金额（万元）` / `当日成交面积（㎡）`,
                    price_per_house = `当日成交金额（万元）` / `当日签约（套）`) -> price_df_all

# plot
library(ggplot2)
price_df_all %>% group_by(date) %>%
  summarise(sales_num = sum(`当日签约（套）`)) %>%
  ggplot() + geom_line(aes(x = date, y = sales_num)) + theme(text = element_text(family='Kai'))


price_df_all %>% group_by(date) %>%
  summarise(sales_num = sum(`当日成交面积（㎡）`)) %>%
  ggplot() + geom_line(aes(x = date, y = sales_num)) + theme(text = element_text(family='Kai'))


price_df_all %>% group_by(date) %>%
  summarise(sales_num = sum(`当日成交金额（万元）`)) %>%
  ggplot() + geom_line(aes(x = date, y = sales_num)) + ggtitle('中文')


price_df_all %>%
  filter(镇区 == '东莞市东城区' | 镇区 == '东莞市南城区') %>%
  ggplot() + geom_line(aes(x = date, y = price_per_mm, colour = 镇区))




