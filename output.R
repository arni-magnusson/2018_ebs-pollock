## Extract results of interest, write TAF output tables

## Before: pm.cor, pm.par, pm.rep (model)
## After:  fatage.csv, natage.csv, summary.csv (output)

library(icesTAF)
source("utilities_output.R")

mkdir("output")

results <- read_admb("model/pm")
ages <- 1:ncol(results$N)

## Extract F, N, summary
fatage <- data.frame(Year=results$Yr, results$F)
names(fatage) <- c("Year", ages)

natage <- data.frame(Year=results$Yr, results$N)
names(natage) <- c("Year", ages)

B3plus <- head(results$fit$est[results$fit$names=="age_3_plus_biom"], -2)
summary <- data.frame(Year=results$Yr, B3plus=B3plus, SSB=results$SSB[,2],
                      Rec=results$R[,2], Fbar=rowMeans(results$F[,3:8]))

## Export
write.taf(fatage, "output/fatage.csv")
write.taf(natage, "output/natage.csv")
write.taf(summary, "output/summary.csv")
