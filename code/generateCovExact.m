% Function to generate a covariance matrix according to section 4a
% of Hannart 2016. We are performing random modifications (according to lambda)
% to the eigenvalues of an exponential RBF generated covariance matrix.

% Author: Nathan Lenssen, Columbia University (lenssen@ldeo.columbia.edu)
% D+A Testbed Version: 1.1.0 (March 2018)

% INPUT:
% n:  	  number of observations (50 x 50 right now)
% n0:     number of obs to generate basis
% d0:     exponential basis parmaeter
% nx:     top eigenvalues to take
% lambda: vector of length nx to modify the eigenvalues by
% delta:    whitening parameter

% OUTPUT:
% Vfinal:  	 Eigenvectors of covariance matrix	
% dfinal:    Eigenvalues of covariance matrix (modified by lambda)
% Sig:     	 Covariance matrix w/o whitening
% SigSqr:    Covariance matrix w/ whitening according to delta
% SigInvSqr: Precision matrix w/ whitening according to delta

function [Vfinal, dfinal, Sig, SigSqr, SigInvSqr] = generateCovExact(n, nx, lambda, delta, V, d)
	%% setup grid 
	q = ceil(sqrt(n));
	xSeq = linspace(0,1,q);
	ySeq = xSeq;
	[x,y] = meshgrid(xSeq,ySeq);
	

	%% normalization of the QR matrix
	% perform the economy QR decomposition of our interpolated PC matrix
	[Q, R] = qr(V(:,1:nx),0);

	Vfinal = Q;
	dfinal = d(1:nx);

	%% Construction of the output covariance matricies
	% vector of eigenvalues (length nx) adjusted by lambda
	dt = dfinal.*lambda;

	% create the distance mat
	ddelta = delta*dfinal;
	Ddelta = ones(n,1)*ddelta'; 
	D = (Vfinal.*Ddelta)*Vfinal' + (1-delta)*eye(n);

	% create the various covariance matricies (using the 1mat trick to only 
	% have to perform one n^2 matrix multiplication)
	ddeltaSig = delta*dt;
	sigD = ones(n,1)*ddeltaSig'; 
	Sig = (Vfinal.*sigD)*Vfinal' + (1-delta)*eye(n);

	ddeltaSqrSig = sqrt(delta*dt+(1-delta)) - sqrt(1-delta);
	sqrSigD = ones(n,1)*ddeltaSqrSig';
	SigSqr = (Vfinal.*sqrSigD)*Vfinal' +sqrt(1-delta)*eye(n);

	ddeltaInvSig = 1./sqrt(delta*dt+(1-delta)) - 1/sqrt(1-delta);
	invsqrD = ones(n,1)*ddeltaInvSig';
	SigInvSqr = (Vfinal.*invsqrD)*Vfinal' + 1/sqrt(1-delta)*eye(n);
end
