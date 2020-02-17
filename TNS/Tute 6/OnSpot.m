function S = OnSpot( n )

% returns stimulus array of size n x n, 
%
% with a bright spot, 
%
% spot position (x0,y0) is random
%

S = zeros(n:n);

x=-0.5*(n+1)+[1:n];
y=-0.5*(n+1)+[1:n];

[X,Y] = meshgrid( x, y );

x0 = 0.8 * (rand-0.5) * n;
y0 = 0.8 * (rand-0.5) * n;


S =  exp( - 0.5 * ( (X-x0).^2  + (Y-y0).^2 ) );