% addpath('code')

% load in the parameter list to the workspace and make the irrelevant
% dimensions as small as possible
parameterList
L=1; L0=1; 

% change the parameters of interest for the climate variability

% settings 1
dExp = 5; 
Nlambda = 100;
delta = 1;
rng(251); 
lambda = exp(unifrnd(-2.5,2.5,Nlambda,1)); 

% settings 2



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
plot(log(d(1:Nlambda)),'-ok');
plot(log(d(1:Nlambda).*lambda),'-or')
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

