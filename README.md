# 2018 Eastern Bering Sea walleye pollock

## Assessment report

https://apps-afsc.fisheries.noaa.gov/REFM/docs/2018/BSAI/2018EBSpollock.pdf

## How to run

Install the icesTAF package, version >=2.1 from CRAN.

Then open R in the `2018_ebs-pollock` directory and run:

```
library(icesTAF)
taf.bootstrap()
sourceAll()
```

Instead of `sourceAll` one can run

```
makeAll()
```

to only run scripts as needed.
