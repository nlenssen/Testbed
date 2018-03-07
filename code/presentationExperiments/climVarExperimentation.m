addpath('code')

% load in the parameter list to the workspace
parameterList
L=1; L0=1; 

% change the parameters of interest for the climate variability

% kernel scale
dExp = 5;

% eigenvalue cutoff for variability generation
nx = 100;    

% the random factor e-value modification
rng(251); lambda = exp(unifrnd(-2.5,2.5,nx,1)); % to replicate the figures

% whitening parameter for the climate variability covariance (0 is iid)
rho = 1;


% run the simulation script
generateSimulation


% Recreate Figure (3.c) in Paper
Sig0 = V*diag(d)*V';
u = round(n*rand(1,q));
sig = Sig(u,u);
s = sqrt(diag(sig));
sig = sig./(s*s');
sig = reshape(sig,n,1);

xG = linspace(0,1,q);
yG  = xG;
[xG, yG] = meshgrid(xG,yG);
x1 = reshape(xG,n,1); 
x1 = x1(u)*ones(1,q);
y1 = reshape(yG,n,1);
y1 = y1(u)*ones(1,q);
dist = reshape(sqrt((x1-x1').^2+(y1-y1').^2),n,1);

checkExp = figure('visible','on','Position', [10, 10, 600, 1200]);
subplot(2,1,1);
hold;
plot(log(d(1:nx)),'-ok');
plot(log(d(1:nx).*lambda),'-or')
legend('Raw eigenvalues', 'Lambda modfied eigenvalues');
xlabel('Eigenvalue');
ylabel('Log-Magnitude');
axis square
hold off;
subplot(2,1,2);
hold;
plot(dist,sig,'ok');
fplot(@(d) exp(-d/dExp),[0,sqrt(2)],'LineWidth',3)
xlabel('Distance');
ylabel('Correlation');
axis square
hold off;
legend('Emperical pairwise correlation', 'Exponential RBF');

% Recreate Figure (3.d) in Paper
singlePointCorr = figure('visible','on','Position', [10, 10, 600, 1200]);
q = ceil(sqrt(n));
D = sqrt(diag(SigSqr));
CorrMat = inv(diag(D)) * SigSqr * inv(diag(D))';
subplot(2,1,1)
PlotMat = reshape(CorrMat(:,20),q,q);
tempSort = sort(PlotMat(:));
plottingRange = [tempSort(1),tempSort(n-1)];
pcolor(PlotMat)
colormap(jet)
caxis(plottingRange)
title('Correlation to single point','interpreter','latex','FontSize',20)
colorbar
axis square
subplot(2,1,2)
PlotMat = reshape(CorrMat(:,1625),q,q);
tempSort = sort(PlotMat(:));
plottingRange = [tempSort(1),tempSort(n-1)];
pcolor(PlotMat)
colormap(jet)
caxis(plottingRange)
title('Correlation to single point','interpreter','latex','FontSize',20)
colorbar
axis square

