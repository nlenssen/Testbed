% User-set parameters for the Detection and Attribution testbed generation
% MATLAB program. This is the only .m file that should be edited for basic 
% use of the testbed.

% Author: Nathan Lenssen, Columbia University (lenssen@ldeo.columbia.edu)
% D+A Testbed Version: 1.0.0 (December 6, 2017)


% set paths
plotDirectory ='figures';
dataDirectory ='output';

% set seed for reproducibility
seed = 125;

% number of observations (50 x 50 right now)
q = 50;
n = q^2;


% number of ensembles (scaling of eta relative to nu)
L = 25;

% the number of control runs
L0 = 1000;

% set coefficients
M=2;
beta0 = ones(M,1);

% measurement error on the observed Y
sigmaW = 1;

% kernel scale
dExp = 0.25;

% eigenvalue cutoff for variability generation
nx = 100;    

% the random factor e-value modification
rng(250); lambda = unifrnd(0.5,1.5,nx,1).^2; % to replicate the figures

% whitening parameter for the climate variability covariance (0 is iid)
rho = 1;

% control the shape of the Matern for the true focings Xstar
alphax = [1,3];
smoothnessx = [1,0.5];

% scale the magnitudes of the foreced responses
xscale = [2,0.7];

% scaling factors as in Smith et al. 20xx
gammaC = [0.5,0.6];