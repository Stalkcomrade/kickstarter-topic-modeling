#!/usr/bin/env Rscript 

library(quanteda)
library(tidyr)
library(topicmodels)
library(tidytext)
library(dplyr)
library(stringr)
library(LDAvis)
library(servr)


load("~/DigEc/stories_dtm.RData")

ap_lda = LDA(stories_dtm,
             k=10,
             control = list(seed = 1234, verbose=TRUE))


save(file = "~/DigEc/ap_lda.RData", list = c("ap_lda"))