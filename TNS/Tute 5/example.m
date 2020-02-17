% Course on theoretical neuroscience
% Teacher: Jochen Braun
% Assistent teachers: Ehsan Kakaei
% Exercise06: Operating point of a spiking neuron
% Due Date: 29.11.2018

clear all;
clc;

% Defining the variables: 

Vth = -54;       % Threshold potential in mV
Vreset = -70;    % Reset potential in mV
c_m = 10;        % Membrane capacitance in nF/mm^2
gL = 1.2;        % Leak conductance in microS/mm^2
g_ex = 0.1;      % Excitatory conductance in microS/mm^2
g_in = 0.5;      % Inhibitory conductance in microS/mm^2
EL = -65;        % Reversal potential in mV
E_ex = 0;        % Excitatory reversal potential in mV
E_in = -80;      % Inhibitory reversal potential in mV
v_ex = 20;       % Excitatory synaptic input rate in Hz
v_in = 20;       % Inhibitory synaptic input rate in Hz
tau_s_ex = 1;    % Excitatory synaptic time constant in ms
tau_s_in = 2;    % Inhibitory synaptic time constant in ms

% Time Vector: 

T = 1000;        % Total time period in ms
dt = 0.1;        % Time change in each step in ms
t = 0:dt:T;      % Time vector

N_ex = 1;        % Number of excitatory synapses 
N_in = 1;        % Number of inhibitory synapses
P_ex = synaptic_activation(N_ex.*v_ex, t, tau_s_ex)
P_in = synaptic_activation(N_in.*v_in, t, tau_s_in)

V = zeros(size(t));
V(1) = Vreset; %Initial membrane potential, in mV 
Vinf = zeros(size(t));
tau_eff = zeros(size(t));
ti = []
tisi = []
for i = length(t) 
    
    Vinf = (gL.*EL*+g_ex.*P_ex.*E_ex+g_in.*P_in.*E_in)/(g_L+g_ex.*P_ex+g_in.*P_in);
    tau_eff = c_m/(g_L+g_ex.*P_ex+g_in.*P_in);
end


for i = 1:(length(t)-1)
    % membrane voltage
    V(i+1) = Vinf(i) + (V(i)-Vinf(i))*exp(-dt/tau_eff(i));
    if V(i+1) >= Vth
        V(i+1) = Vreset;
        ti = [ti t(i)];
    end
end

figure;
subplot(2,1,1)
plot(t,V);
xlabel('time t in ms');
ylabel('membrane voltage V_m in mV');