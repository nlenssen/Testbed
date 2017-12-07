% Function to generate a matern covariance matrix on the a square [0,1] x [0,1]
% grid for a given resolution (adapted from the Rfields package to MATLAB)

% Author: Nathan Lenssen, Columbia University (lenssen@ldeo.columbia.edu)
% D+A Testbed Version: 1.0.0 (December 6, 2017)


% INPUT:
% n0:  	      Number of observations (50 x 50 right now)
% alpha:      Inverse of the range of the correlation
% smoothness: Controls the number of derivatives used

% OUTPUT:
% K: A (n0 x n0) Matern covariance matrix 


function [K] = generateMatern(n0,alpha,smoothness)
	nu = smoothness;
	q = ceil(sqrt(n0));
	[x, y] = meshgrid(linspace(0,1,q),linspace(0,1,q));
	gridList = [x(:), y(:)];

	dMat = pdist2(gridList,gridList) .* alpha + (1e-10 * eye(n0));
	% compute the kernel matrix using the gram kernel construction

    con = (2^(nu - 1)) * gamma(nu);
    con = 1/con;

	K = con * (dMat.^nu) .* besselk(nu,dMat);
end