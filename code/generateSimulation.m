% The main simulation script for the detection and attribution testbed. This 
% script, in general, should not be edited by the user. All of the relevant
% parameters are set in the parameterList.m script.

% Author: Nathan Lenssen, Columbia University (lenssen@ldeo.columbia.edu)
% D+A Testbed Version: 1.1.0 (March 2018)

% set seed for reproducibility
rng(seed)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% generate the internal climate variability covariance matrix C
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% interchangable code for different covariance generation schemes
[x,y,Vin,din] = generateRecBasis(n,dExp);
[V, d, Sig, SigSqr] = generateCovExact(n, nx, lambda, delta,Vin,din);

% assign C for the simulation
CTrue = SigSqr;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% generate regressors (currently matern, scale?, whitening?)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% interchangable code for different forced response simulations
XstarRaw = zeros(n,M);
for MInd=1:M
	maternCovX = generateMatern(n,alphax(MInd),smoothnessx(MInd));
	XstarRaw(:,MInd) = mvnrnd(zeros(n,1), maternCovX,1)';
end

% center and (standarize?) the xstars
XstarCentered = (XstarRaw - repmat(mean(XstarRaw), size(XstarRaw,1), 1));
XstarStd = XstarCentered;

xScaleFactor = kron(xscale,ones(n,1));

% set the Xstar matrix for the simulation
Xstar = xScaleFactor .* XstarStd;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simulate output given CTrue, Xstar, parameterList 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% generate the X noise U (correct scale?, whiten?)[nx(mxp)]
XstarExpand = kron(Xstar,ones(1,L));
U = mvnrnd(zeros(n,1), CTrue,M*L)';
% generate the observed X [nx(mxp)]
gammaFactor = kron(gammaC.^(-1),ones(n,L));
Xobs = XstarExpand + gammaFactor .* U;

% calculate the ensemble means for each of the regressors
XensembleMean = zeros(n,M);
for xInd=1:M
	inds = (1+(L*(xInd-1))):(L*(xInd));
	XensembleMean(:,xInd) = mean(Xobs(:,inds),2);
end

% generate the Y noise Nu (correct scale?)
u       = mvnrnd(zeros(n,1), CTrue,1)';
epsilon = mvnrnd(zeros(n,1), sigmaW * eye(n),1)';
nu      = u + epsilon;

% generate the resultant observed Y
Yobs = Xstar * betaTrue + nu;

% generate the true climate response
Ystar = Xstar * betaTrue;

% generate control runs
U0Ensemble = mvnrnd(zeros(n,1),CTrue,L0)';