
%%% OLS w/ pseudo-precision (Hegerl 1996)

% use the crude empierical estimate of sigma
r = 300;
SMat = 1/r * EpsilonEnsemble * EpsilonEnsemble';

% using the 'S pseudoinverse of Precision'
k = 300;
[PMat,DMat] = eigs(SMat,k);

PrecisionTrunc = PMat * inv(DMat) * PMat';

% get the OLS estimate of beta corresponding SE

betaHat = (inv(XensembleMean' * PrecisionTrunc * XensembleMean)) * (XensembleMean' * PrecisionTrunc * Yobs);

varBetaHat = inv(XensembleMean' * PrecisionTrunc * XensembleMean);

% final beta estimates and 2sigma intervals


%%% TLS 

XensembleMeanAdj = XensembleMean * sqrt(m);
totalObs = [XensembleMeanAdj,Yobs];
[Utls,Stls,Vtls] = svd(totalObs,0);

% objects for inference
vxy = Vtls(1:2,3);
vyy = Vtls(3,3);
betaHatTLS   = -vxy/vyy * sqrt(m);


% calculate TLS confidence intervals (see R code)


% plot to check
zRange = max(max(abs(SMat)));

subplot(1,3,1)
pcolor(SigSqr(1:100,1:100))
caxis([-zRange,zRange])
colorbar()

subplot(1,3,2)
pcolor(SMat(1:100,1:100))
caxis([-zRange,zRange])
colorbar()

subplot(1,3,3)
diffMat = (SigSqr-SMat);
pcolor(diffMat(1:100,1:100))
colorbar()
