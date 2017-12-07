% Function to generate a covariance matrix according to section 4a
% of Hannart 2016. We are performing random modifications (according to lambda)
% to the eigenvalues of an exponential RBF generated covariance matrix.

% Author: Nathan Lenssen, Columbia University (lenssen@ldeo.columbia.edu)
% D+A Testbed Version: 1.0.0 (December 6, 2017)

% INPUT:
% n:  	  number of observations (50 x 50 right now)
% n0:     number of obs to generate basis
% d0:     exponential basis parmaeter
% nx:     top eigenvalues to take
% lambda: vector of length nx to modify the eigenvalues by
% rho:    whitening parameter

% OUTPUT:
% Vfinal:  	 Eigenvectors of covariance matrix	
% dfinal:    Eigenvalues of covariance matrix (modified by lambda)
% Sig:     	 Covariance matrix w/o whitening
% SigSqr:    Covariance matrix w/ whitening according to rho
% SigInvSqr: Precision matrix w/ whitening according to rho

function [Vfinal, dfinal, Sig, SigSqr, SigInvSqr] = generateCovExact(n, nx, lambda, rho, V, d)
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
	dt = d(1:nx).*lambda;

	% create the distance mat
	drho = rho*d(1:nx);
	Drho = ones(n,1)*drho'; 
	D = (Vfinal.*Drho)*Vfinal' + (1-rho)*eye(n);

	% create the various covariance matricies (using the 1mat trick to only 
	% have to perform one n^2 matrix multiplication)
	drhoSig = rho*dt;
	sigD = ones(n,1)*drhoSig'; 
	Sig = (Vfinal.*sigD)*Vfinal' + (1-rho)*eye(n);

	drhoSqrSig = sqrt(rho*dt+(1-rho)) - sqrt(1-rho);
	sqrSigD = ones(n,1)*drhoSqrSig';
	SigSqr = (Vfinal.*sqrSigD)*Vfinal' +sqrt(1-rho)*eye(n);

	drhoInvSig = 1./sqrt(rho*dt+(1-rho)) - 1/sqrt(1-rho);
	invsqrD = ones(n,1)*drhoInvSig';
	SigInvSqr = (Vfinal.*invsqrD)*Vfinal' + 1/sqrt(1-rho)*eye(n);
end
