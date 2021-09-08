## Run analysis, write model results

## Before: pm (bootstrap/software), control.dat, pm.dat (bootstrap/data/config),
##         endyrn_est.dat, pm_2018_ddc.dat, pm_fmsy_alt.dat,
##         rescaled_cov_2018.dat, scmed.dat, surveycpue.dat,
##         wtage2018.dat (bootstrap/data)
## After:  pm.cor, pm.par, pm.rep (model)

library(icesTAF)

mkdir("model")

## Get model executable
switch(os(),
       Linux=cp("bootstrap/software/pm-linux", "model/pm"),
       Darwin=cp("bootstrap/software/pm-macos", "model/pm"),
       Windows=cp("bootstrap/software/pm-windows.exe", "model/pm.exe"))

## Get model input files
cp("bootstrap/data/*.dat", "model")
cp("bootstrap/data/config/*", "model")

## Run model
setwd("model")
system("./pm -nox -iprint 50")
setwd("..")
