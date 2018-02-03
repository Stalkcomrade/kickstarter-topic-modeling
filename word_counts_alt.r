library(tidyverse)
library(quanteda)
library(tidyr)
library(topicmodels)
library(tidytext)
library(dplyr)
library(stringr)
library(LDAvis)
library(servr)
library(magrittr)
library(readr)

library(tidytext)

load("~/DigEc/word_counts.RData")

wordcounts_alt = word_counts %>% group_by(words) %>% filter(words %in% vocabulary) %>% summarise(n = sum(n))

wordcounts = myDfm %>% tidy() %>% group_by(term) %>% filter(term %in% vocabulary) %>% summarise(n=sum(count)) 


save(file = "~/DigEc/word_counts.RData", list = c("wordcounts_alt", "wordcounts"))