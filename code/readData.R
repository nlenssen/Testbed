# working directory is ?/Testbed/
library(R.matlab)

# read in the raw matlab file
rawIn <- readMat('output/testbedOutput.mat')

# delist the huge mess that R sees in the mat file
Ystar      <- c(rawIn$outStruct[[1]][[1]])
Xstar      <-   rawIn$outStruct[[1]][[2]]
CTrue      <-   rawIn$outStruct[[1]][[3]]

Yobs       <- c(rawIn$outStruct[[2]][[1]])
Xobs       <-   rawIn$outStruct[[2]][[2]]
U0Ensemble <-   rawIn$outStruct[[2]][[3]]


# get dimensionality from the dataobjs
n  <- length(Ystar)
q  <- sqrt(n)
M  <- ncol(Xstar)
L  <- ncol(Xobs)/M
L0 <- ncol(U0Ensemble)

# hard-coded parameters from the matlab file (BAD FORM!)
betaTrue <- rep(1,2)
sigmaW   <- 0.25