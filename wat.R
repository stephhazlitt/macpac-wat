library(readxl)
library(janitor)
library(dplyr)
library(tidyr)


## load and tidy xls tally data 2017-2019 -----------------------------------
wat2019 <- read_xls("data/WAT Tally 2019.xls") %>%
  clean_names() %>% 
  select(teacher, total_counted) %>% 
  drop_na() %>% 
  filter(teacher != "Total") %>% 
  mutate(year = 2019) 

wat2018 <- read_xlsx("data/WAT Tally 2018.xlsx") %>%
  clean_names() %>% 
  select(teacher, total_counted) %>% 
  drop_na() %>% 
  filter(teacher != "Total") %>% 
  mutate(year = 2018) 

wat2017 <- read_xlsx("data/WAT Tally 2017.xlsx") %>%
  clean_names() %>% 
  select(teacher, total_counted) %>% 
  drop_na() %>% 
  mutate(year = 2017) 


## combine data frames -------------------------------------------------------
wat_data <- wat2017 %>% 
  bind_rows(wat2018) %>% 
  bind_rows(wat2019)


## summaries -----------------------------------------------------------------

