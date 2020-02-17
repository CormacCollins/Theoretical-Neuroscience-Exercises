function S = OffBar( n, theta )

% returns stimulus array of size n x n, 
%
% with a dark bar of orientation theta, 
%
% bar position is random
%

S = zeros(n:n);

[X,Y] = meshgrid( -0.5*(n+1)+[1:n], -0.5*(n+1)+[1:n] );

S =  -exp( - 0.5 * (cos(theta) * X + sin(theta) * Y + 0.1 * n * randn).^ 2 );