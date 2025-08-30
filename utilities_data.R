extractData <- function(datafile)
{
  txt <- readLines(datafile)
  txt <- gsub("\t", " ", txt)

  ## 0  Dimensions
  ## Variable names from pm.tpl
  styr <- scan(text=txt, skip=grep("Begin year",txt), nlines=1, quiet=TRUE)[1]
  styr_bts <- scan(text=txt, skip=grep("Begin year",txt), nlines=1,
                   quiet=TRUE)[2]
  endyr <- scan(text=txt, skip=grep("Endyr",txt), n=1, quiet=TRUE)
  nyrs <- endyr - styr + 1
  nyrs_bts <- endyr - styr_bts + 1
  nages <- scan(text=txt, skip=grep("Number of age groups",txt), n=1,
                quiet=TRUE)

  ## 1  Maturity
  maturity <- read.table(text=txt, skip=grep("Maturity at age",txt), nrow=1)
  names(maturity) <- 1:nages

  ## 2  Catch weights
  wcatch <- data.frame(Year=styr:(endyr-1),
                       read.table(text=txt,
                                  skip=grep("Mean wts in fishery",txt),
                                  nrows=nyrs-1))
  names(wcatch) <- c("Year", 1:nages)

  ## 3  Catch
  catch <- data.frame(Year=styr:endyr,
                      Catch=1000*scan(text=txt,
                                      skip=grep("Catch in kilo tons",txt)+2,
                                      nlines=1, quiet=TRUE))

  ## 4  CPUE (JP trawl)
  cpue <- read.table(text=txt, skip=grep("Japanese.*CPUE",txt)+3, nrows=2,
                     row.names=c("Year", "Index"))
  cpue <- data.frame(t(cpue), row.names=NULL)

  ## 4  Survey (AVO)
  survey.avo <- data.frame(t(read.table(text=txt, skip=grep("AVO data",txt)+2,
                                        nrows=2, row.names=c("Year","Index"))))
  row.names(survey.avo) <- NULL

  ## 5  Catch at age
  catage <- data.frame(Year=styr:(endyr-1),
                       read.table(text=txt, skip=grep("Fishery Age Comps",txt),
                                  nrows=nyrs-1))
  names(catage) <- c("Year", 1:nages)
  catage <- catage[catage$Year>=1991,]

  ## 6  Stock weights
  wstock <- data.frame(Year=styr_bts:endyr,
                       read.table(text=txt,
                                  skip=grep("Bottom trawl survey mean wt",txt),
                                  nrows=nyrs_bts))
  names(wstock) <- c("Year",1:nages)

  ## 7  Survey (BTS)
  survey.bts <- read.table(text=txt,
                           skip=grep("Bottom Trawl survey numbers at age",txt),
                           nrows=nyrs_bts)
  survey.bts <- data.frame(Year=styr_bts:endyr, survey.bts)
  names(survey.bts) <- c("Year", 1:nages)

  ## 8  Survey (AT)
  survey.at <- data.frame(Year=scan(text=txt,
                                    skip=grep("years of .* Hydro survey",txt)+5,
                                    nlines=1, quiet=TRUE),
                          read.table(text=txt,
                                     skip=grep("EIT Age compositions",txt),
                                     nrows=16))
  names(survey.at) <- c("Year", 1:nages)

  list(maturity=maturity, wcatch=wcatch, catch=catch, cpue=cpue,
       survey.avo=survey.avo, catage=catage, wstock=wstock,
       survey.bts=survey.bts, survey.at=survey.at)
}

extractM <- function(controlfile, skip=10, nrows=15)
{
  data.frame(t(read.table(controlfile, skip=skip, nrows=nrows)), row.names=NULL,
             check.names=FALSE)
}
