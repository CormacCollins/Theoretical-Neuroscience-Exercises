% Course on theoretical neuroscience
% Teacher: Jochen Braun
% Assistent teachers: Adam Ponzi
% Exercise02: Single-compartment model
% Example script
% 30 October 2019

% In this exemplary script two vectors are generated and plotted, which
% contain values of possible input currents for the SCM exercise

clear all;
clc;

% First, generate a time vector
dt = 0.1; % time step, in ms
T  = 400; % total time, in ms
t  = 0:dt:T; % time vector, with successive time steps from 0 to T, in ms

%-------------------------------------------------------------------------
% As a first example, a simple step function is generated, i.e. during the
% first half of the time steps the input current is set to 0, during the
% second half the input current is set to the value i0.

% Define i0.
i0 = 2.5; % amplitude of electrode current, in nA/mm2 (25 nA/mm2)
% First, set all entries to 0.
ie = zeros(size(t)); % new functions: zeros(), size().
% Next, create a variable containing the index of the middle entry.
ix1 = round(length(t)/2); % new functions: round(), length()
% Now, create a variable containing the index of the last entry.
ix2 = length(t);
% Finally, increase all values from first to second index by i0
ie(ix1:ix2) = ie(ix1:ix2) + i0;

% Plot the input current
figure;
subplot(1,3,1); % a 1x3 matrix of axes, plot into the first one
plot(t,ie,'r'); % red is a nice color
xlabel('time [ms]');
ylabel('Current [nA]');


%-------------------------------------------------------------------------
% The second example is a harmonic oscillation - a sinusoidal current.

% some parameters
f = 10e-3; % frequency in kHz
w = 2*pi*f; % angular frequency in kHz, pi is a built in constant
% overwrite ie
ie = i0*sin(w*t); % w*t is dimensionless

subplot(1,3,2); % plot into second axis
plot(t,ie,'g'); % green is a nice color
xlabel('time [ms]');
ylabel('Current [nA]');

%-------------------------------------------------------------------------
% The third example is a high frequency random input current. You don't
% need to understand these rather confusing lines of code. 
tcoarse = 0:10*dt:T;
ie = i0 * interp1( tcoarse, 2*(rand(size(tcoarse))-0.5), t);

subplot(1,3,3); % plot into second axis
plot(t,ie,'c'); % cyan is a nice color...sometimes
xlabel('time [ms]');
ylabel('Current [nA]');

