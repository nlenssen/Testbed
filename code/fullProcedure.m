% Master function to run the detection and attribution tested. The only piece
% that shoud be modified by the user is the values of the parameters found
% in parameterList.m The functioninputs are likely to be expanded as we add
% additional flexibility of tuning parameters through batch scripts.

% Author: Nathan Lenssen, Columbia University (lenssen@ldeo.columbia.edu)
% D+A Testbed Version: 1.0.0 (December 6, 2017)

function fullProcedure(plotting,plotDirectory,dataDirectory)
	% load in the parameter list to the workspace
	run('code/parameterList.m')

	% run the simulation script
	run('code/generateSimulation.m')

	%run the plotting routine
	if plotting
		run('code/makePlots.m')
	end

	% generate the output file (eventually netcdf for wider distribution)
	run('code/writeOutput.m')

	% quit matlab at the end of the script
	quit
end