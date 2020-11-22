# D+A Testbed Version 1.0.0 (December 6, 2017)
##### Nathan Lenssen, Columbia University (lenssen@ldeo.columbia.edu)

## Citation
Lenssen, N. J. L., Hannart, A., & Hammerling, D. (2018). Simulation Testbed for Trend Detection and Attribution Methods (No. NCAR/TN-555+STR). doi:10.26024/xfmm-hj36

## Abstract

A major goal of climate research is attributing the observed changes in the climate to human activity. The field of detection and attribution has been an active and growing for a couple of decades and has recently seen a increase in the quantity and sophistication of methods. In practice, D+A involves showing a causal relationship between the observed climate responses and modeled climate responses to individual forcing. The explosion of research developing methods has prompted the community to come together and design a testbed for the current methods. Such a testbed is difficult to develop as it involves generating spatiotemporal fields with complex and flexible covariance structures that do not inherently favor any of the methods to be tested. The following software uses MATLAB to implement an significant extension of the numerical simulation described in (Hannart 2016) section 4a. The final product is a MATLAB program that will generate synthetic data for a wide parameterized class of climate scenarios.



## Quick Start Guide

To run the testbed as it is currently configured, clone the entire directory tree from the root github directory. There should be four directories: code, doc, figures, and output. Then, the full script can be run from the root directory by calling the batch script.
```
$ code/runLocal.sh
```
If a user does not have access to matlab, a complementary batch script has been included for the Habanero cluster that can be modified for any linux cluster that has a matlab installation.

## Summary of Output

The ultimate goal of this testbed is to generate analogues to the observational and model products that scientists currently use to perform detection and attribution studies to compare the performance of existing methods and test new methods as they are developed. The major objects that need to be generated are

* The observed climate signal **y** (such as 100 year temperature anomaly trends)
* The j observed forced climate responses **x_j** that contribute to this signal
* An ensemble of observed control runs used to estimate the intern climate variability 

We also return the following objects to be able to determine the performance of our detection and attribution methods. The strength of the testbed simulations is the exact knowledge of these underlying parameters which allows us to better understand the performance of the analyses

* The true climate response signal **y\***
* The true forced responses **x\*\_j**
* The true climate variability **C**

A critical step is generating a covariance matrix **C** that describes realistic correlation patterns over space. The method used in this study is particularly interesting as it creates covariance matrices that are non-isotropic. That is, they do not exhibit the same correlation for every distance of the same length. The covariance for our climate system is generally highly non-isotropic, particularly on ocean/land borders. An example of two correlation matrices to a single point (The columns of **C**) are shown below to get a sense of this behavior.

![alt text](https://github.com/nlenssen/Assignments/blob/master/FinalProject/figures/ptCorrelation.png)

A comparison of the observed and true **y** and **x** objects is shown in the Figure below (see the full documentation for more details). The true latent objects are in the left column and the observed objects are on the right. Since we are assuming that the two forcing responses are simply added together for this run, the top row is the sum of the bottom two rows.

![alt text](https://github.com/nlenssen/Assignments/blob/master/FinalProject/figures/yprogression.png)

## Subdirectory Outline

* `code/` The matlab and shell scripts needed to run the testbed generation and visualization process. A full outline of the contents is provided below. In general, the only script that will be changed by the user is parameterList.m

* `doc/` An early draft of the full report that contains further detail of the mathematics behind the configuration of the testbed. The figure output from the testbed generation is often directed to the /doc/figures folder to simplify the analysis and writing workflow. Currently trying to find a middle ground in notation and assumptions between (Hannart 2016) and (Katzfuss et al. 2017).

* `figures/` All of the figures generated to visualize the results from the testbed. More information of the figures can be found in the writeup in the doc/ directory

* `output/` Contains all of the output of the testbed generation script required for the testing of detection and attribution methods.



## Code Directory Outline

* `fullProcedure.m` is the master function that runs the generation procedure, has the option to plot, and saves the relevant output. It takes no more than 30 seconds on my laptop at the current settings.

* `parameterList.m` User-set parameters for the Detection and Attribution testbed generation matlab program. Generally the only `.m` file that should be edited for basic use of the testbed.

* `generateSimulation.m` is a script that handles the entire simulation. It returns all of the objects of interest plus a few bonus objects used in plotting. It depends on a few user functions to handle the spatial covariances.

* `makePlots.m` Creates all of the plots found in this report if plotting is turned on when `fullProcedure.m` is run. Will be expanded as the project progresses.

* `writeOutput.m` Saves the relevant objects to disk. Will eventually save as netCDF to facilitate sharing between programming languages.

* `generateMatern.m` is a helper function that evaluates of the Matern radial basis function. It is used to generate the spatial covariance of the forced responses.

* `generateRecBasis.m` is a helper function thatreturns the eigenvectors and eigenvalues of an exponential covariance matrix on a [0,1] x [0,1] grid for a given scale parameter.

* `generateCovExact.m` is a helper function that returns various covariance objects of the modified exponential to be used as the internal climate variability **C**. The modification is an in Hannart 2016 in which the eigenvalues of a exponential covariance matrix are modified by multiplicative random factors.

* `runLocal.sh` runs the testbed on a local machine. Note that matlab must be correctly added to the `PATH` variable

* `runHabanero.sh` runs the testbed on the Habanero cluster. Useful for users that do not have local access to matlab




## References:



Hannart, A., 2016: Integrated Optimal Fingerprinting: Method Description and Illustration. J. Climate, 29, 1977–1998, https://doi.org/10.1175/JCLI-D-14-00124.1

Katzfuss, M., D. Hammerling, and R. L. Smith (2017), A Bayesian hierarchical model for climate change detection and attribution, Geophys. Res. Lett., 44, 5720–5728, doi:10.1002/2017GL073688.

```
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!IN PREPARATION, NOT FOR PUBLIC DISTRIBUTION!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
```

