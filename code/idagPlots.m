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
field1 = mvnrnd(zeros(n,1), generateMatern(n,mRange,mSmoothness)); field1 = field1 - mean(field1);

mRange      = 1/3;
mSmoothness = 2;
field2 = mvnrnd(zeros(n,1), generateMatern(n,mRange,mSmoothness)); field2 = field2 - mean(field2);

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
%title('Matern Random Field','interpreter','latex','FontSize',20)
colorbar
axis square
print(maternExample,sprintf('%s/maternExample.png',plotDirectory),'-dpng')



% simple plots
rectang = zeros(q,q); rectang = rectang + 2;
rectang(1:10,:) = -2; rectang(41:50,:) = -2;

linrec = kron([linspace(-2,2,25),linspace(2,-2,25)]',ones(1,q));

simplePlots = figure('visible','on','Position', [10, 10, 600, 1200]);
subplot(2,1,1)
pcolor(rectang)
caxis([-zRange,zRange])
colormap(jet)
%title('Matern Random Field','interpreter','latex','FontSize',20)
colorbar
axis square

subplot(2,1,2)

pcolor(linrec)
caxis([-zRange,zRange])
colormap(jet)
%title('Matern Random Field','interpreter','latex','FontSize',20)
colorbar
axis square
print(simplePlots,sprintf('%s/simpleXExample.png',plotDirectory),'-dpng')


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

recBasisPlot = figure('visible','on','Position', [10, 10, 2*1600, 2*1200]);
for i = 1:12
	subplot(3,4,i)
	pcolor(reshape(Vin(:,i),q,q))
	axis off
	colormap(jet)
end
print(recBasisPlot,sprintf('%s/recBasis.png',plotDirectory),'-dpng')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% simulation of the y
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
parameterList;

% modifications to default params
alphaC = 0.05;
seed=155;
rho = repmat(1.5,1,n);
plotDirectory ='presIDAG18/Images';

generateSimulation;



% the y sum progression
zRange = max(max(abs(y)));
yProg = figure('visible','on','Position', [10, 10, 2000, 1000]);

subplot(1,2,1)
pcolor(reshape(ystar,q,q))
colormap(jet)
title('$$y^* = X^* \beta$$ (True Field)','interpreter','latex','FontSize',20)
colorbar
axis square
caxis([-zRange,zRange])

subplot(1,2,2)
pcolor(reshape(y,q,q))
colormap(jet)
title('$$y_{rel} =  X^* \beta + \alpha^{-1}$$C (Realized Field)','interpreter','latex','FontSize',20)
colorbar
axis square
caxis([-zRange,zRange])

print(yProg,sprintf('%s/yprogression.png',plotDirectory),'-dpng')



% yrealized
zRange = max(max(abs(y)));
yRealized = figure('visible','on','Position', [10, 10, 1000, 1000]);
pcolor(reshape(y,q,q))
colormap(jet)
title('$$y_{rel} =  X^* \beta + \alpha^{-1}$$C (Realized Field)','interpreter','latex','FontSize',30)
axis square
caxis([-zRange,zRange])

print(yRealized,sprintf('%s/yrealized.png',plotDirectory),'-dpng')




% the y obs

% Make a land mask of sorts
mask = ones(q,q);

mask(1:25,1:50) = 0 ;

vecMask = reshape(mask,n,1);

rho = repmat(1.5,1,n);
rho(vecMask==1) = 3 ;
 
generateSimulation;


zRange = max(max(abs(yobs)));
yobservation = figure('visible','on','Position', [10, 10, 1000, 2000]);

subplot(2,1,1)
pcolor(reshape(yobs(:,1),q,q))
colormap(jet)
title('$$y_{obs}^{(1)} = y_{rel} + \varepsilon^{(1)}$$','interpreter','latex','FontSize',20)

axis square
caxis([-zRange,zRange])

subplot(2,1,2)
pcolor(reshape(yobs(:,2),q,q))
colormap(jet)
title('$$y_{obs}^{(2)} = y_{rel} + \varepsilon^{(2)}$$','interpreter','latex','FontSize',20)

axis square
caxis([-zRange,zRange])

% subplot(3,1,3)
% pcolor(reshape(yobs(:,3),q,q))
% colormap(jet)
% title('$$y_{obs}^{(3)} = y_{rel} + \varepsilon^{(3)}$$','interpreter','latex','FontSize',20)

% axis square
% caxis([-zRange,zRange])




print(yobservation,sprintf('%s/yobservation.png',plotDirectory),'-dpng')






