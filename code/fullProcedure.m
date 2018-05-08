% Master function to run the detection and attribution tested. The only piece
% that shoud be modified by the user is the values of the parameters found
% in parameterList.m The functioninputs are likely to be expanded as we add
% additional flexibility of tuning parameters through batch scripts.

% Author: Nathan Lenssen, Columbia University (lenssen@ldeo.columbia.edu)
% D+A Testbed Version: 1.1.0 (March 2018)


% load in the parameter list to the workspace
parameterList

% run the simulation script
generateSimulation

%run the plotting routine
if isPlotting
	makePlots
end

	% generate the output file (eventually netcdf for wider distribution)
writeOutput
