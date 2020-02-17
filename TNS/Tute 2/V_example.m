% Course on theoretical neuroscience
% Teacher: Jochen Braun
% Assistent teachers: Adam Ponzi
% Exercise02: Single-compartment model
% Example script
% 30 October 2019

% In this exemplary script a vector is iteratively generated using a 
% for-loop. Unlike in the real exercise there is no electrode current.

clear all;
clc;

% Declare parameters
dt = 0.1; % time step, in ms
T  = 70; % total time, in ms
t  = 0:dt:T; % time vector, with successive time steps from 0 to T

tau = 10; % ms
V(1) = -65; % first entry in vector for membrane Potential, mV

% Numerically integrate the ODE dV/dt = -V/tau.
% Iterate over successive time steps.
for i=1:length(t)-1 % Why -1?
    % Compute dV, the change in membrane potential at time i.
    dV = -V(i)/tau*dt;
    % Compute membrane potential at time i+1.
    V(i+1) = V(i)+dV;    
end

% Plot membrane potential against time.
% Both vectors need to have the same number of elements. That's why there
% is a '-1' in the header of the for loop.
plot(t,V,'g');
xlabel('time [ms]');
ylabel('V_{mem} [mV]');
