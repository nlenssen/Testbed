% The main simulation script for the detection and attribution testbed. This 
% script, in general, should not be edited by the user. All of the relevant
% parameters are set in the parameterList.m script.

% Author: Nathan Lenssen, Columbia University (lenssen@ldeo.columbia.edu)
% D+A Testbed Version: 1.0.0 (December 6, 2017)


% set seed for reproducibility
rng(seed)

% generate the internal climate variability covariance matrix C
[x,y,Vin,din] = generateRecBasis(n,dExp);
[V, d, Sig, SigSqr] = generateCovExact(n, nx, lambda, rho,Vin,din);


%% generate regressors (currently matern, scale?, whitening?)
XstarRaw = zeros(n,M);
for MInd=1:M
	maternCovX = generateMatern(n,alphax(MInd),smoothnessx(MInd));
	XstarRaw(:,MInd) = mvnrnd(zeros(n,1), maternCovX,1)';
end

% center and (standarize?) the xstars
XstarCentered = (XstarRaw - repmat(mean(XstarRaw), size(XstarRaw,1), 1));
XstarStd = XstarCentered;

xScaleFactor = kron(xscale,ones(n,1));
Xstar = xScaleFactor .* XstarStd;

% generate the X noise Eta (correct scale?, whiten?)[nx(mxp)]
XstarExpand = kron(Xstar,ones(1,L));
Eta = mvnrnd(zeros(n,1), SigSqr,M*L)';

% generate the observed X [nx(mxp)]
gammaFactor = kron(gammaC.^(-1),ones(n,L));
Xobs = XstarExpand + gammaFactor .* Eta;

% calculate the ensemble means for each of the regressors
XensembleMean = zeros(n,M);
for xInd=1:M
	inds = (1+(L*(xInd-1))):(L*(xInd));
	XensembleMean(:,xInd) = mean(Xobs(:,inds),2);
end

% generate the Y noise Nu (correct scale?)
W = mvnrnd(zeros(n,1), sigmaW * eye(n),1)';

% generate the resultant observed Y
Yobs = XensembleMean * beta0 + W;

% generate the true climate response
Ystar = Xstar * beta0;

% generate control runs
EpsilonEnsemble = mvnrnd(zeros(n,1),SigSqr,L0)';