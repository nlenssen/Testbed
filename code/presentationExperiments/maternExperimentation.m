% addpath('code')
% addpath('code/presentationExperiments')



% load in the parameter list to the workspace
parameterList
L=1; L0=1; 

% change the parameters of interest for the forced responses

% control the shape of the Matern for the true focings Xstar
alphax = [2,4];
smoothnessx = [1.5,0.5];

% scale the magnitudes of the foreced responses
xscale = [1,1];

% scaling factors as in Smith et al. 20xx
gammaC = [0.5,0.6];

seed=1231531;

% run the simulation script
generateSimulation


%% First, reasonable, attempt at a hands-off method for balancing the magnitudes
%% of the forced responses. 

% get the average square of the fields
x1Mag = mean(Xstar(:,1).^2);
x2Mag = mean(Xstar(:,2).^2);

xRatio = x1Mag/x2Mag;


% plot the true, xstar fields to get a sense of the pattern and scale of the
% two fields. Goal is two visually identifiable fields
zRange = max(max(abs(Xstar)));
checkForced = figure('visible','on','Position', [10, 10, 600, 1200]);
subplot(2,1,1)
pcolor(reshape(Xstar(:,1)/xRatio,q,q))
caxis([-zRange,zRange])
colorbar
axis square

subplot(2,1,2)
pcolor(reshape(Xstar(:,2),q,q))
caxis([-zRange,zRange])
colorbar
axis square