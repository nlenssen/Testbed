% Save the results necessary for testing and comparison of detection and
% attribution methods. Currently, we are saving as a .mat object. Eventually
% we will save to more general filetypes to allow distribution of results.

% Author: Nathan Lenssen, Columbia University (lenssen@ldeo.columbia.edu)
% D+A Testbed Version: 1.1.0 (March 2018)


% collect all of the objects in a struct

% true, latent objects
latent = struct('Ystar',Ystar,'Xstar',Xstar);

% observed objects
observed = struct('Yobs',Yobs,'Xobs',Xobs,'ControlEnsemble',U0Ensemble);

% collect as single object
outStruct = struct('latent',latent,'observed',observed);

save(sprintf('%s/testbedOutput.mat',dataDirectory),'outStruct')