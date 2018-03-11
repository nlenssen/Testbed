addpath('code')

plotDirectory ='presIDAG18/Images';

%%%%%%%%%%%
% X^* Plots
%%%%%%%%%%%

% Matern Fields
rng(155)
n = 2500;
q = sqrt(n);

mRange      = 1/3;
mSmoothness = 0.4;
field1 = mvnrnd(zeros(n,1), generateMatern(n,mRange,mSmoothness)); field = field - mean(field);

mRange      = 1/3;
mSmoothness = 2;
field2 = mvnrnd(zeros(n,1), generateMatern(n,mRange,mSmoothness)); field = field - mean(field);

zRange = max(max(max([field1,field2])));

maternExample = figure('visible','on','Position', [10, 10, 600, 1200]);
subplot(2,1,1)
pcolor(reshape(field1,q,q))
caxis([-zRange,zRange])
colormap(jet)
title('Matern Random Field','interpreter','latex','FontSize',20)
colorbar
axis square

subplot(2,1,2)

pcolor(reshape(field2,q,q))
caxis([-zRange,zRange])
colormap(jet)
title('Matern Random Field','interpreter','latex','FontSize',20)
colorbar
axis square
print(maternExample,sprintf('%s/maternExample.png',plotDirectory),'-dpng')


%%%%%%%%%
% C Plots
%%%%%%%%%
n = 2500;
dExp = 1;
[x,y,Vin,din] = generateRecBasis(n,dExp);

% regular exponential
[V, d, Sig, SigSqr] = generateCovExact(n, 100, ones(100,1), 1, Vin, din);

% pointwise exponential correlation
D = sqrt(diag(Sig));
CorrMat = inv(diag(D)) * Sig * inv(diag(D))';



% regular exponential plot
expoCorrelation = figure('visible','on','Position', [10, 10, 600, 1200]);

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
PlotMat = reshape(CorrMat(:,1925),q,q);
tempSort = sort(PlotMat(:));
plottingRange = [tempSort(1),tempSort(n-1)];
pcolor(PlotMat)
colormap(jet)
caxis(plottingRange)
title('Correlation to single point','interpreter','latex','FontSize',20)
colorbar
axis square

print(expoCorrelation,sprintf('%s/expoCorrelation.png',plotDirectory),'-dpng')

% settings 1 for cool climate variability
dExp = 3; 
Nlambda = 100;
delta = 1;
rng(28223); 
lambda = exp(unifrnd(-2.5,2.5,Nlambda,1)); 

[x,y,Vin,din] = generateRecBasis(n,dExp);
[V, d, Sig, SigSqr] = generateCovExact(n, Nlambda, lambda, delta,Vin,din);

% pointwise exponential correlation
D = sqrt(diag(Sig));
CorrMat = inv(diag(D)) * Sig * inv(diag(D))';

% funky exponential plot
expoCorrelation = figure('visible','on','Position', [10, 10, 600, 1200]);

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
PlotMat = reshape(CorrMat(:,1925),q,q);
tempSort = sort(PlotMat(:));
plottingRange = [tempSort(1),tempSort(n-1)];
pcolor(PlotMat)
colormap(jet)
caxis(plottingRange)
title('Correlation to single point','interpreter','latex','FontSize',20)
colorbar
axis square

print(expoCorrelation,sprintf('%s/modCorrelation1.png',plotDirectory),'-dpng')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% settings 2 for cool climate variability
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dExp = 3; 
Nlambda = 100;
delta = 1;
rng(11); 
lambda = exp(unifrnd(-2.5,2.5,Nlambda,1)); 

[x,y,Vin,din] = generateRecBasis(n,dExp);
[V, d, Sig, SigSqr] = generateCovExact(n, Nlambda, lambda, delta,Vin,din);

% pointwise exponential correlation
D = sqrt(diag(Sig));
CorrMat = inv(diag(D)) * Sig * inv(diag(D))';

% funky exponential plot
expoCorrelation = figure('visible','on','Position', [10, 10, 600, 1200]);

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
PlotMat = reshape(CorrMat(:,1925),q,q);
tempSort = sort(PlotMat(:));
plottingRange = [tempSort(1),tempSort(n-1)];
pcolor(PlotMat)
colormap(jet)
caxis(plottingRange)
title('Correlation to single point','interpreter','latex','FontSize',20)
colorbar
axis square

print(expoCorrelation,sprintf('%s/modCorrelation2.png',plotDirectory),'-dpng')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% first 16 eigenfunctions of the exponential
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = 2500;
q = sqrt(n);
dExp = 1;

[x,y,Vin,din] = generateRecBasis(n,dExp);

recBasisPlot = figure('visible','on','Position', [10, 10, 1200, 1200]);
for i = 1:16
	subplot(4,4,i)
	pcolor(reshape(Vin(:,i),q,q))
	axis off
	colormap(jet)
end
print(recBasisPlot,sprintf('%s/recBasis.png',plotDirectory),'-dpng')




