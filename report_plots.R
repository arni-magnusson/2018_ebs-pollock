## Prepare plots for report

## Before: summary.csv (output)
## After:  fbar.png, rec.png, ssb.png (report)

library(icesTAF)

mkdir("report")

catch <- read.taf("data/catch.csv")
summary <- read.taf("output/summary.csv")

every5 <- seq(1965, 2015, 5)
every10 <- seq(1970, 2010, 10)

taf.png("catch")
catch$bar <- barplot(catch$Catch/1000, xlab="Year", ylab="Catch (kt)",
                     col="forestgreen")
axis(1, catch$bar[catch$Year %in% every10], every10, pos=0)
axis(1, catch$bar[catch$Year %in% every5], FALSE, pos=0)
dev.off()

taf.png("fbar")
plot(Fbar~Year, summary, type="l", lwd=3, col=2, ylim=lim(summary$Fbar),
     yaxs="i", ylab="Fbar (ages 3-8)")
dev.off()

taf.png("rec")
summary$bar <- barplot(summary$Rec/1000, xlab="Year",
                       ylab="Recruitment (billions of 1-year-olds)")
axis(1, summary$bar[summary$Year %in% every10], every10, pos=0)
axis(1, summary$bar[summary$Year %in% every5], FALSE, pos=0)
dev.off()

taf.png("ssb")
plot(SSB~Year, summary, type="l", lwd=3, col=4, ylim=lim(summary$SSB), yaxs="i",
     ylab="SSB (kt)")
dev.off()
