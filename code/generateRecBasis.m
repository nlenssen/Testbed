% Function to generate a rectangular harmonic basis of an exponential kernel

% Author: Nathan Lenssen, Columbia University (lenssen@ldeo.columbia.edu)
% D+A Testbed Version: 1.0.0 (December 6, 2017)


% INPUT:
% n0:  	Number of observations (50 x 50 right now)
% dExp: The scale parameter in the exponential kernel

% OUTPUT:
% x:	 Matrix of x values on the full grid (q x q)
% y:	 Matrix of y values on the full grid (q x q)
% Vsort: The resulting eigenvectors, sorted by descending eigenvalue
% dSort: The descending eigenvalue vector


function [x, y, VSort, dSort] = generateRecBasis(n0, dExp)
	q = ceil(sqrt(n0));
	[x, y] = meshgrid(linspace(0,1,q),linspace(0,1,q));
	gridList = [x(:), y(:)];

	% compute the kernel matrix using the gram kernel construction
	K = pdist2(gridList,gridList)/dExp;
	K = exp(-K);

	% check the val in Alexis' paper (need to loop back to to 
	% disp('value of sum in basis:')
	% disp(sum(sum(K/n0)) - sum(diag(K/n0)))

	% take the eigenvalue decomposition (Slow part!)
	[V,D] = eig(K);

	% confirm that they are sorted
	[junk,perm]=sort(diag(D),'descend');
	dSort=diag(D(perm,perm));
	VSort=V(:,perm);

end