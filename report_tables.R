## Prepare tables for report

## Before: catage.csv, catch.csv, maturity.csv, natmort.csv, survey_at.csv,
##         wcatch.csv, wstock.csv (data), fatage.csv, natage.csv,
##         summary.csv (output)
## After:  catage.csv, catch.csv, fatage.csv, lifehistory.csv, natage.csv,
##         summary.csv, survey_at.csv, wcatch.csv, wstock.csv (report)

library(icesTAF)

mkdir("report")

## 1  Data

## catage (plus group, row sum, col mean, divide, round)
catage <- read.taf("data/catage.csv")
catage$"14" <- catage$"14" + catage$"15"
catage <- plus(catage[c("Year",as.character(1:14))])
catage$Total <- rowSums(catage[c(as.character(1:13),"14+")])
catage <- rbind(catage, colMeans(catage))
catage[nrow(catage),1] <- "Avg"
catage[-1] <- rnd(div(catage[-1]), digits=c(rep(1,14),0))
write.taf(catage, "report/catage.csv")

## catch (col mean, round)
catch <- read.taf("data/catch.csv")
catch <- rbind(catch, colMeans(catch[catch$Year %in% 1977:2017,]))
catch[nrow(catch),1] <- "1977-2017 mean"
catch$Catch <- round(catch$Catch)
write.taf(catch, "report/catch.csv")

## lifehistory (combine, round)
maturity <- read.taf("data/maturity.csv")
natmort <- read.taf("data/natmort.csv")
lifehistory <- data.frame(Quantity=c("M","Pmat"),
                          rbind(M=natmort,Pmat=maturity), check.names=FALSE)
lifehistory[-1] <- round(lifehistory[-1], 2)
write.taf(lifehistory, "report/lifehistory.csv")

## survey_at (plus group, row sum, col mean, col median, round)
survey_at <- read.taf("data/survey_at.csv")
survey_at$"10" <- rowSums(survey_at[c(as.character(10:15))])
survey_at <- plus(survey_at[c("Year",as.character(1:10))])
survey_at$"2+" <- rowSums(survey_at[c(as.character(2:9),"10+")])
survey_at$Total <- rowSums(survey_at[c(as.character(1:9),"10+")])
avg <- apply(survey_at, 2, mean)
med <- apply(survey_at, 2, median)
survey_at <- rbind(survey_at, avg, med)
survey_at[c(nrow(survey_at)-1, nrow(survey_at)), 1] <- c("Avg.", "Med.")
survey_at[-1] <- round(survey_at[-1])
write.taf(survey_at, "report/survey_at.csv")

## wcatch (trim year, col mean, round)
wcatch <- read.taf("data/wcatch.csv")
wcatch <- wcatch[wcatch$Year >= 1990,]
wcatch <- rbind(wcatch, colMeans(wcatch[-1,]))
wcatch[1,1] <- "1964-1990"
wcatch[nrow(wcatch),1] <- "Avg"
wcatch[-1] <- round(wcatch[-1], 3)
write.taf(wcatch, "report/wcatch.csv")

## wstock (col mean, round)
wstock <- read.taf("data/wstock.csv")
wstock <- rbind(wstock, colMeans(wstock))
wstock[nrow(wstock),1] <- "Avg"
wstock[-1] <- round(wstock[-1], 3)
write.taf(wstock, "report/wstock.csv")

## 2  Output

## fatage (round)
fatage <- read.taf("output/fatage.csv")
fatage[-1] <- round(fatage[-1], 3)
write.taf(fatage, "report/fatage.csv")

## natage (plus group, divide, round)
natage <- read.taf("output/natage.csv")
natage$"10" <- rowSums(natage[as.character(10:15)])
natage <- plus(natage[c("Year",as.character(1:10))])
natage[-1] <- round(div(natage[-1]), 2)
write.taf(natage, "report/natage.csv")

## summary (reorder, trim column, round)
summary <- read.taf("output/summary.csv")
summary <- round(summary[c("Year", "SSB", "Rec", "B3plus")])
write.taf(summary, "report/summary.csv")
