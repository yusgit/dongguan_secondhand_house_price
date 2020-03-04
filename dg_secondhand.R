## 采集东莞二手房交易数据
## 每天凌晨
##

.libPaths("/home/yusen/R/x86_64-redhat-linux-gnu-library/3.5")
setwd('/home/yusen/dongguan_secondhand')
library(httr)
library(rvest)
library(magrittr)


url <- 'http://dgfc.dg.gov.cn/dgwebsite_v2/Secondhand/DailyStatement.aspx'

cont <- httr::GET(url) 
price <- cont %>% content() %>% html_table() %>% extract2(2)

readr::write_csv(price, path = paste0('data/', Sys.Date(), '.csv'), col_names = FALSE)

#knitr::knit(input = 'test.Rmd', output = '/home/yusen/www/test.html', encoding = 'utf-8')
