#!/usr/bin/env Rscript 

library(readr)

args = commandArgs(trailingOnly=TRUE)
df <- read_csv(args[1]) 
df$path = args[1]

write_csv(args[1], x = df)


