## Prepare plots for report

## Before: summary.csv (output)
## After:  fbar.png, rec.png, ssb.png (report)

library(icesTAF)

mkdir("report")

summary <- read.taf("output/summary.csv")
x <- div(summary, "Rec")

taf.png("fbar")
plot(Fbar~Year, summary, type="l", lwd=2, ylim=lim(x$Fbar), yaxs="i",
     ylab="Fbar (ages 3-8)")
dev.off()

taf.png("rec")
barplot(x$Rec, names=x$Year, ylab="Recruitment (billions of 1-year-olds)")
dev.off()

taf.png("ssb")
plot(SSB~Year, x, type="l", lwd=2, ylim=lim(x$SSB), yaxs="i", ylab="SSB (kt)")
dev.off()
