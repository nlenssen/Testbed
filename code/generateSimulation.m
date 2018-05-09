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
[x, y, vIn, dIn] = generateRecBasis(n, dExp);
[V, d, Sig, SigSqr] = generateCovExact(n, nLambda, lambda, delta, vIn, dIn);

% assign C for the simulation
CTrue = SigSqr;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% generate regressors (currently matern, scale?, whitening?)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% interchangable code for different forced response simulations
XstarRaw = zeros(n,M);
for MInd=1:M
	maternCovX = generateMatern(n,rangeX(MInd),smoothnessX(MInd));
	XstarRaw(:,MInd) = mvnrnd(zeros(n,1), maternCovX,1)';
end

% center and (standarize?) the xstars
Xstar = (XstarRaw - repmat(mean(XstarRaw), size(XstarRaw,1), 1));;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simulate output given CTrue, Xstar, parameterList 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% generate the X noise U (correct scale?, whiten?)[nx(mxp)]
XstarExpand = kron(Xstar,ones(1,L));

U = [];
for ind=1:M
	U = [U,mvnrnd(zeros(n,1), (gammaC(ind)).^(-1) .* CTrue,L)'];
end

% generate the observed X [nx(mxp)]
Xobs = XstarExpand + U;

% calculate the ensemble means for each of the regressors
XensembleMean = zeros(n,M);
for xInd=1:M
	inds = (1+(L*(xInd-1))):(L*(xInd));
	XensembleMean(:,xInd) = mean(Xobs(:,inds),2);
end

% Generate the realized climate response Y
u = mvnrnd(zeros(n,1), (alphaC).^(-1) .* CTrue,1)';
y = Xstar * betaTrue + u;

% generate the observed climate response Yobs
yExpand = kron(y,ones(1,nObs));
epsilon = mvnrnd(zeros(n,1), diag(rho),nObs)';

yobs    = yExpand + epsilon;

% generate the true, latent climate response
ystar = Xstar * betaTrue;

% generate control runs
U0Ensemble = mvnrnd(zeros(n,1),CTrue,L0)';
