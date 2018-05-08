% User-set parameters for the Detection and Attribution testbed generation
% MATLAB program. This is the only .m file that should be edited for basic 
% use of the testbed.

% Author: Nathan Lenssen, Columbia University (lenssen@ldeo.columbia.edu)
% D+A Testbed Version: 1.1.0 (March 2018)


% set paths
plotDirectory ='../figures';
dataDirectory ='../output';

isPlotting = 1;

% set seed for reproducibility
seed = 1231531;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem Size/Dimensionality
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% number of observations (50 x 50 right now)
q = 50;
n = q^2;

% the number of control runs
L0 = 1000;

%%%%%%%%%%%%%%%%%%%%%%%
% Regression Parameters
%%%%%%%%%%%%%%%%%%%%%%%

% set coefficients
M = 2;

% number of ensembles (eventually length M)
L = 5;

% true regression parameters
betaTrue = ones(M,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (M1) Forced Response Simulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% currently using a matern spatial field as the true forced response

% control the shape of the Matern for the true focings Xstar
rangeX = [1.5,1/2];
smoothnessX = [1.5,0.25];

% set the relative magnitude of the true forced responses
magnitudeXStar = [1,1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (M2) Climate Variability Simulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% scaling factors as in Smith et al. 20xx
gammaC = [0.5,0.6];
alphaC = 1;

% currently using a eigen-perturbed exponential kernel
% kernel scale
dExp = 5;

% eigenvalue cutoff for variability generation
nLambda = 100;    

% the random factor e-value modification
rng(251); lambda = exp(unifrnd(-2.5,2.5,nLambda,1)); 

% whitening parameter for the climate variability covariance (0 is iid)
delta = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (M3) Observational Error Simulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% currently using independent errors

% number of observations
nObs = 100;

% measurement error on the observed Y
rho = repmat(0.25,1,n);