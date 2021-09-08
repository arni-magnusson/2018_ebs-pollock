# Eastern Bering Sea walleye pollock

## Assessment report

https://www.afsc.noaa.gov/refm/stocks/plan_team/2018/EBSPollock.pdf

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

## To do

- [x] Simplify model, so it requires 4 instead of 7 `*.dat` files.

- [ ] Complete metadata entries in `DATA.bib`.

- [x] Have `data.R` extract data tables from `pm_2018_ddc.dat` and create
      `*.csv` files that match the data tables from the assessment report.

- [x] Have `output.R` extract output tables from ADMB files and create `*.csv`
      that match the output tables from the assessment report.

- [x] Have `report.R` produce formatted tables and minimal plots for report.

- [ ] Consider scripting how initial data were preprocessed from underlying
      data.

- [ ] Consider experimenting with a dynamic document, R Markdown or the like.
