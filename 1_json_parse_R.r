#!/usr/bin/env Rscript 

args = commandArgs(trailingOnly=TRUE)

library(tidyjson)
library(tidyverse)
library(magrittr)

# df1 = read_csv("/home/stlk/Desktop/DigEc_data/Kickstarter_2015-11-01T14_09_04_557Z.zip_folder/Kickstarter.csv")
df = read_csv(file = args[1])
df$document.id = 1:nrow(df)
jj = tibble()

# setdiff(colnames(dfn), colnames(df1))
# dfn = read_csv("/home/stlk/Desktop/DigEc_data/Kickstarter_2017-10-15T10_20_38_271Z.zip_folder/Kickstarter.csv")
# df = read_csv("/home/stlk/Desktop/DigEc_data/Kickstarter_2016-01-28T09_15_08_781Z.zip_folder/Kickstarter.csv")


# Creator

j_c = tidyjson::as.tbl_json(as.character(df$creator))
j_c %<>% spread_values(creator_id = jnumber("id"), creator_name = jstring("name")) %>%
  enter_object("urls") %>% enter_object("web") %>% spread_values(creator_url = jstring("user"))

# Location

df$location[is.na(df$location)] = "{}"

j_l = df$location %>% tidyjson::as.tbl_json()
j_l %<>% gather_keys() %>% append_values_string()
j_l %<>% as.data.frame() %>% tidyr::spread(key = "key", value = "string")
j_l %<>% dplyr::select(-urls)

colnames(j_l)[-1] = str_c("location_", colnames(j_l)[-1])

# Category

df$category[is.na(df$category)] = "{}"

j_ct = df$category %>% tidyjson::as.tbl_json()
j_ct %<>% gather_keys() %>% append_values_string()
j_ct %<>% as.data.frame() %>% tidyr::spread(key = "key", value = "string")
j_ct %<>% dplyr::select(-urls)

colnames(j_ct)[-1] = str_c("category_", colnames(j_ct)[-1])

# Urls

df$urls[is.na(df$urls)] = "{}"

j_u = df$urls %>% tidyjson::as.tbl_json()
j_u %<>% enter_object("web") %>% spread_values(url_project = jstring("project"), 
                                              url_rewards = jstring("rewards"))


df %<>% dplyr::select(-c(creator, category, location, urls, photo, profile))

jj = full_join(df, j_c, by = "document.id") %>% full_join(j_l, by = "document.id") %>% full_join(j_ct, by = "document.id") %>% 
  full_join(j_u, by = "document.id")

write_csv(x = jj, path = str_c("/home/stlk/Desktop/DigEc_data_parsed/", args[2], ".csv"))
