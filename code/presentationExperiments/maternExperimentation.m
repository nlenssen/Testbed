% addpath('code')
% addpath('code/presentationExperiments')



% load in the parameter list to the workspace
parameterList
L=1; L0=1; 

% change the parameters of interest for the forced responses

% control the shape of the Matern for the true focings Xstar
rangeX = [1.5,1/2];
smoothnessX = [1.5,0.25];

% scale the magnitudes of the foreced responses
magnitudeX = [1,1];


seed=1231531;

% run the simulation script
generateSimulation


%% First, reasonable, attempt at a hands-off method for balancing the magnitudes
%% of the forced responses. 


% plot the true, xstar fields to get a sense of the pattern and scale of the
% two fields. Goal is two visually identifiable fields
zRange = max(max(abs(Xstar)));
checkForced = figure('visible','on','Position', [10, 10, 600, 1200]);
subplot(2,1,1)
pcolor(reshape(Xstar(:,1),q,q))
caxis([-zRange,zRange])
colorbar
axis square

subplot(2,1,2)
pcolor(reshape(Xstar(:,2),q,q))
caxis([-zRange,zRange])
colorbar
axis square