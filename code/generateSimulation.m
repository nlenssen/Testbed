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
XstarRaw = zeros(n,p);
for pInd=1:p
	maternCovX = generateMatern(n,alphax(pInd),smoothnessx(pInd));
	XstarRaw(:,pInd) = mvnrnd(zeros(n,1), maternCovX,1)';
end

% center and (standarize?) the xstars
XstarCentered = (XstarRaw - repmat(mean(XstarRaw), size(XstarRaw,1), 1));
XstarStd = XstarCentered;

xScaleFactor = kron(xscale,ones(n,1));
Xstar = xScaleFactor .* XstarStd;

% generate the X noise Eta (correct scale?, whiten?)[nx(mxp)]
XstarExpand = kron(Xstar,ones(1,m));
Eta = mvnrnd(zeros(n,1), SigSqr,p*m)';

% generate the observed X [nx(mxp)]
gammaFactor = kron(gammaC.^(-1),ones(n,m));
Xobs = XstarExpand + gammaFactor .* Eta;

% calculate the ensemble means for each of the regressors
XensembleMean = zeros(n,p);
for xInd=1:p
	inds = (1+(m*(xInd-1))):(m*(xInd));
	XensembleMean(:,xInd) = mean(Xobs(:,inds),2);
end

% generate the Y noise Nu (correct scale?)
Nu = mvnrnd(zeros(n,1), 1/alphaC * SigSqr,1)';

% generate the resultant observed Y
Yobs = XensembleMean * beta0 + Nu;

% generate the true climate response
Ystar = Xstar * beta0;

% generate control runs
EpsilonEnsemble = mvnrnd(zeros(n,1),SigSqr,300)';