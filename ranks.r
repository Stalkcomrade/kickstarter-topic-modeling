#!/usr/bin/env Rscript 

load(file = "/home/stlk/Desktop/DigEc_scripts/df_with_creators.RData")

dfc$exp = unlist(by(dfc, dfc$creator_id, 
                    function(x) rank(dfc$state_changed_at, ties.method = "first")))

save(file = "~/DigEc/df_with_creators.RData", list = c("df_with_creators"))
