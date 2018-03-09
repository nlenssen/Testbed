% A script that generates visualizations of the results if turned on through
% the 'plotting' boolean input. This replicates the plots shown in the LaTeX
% writeup. This will be extended as we continue to find realistic parameter
% settings for the testbed.

% Author: Nathan Lenssen, Columbia University (lenssen@ldeo.columbia.edu)
% D+A Testbed Version: 1.1.0 (March 2018)

% Recreate Figure (3.c) in Paper
Sig0 = V*diag(d)*V';
uInd = round(n*rand(1,q));
sig = Sig(uInd,uInd);
s = sqrt(diag(sig));
sig = sig./(s*s');
sig = reshape(sig,n,1);

xG = linspace(0,1,q);
yG  = xG;
[xG, yG] = meshgrid(xG,yG);
x1 = reshape(xG,n,1); 
x1 = x1(uInd)*ones(1,q);
y1 = reshape(yG,n,1);
y1 = y1(uInd)*ones(1,q);
dist = reshape(sqrt((x1-x1').^2+(y1-y1').^2),n,1);

checkExp = figure('visible','off','Position', [10, 10, 1200, 600]);
subplot(1,2,1);
hold;
plot(d(1:Nlambda),'-ok');
plot(d(1:Nlambda).*lambda,'-or')
legend('Raw eigenvalues', 'Lambda modfied eigenvalues');
xlabel('Eigenvalue');
ylabel('Magnitude');
axis square
hold off;
subplot(1,2,2);
hold;
plot(dist,sig,'ok');
fplot(@(d) exp(-d/dExp),[0,sqrt(2)],'LineWidth',3)
xlabel('Distance');
ylabel('Correlation');
axis square
hold off;
legend('Emperical pairwise correlation', 'Exponential RBF');
print(checkExp,sprintf('%s/checkExp.png',plotDirectory),'-dpng')



% Recreate Figure (3.d) in Paper
singlePointCorr = figure('visible','off','Position', [10, 10, 1200, 600]);

D = sqrt(diag(CTrue));
CorrMat = inv(diag(D)) * SigSqr * inv(diag(D))';

subplot(1,2,1)
PlotMat = reshape(CorrMat(:,20),q,q);
tempSort = sort(PlotMat(:));
plottingRange = [tempSort(1),tempSort(n-1)];
pcolor(PlotMat)
colormap(jet)
caxis(plottingRange)
title('Correlation to single point','interpreter','latex','FontSize',20)
colorbar
axis square

subplot(1,2,2)
PlotMat = reshape(CorrMat(:,1625),q,q);
tempSort = sort(PlotMat(:));
plottingRange = [tempSort(1),tempSort(n-1)];
pcolor(PlotMat)
colormap(jet)
caxis(plottingRange)
title('Correlation to single point','interpreter','latex','FontSize',20)
colorbar
axis square
print(singlePointCorr,sprintf('%s/ptCorrelation.png',plotDirectory),'-dpng')


% get a sense of the true X1, the ensemble mean, and the ensemble members
xGen1 = figure('visible','off','Position', [10, 10, 1000, 1500]);
XensembleSubMat = Xobs(:,1:L);
zRange = max(max(abs(XensembleSubMat)));

subplot(3,2,1)
pcolor(reshape(Xstar(:,1),q,q))
title('$$x^*_1$$ Field','interpreter','latex','FontSize',20)
caxis([-zRange,zRange])
colorbar
axis square
subplot(3,2,2)
pcolor(reshape(XensembleMean(:,1),q,q))
colormap(jet)
title('$$\bar x_1$$ Field','interpreter','latex','FontSize',20)
caxis([-zRange,zRange])
colorbar
axis square
for i=1:4
	subplot(3,2,i+2)
	pcolor(reshape(XensembleSubMat(:,i),q,q))
	colormap(jet)
	title(sprintf('$$x_1$$ Realization %d', i),'interpreter','latex','FontSize',20)
	caxis([-zRange,zRange])
	colorbar
	axis square
end
print(xGen1,sprintf('%s/xGeneration1.png',plotDirectory),'-dpng')

% get a sense of the true X2, the ensemble mean, and the ensemble members
xGen2 = figure('visible','off','Position', [10, 10, 1000, 1500]);
XensembleSubMat = Xobs(:,(L+1):2*L);
zRange = max(max(abs(XensembleSubMat)));

subplot(3,2,1)
pcolor(reshape(Xstar(:,2),q,q))
colormap(jet)
title('$$x^*_2$$ Field','interpreter','latex','FontSize',20)
caxis([-zRange,zRange])
colorbar
axis square
subplot(3,2,2)
pcolor(reshape(XensembleMean(:,2),q,q))
title('$$\bar x_2$$ Field','interpreter','latex','FontSize',20)
caxis([-zRange,zRange])
colorbar
axis square
for i=1:4
	subplot(3,2,i+2)
	pcolor(reshape(XensembleSubMat(:,i),q,q))
	colormap(jet)
	title(sprintf('$$x_2$$ Realization %d', i),'interpreter','latex','FontSize',20)
	caxis([-zRange,zRange])
	colorbar
	axis square
end
print(xGen2,sprintf('%s/xGeneration2.png',plotDirectory),'-dpng')


% the x sum progression (looks good with iid x)
xProg = figure('visible','off','Position', [10, 10, 1000, 1000]);
subplot(2,2,1)
pcolor(reshape(Xstar(:,1),q,q))
colormap(jet)
title('$$x^*_1$$ Field','interpreter','latex','FontSize',20)
colorbar
axis square

subplot(2,2,2)
pcolor(reshape(XensembleMean(:,1),q,q))
colormap(jet)
title('$$\bar x_1$$ Field','interpreter','latex','FontSize',20)
colorbar
axis square

subplot(2,2,3)
pcolor(reshape(U(:,1),q,q))
colormap(jet)
title('$$u_1^{(1)}$$ Field','interpreter','latex','FontSize',20)
colorbar
axis square

subplot(2,2,4)
pcolor(reshape(XensembleMean(:,1),q,q))
colormap(jet)
title('$$x_1^{(1)} = x^*_1 + u_1^{(1)}$$ Field','interpreter','latex','FontSize',20)
colorbar
axis square
print(xProg,sprintf('%s/xprogression.png',plotDirectory),'-dpng')



% the y sum progression
zRange = max(max(abs(y)));
yProg = figure('visible','off','Position', [10, 10, 1000, 1500]);
title('Y Generation Progression')
subplot(3,2,1)
pcolor(reshape(ystar,q,q))
colormap(jet)
title('$$y^* = x^* \beta$$ (True Field)','interpreter','latex','FontSize',20)
colorbar
axis square
caxis([-zRange,zRange])

subplot(3,2,2)
pcolor(reshape(y,q,q))
colormap(jet)
title('$$y = \bar x \beta + \nu$$ (Observed Field)','interpreter','latex','FontSize',20)
colorbar
axis square
caxis([-zRange,zRange])

subplot(3,2,3)
pcolor(reshape(Xstar(:,1),q,q))
colormap(jet)
title('$$x^*_1$$ Field','interpreter','latex','FontSize',20)
colorbar
axis square
caxis([-zRange,zRange])

subplot(3,2,4)
pcolor(reshape(XensembleMean(:,1),q,q))
colormap(jet)
title('$$\bar x_1$$ Field','interpreter','latex','FontSize',20)
colorbar
axis square
caxis([-zRange,zRange])

subplot(3,2,5)
pcolor(reshape(Xstar(:,2),q,q))
colormap(jet)
title('$$x^*_2$$ Field','interpreter','latex','FontSize',20)
colorbar
axis square
caxis([-zRange,zRange])


subplot(3,2,6)
pcolor(reshape(XensembleMean(:,2),q,q))
colormap(jet)
title('$$\bar x_2$$ Field','interpreter','latex','FontSize',20)
colorbar
axis square
caxis([-zRange,zRange])
print(yProg,sprintf('%s/yprogression.png',plotDirectory),'-dpng')
