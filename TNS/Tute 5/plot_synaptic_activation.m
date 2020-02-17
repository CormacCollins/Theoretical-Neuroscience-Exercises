% Course on theoretical neuroscience
% Teacher: Jochen Braun
% Exercise06: Operating point of a spiking neuron
% Example script
% In this exemplary script the function 'synaptic_activation.m' is
% called to generate a vector of synaptic impulses. The time course of the
% synaptic activation is plotted.

clear all;
clc;
% Before we call the function, we define some variables.

nu = 12; % spike rate of a single neuron in Hz
N_nrn = 5; % number of presynaptic neurons in (nA mV s^3)/(kg �m^2)
t = 0:0.1:100; % time vector with all time steps in ms.
tau_syn = 2; % synaptic time constant in ms.

% Call the function. Use N_nrn*nu to pass the total frequency
P = synaptic_activation(N_nrn*nu, t, tau_syn);


plot(t,P,'k');
xlabel('time [ms]');
ylabel('total postsynaptic activation (normalized)');
