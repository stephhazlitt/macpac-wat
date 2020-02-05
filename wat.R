library(readxl)
library(janitor)
library(dplyr)
library(tidyr)
library(purrr)
library(fs)
library(stringr)

## load and tidy xls tally data 2017-2019 -----------------------------------

#take a peek at files & derive tidy steps
wat2018 <- read_xlsx("data/WAT Tally 2018.xlsx") %>%
  clean_names() %>% 
  select(teacher, total_counted) %>% 
  drop_na() %>% 
  filter(teacher != "Total") %>% 
  mutate(year = 2018,
         total_counted = as.numeric(total_counted)) 


#filepaths for 2014-2019
wat_files <- dir_ls("data")

#function to read and tidy all files
tidy_wat <- function(filepath){

  fileyear <- str_sub(filepath, 16, 19)
    
    read_excel(filepath) %>% 
    clean_names() %>% 
    select(teacher, total_counted) %>% 
    drop_na() %>% 
    filter(teacher != "Total") %>% 
    mutate(year = fileyear,
           total_counted = as.numeric(total_counted)) 
}

#testing
# filepath <- wat_files[1]
# tidy_wat(filepath)

#map over files, tidy & concatenate into a df
wat_data <- wat_files %>% 
  map_dfr(tidy_wat)


## summaries -----------------------------------------------------------------

wat_data %>% 
  group_by(year) %>% 
  summarise(total_raised = sum(total_counted),
            number_particpants = n())


