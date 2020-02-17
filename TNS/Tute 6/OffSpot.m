function S = OffSpot( n )


% returns stimulus array of size n x n, 
%
% with a dark spot, 
%
% spot position (x0,y0) is random
%

S = zeros(n:n);

x=-0.5*(n+1)+[1:n];
y=-0.5*(n+1)+[1:n];

[X,Y] = meshgrid( x, y );

x0 = 0.8 * (rand-0.5) * n;
y0 = 0.8 * (rand-0.5) * n;

S =  1-exp( - 0.5 * ( (X-x0).^2  + (Y-y0).^2 ) );
