% A script that generates visualizations of the results if turned on through
% the 'plotting' boolean input. This replicates the plots shown in the LaTeX
% writeup. This will be extended as we continue to find realistic parameter
% settings for the testbed.

% Author: Nathan Lenssen, Columbia University (lenssen@ldeo.columbia.edu)
% D+A Testbed Version: 1.0.0 (December 6, 2017)


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

checkExp = figure('visible','off','Position', [10, 10, 1200, 600]);
subplot(1,2,1);
hold;
plot(d(1:nx),'-ok');
plot(d(1:nx).*lambda,'-or')
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
q = ceil(sqrt(n));
D = sqrt(diag(SigSqr));
CorrMat = inv(diag(D)) * SigSqr * inv(diag(D))';
subplot(1,2,1)
PlotMat = reshape(CorrMat(:,20),q,q);
tempSort = sort(PlotMat(:));
plottingRange = [tempSort(1),tempSort(n-1)];
pcolor(PlotMat)
caxis(plottingRange)
title('Correlation to single point','interpreter','latex','FontSize',20)
colorbar
axis square
subplot(1,2,2)
PlotMat = reshape(CorrMat(:,1625),q,q);
tempSort = sort(PlotMat(:));
plottingRange = [tempSort(1),tempSort(n-1)];
pcolor(PlotMat)
caxis(plottingRange)
title('Correlation to single point','interpreter','latex','FontSize',20)
colorbar
axis square
print(singlePointCorr,sprintf('%s/ptCorrelation.png',plotDirectory),'-dpng')


% get a sense of the true X1, the ensemble mean, and the ensemble members
xGen1 = figure('visible','off','Position', [10, 10, 1000, 1500]);
XensembleSubMat = Xobs(:,1:m);
zRange = max(max(abs(XensembleSubMat)));

subplot(3,2,1)
pcolor(reshape(Xstar(:,1),q,q))
title('$$x^*_1$$ Field','interpreter','latex','FontSize',20)
caxis([-zRange,zRange])
colorbar
axis square
subplot(3,2,2)
pcolor(reshape(XensembleMean(:,1),q,q))
title('$$\bar x_1$$ Field','interpreter','latex','FontSize',20)
caxis([-zRange,zRange])
colorbar
axis square
for i=1:4
	subplot(3,2,i+2)
	pcolor(reshape(XensembleSubMat(:,i),q,q))
	title(sprintf('$$x_1$$ Realization %d', i),'interpreter','latex','FontSize',20)
	caxis([-zRange,zRange])
	colorbar
	axis square
end
print(xGen1,sprintf('%s/xGeneration1.png',plotDirectory),'-dpng')

% get a sense of the true X2, the ensemble mean, and the ensemble members
xGen2 = figure('visible','off','Position', [10, 10, 1000, 1500]);
XensembleSubMat = Xobs(:,(m+1):2*m);
zRange = max(max(abs(XensembleSubMat)));

subplot(3,2,1)
pcolor(reshape(Xstar(:,2),q,q))
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
title('$$X^*_1$$ Field','interpreter','latex','FontSize',20)
colorbar
axis square
subplot(2,2,2)
pcolor(reshape(XensembleMean(:,1),q,q))
title('$$\bar X$$ Field','interpreter','latex','FontSize',20)
colorbar
axis square
subplot(2,2,3)
pcolor(reshape(Eta(:,1),q,q))
title('$$\eta$$ Field','interpreter','latex','FontSize',20)
colorbar
axis square
subplot(2,2,4)
pcolor(reshape(XensembleMean(:,1),q,q))
title('$$X_1 = X^*_1 + \eta$$ Field','interpreter','latex','FontSize',20)
colorbar
axis square
print(xProg,sprintf('%s/xprogression.png',plotDirectory),'-dpng')



% the y sum progression
zRange = max(max(abs(Yobs)));
yProg = figure('visible','off','Position', [10, 10, 1000, 1500]);
title('Y Generation Progression')
subplot(3,2,1)
pcolor(reshape(Ystar,q,q))
title('$$y^* = x^* \beta$$ (True Field)','interpreter','latex','FontSize',20)
colorbar
axis square
caxis([-zRange,zRange])

subplot(3,2,2)
pcolor(reshape(Yobs,q,q))
title('$$y = \bar x \beta + \nu$$ (Observed Field)','interpreter','latex','FontSize',20)
colorbar
axis square
caxis([-zRange,zRange])

subplot(3,2,3)
pcolor(reshape(Xstar(:,1),q,q))
title('$$x^*_1$$ Field','interpreter','latex','FontSize',20)
colorbar
axis square
caxis([-zRange,zRange])

subplot(3,2,4)
pcolor(reshape(XensembleMean(:,1),q,q))
title('$$\bar x_1$$ Field','interpreter','latex','FontSize',20)
colorbar
axis square
caxis([-zRange,zRange])

subplot(3,2,5)
pcolor(reshape(Xstar(:,2),q,q))
title('$$x^*_2$$ Field','interpreter','latex','FontSize',20)
colorbar
axis square
caxis([-zRange,zRange])


subplot(3,2,6)
pcolor(reshape(XensembleMean(:,2),q,q))
title('$$\bar x_2$$ Field','interpreter','latex','FontSize',20)
colorbar
axis square
caxis([-zRange,zRange])
print(yProg,sprintf('%s/yprogression.png',plotDirectory),'-dpng')