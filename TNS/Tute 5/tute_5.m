

close all;
clear all;
clc;

% ----------------------------------------------------------------------------
% ------------------- Task 1 main function set up ----------------------------
% ----------------------------------------------------------------------------

T = 1000; %ms
dt = 0.1;
t = 0:dt:T;
V(1) = -70; %mV (Vreset)

Nex = 30;
Nin = 0;
Vex = 20; %hz
Vin = 20; %hz
Tau_ex = 1; %ms
Tau_in = 2; %ms
P_t_ex = synaptic_activation(Nex*Vex, t, Tau_ex);
P_t_in = synaptic_activation(Nin*Vin, t, Tau_in);

%see function at the bottom of file 
[V, spike_t] = calc_volt(V, P_t_ex, P_t_in, t, dt);
[V_no_spikes, spike_t_2] = calc_volt_no_spikes(V, P_t_ex, P_t_in, t, dt);

figure(1)
subplot(1,2,1);
plot(t, V)
xlabel('time [ms]');
ylabel('Membrane Voltage [mV]');
subplot(1,2,2);
plot(t, V_no_spikes);
xlabel('time [ms]');
ylabel('Membrane Voltage no spikes [mV]');
sgtitle ("Membrane voltage spikes(left) and no-spikes(right) - 30 excitatory neurons ", 'FontSize',10);

[t_isi, mean_spike, std_spike, coef_var, avg_spike_rate] = get_Spike_stats(spike_t, T)

%--------------------------- 4.1 analysis ---------------------------------

%Increase neuron numbers until required frequency reached
%Store the spike rates and times
neuron_increase = 5;
goal_spike_rate_Hz = 70;
avg_spike_rate = 0;
Nex = 0;
T = 20000; %ms
dt = 0.1;
t = 0:dt:T;
spike_rates = [];
neuron_nums = [];
coef_vec = [];
avg_non_spike_V = []

%Used this to get all the spike rates for increasing neuron nums
%Takes a long time with 20,000ms so I saved the values below.
run_optimal_test = 0
if run_optimal_test
    while avg_spike_rate < goal_spike_rate_Hz
        %Get synaptic rates
        P_t_ex = synaptic_activation(Nex*Vex, t, Tau_ex);
        P_t_in = synaptic_activation(Nin*Vin, t, Tau_in);
        %Spiking and non-spiking avg
        %These could be the same function for better speed but I'm lazy
        [V_no_spikes, spike_rate_0] = calc_volt_no_spikes(V, P_t_ex, P_t_in, t, dt);
        [V, spike_t] = calc_volt(V, P_t_ex, P_t_in, t, dt);
        
        %Get stats
        [t_isi, mean_spike, std_spike, coef_var, avg_spike_rate] = get_Spike_stats(spike_t, T);
        spike_rates = [spike_rates avg_spike_rate];
        neuron_nums = [neuron_nums Nex];
        
        fprintf('%i neuron numbers calculated\n', Nex);
        Nex = Nex + neuron_increase;
        coef_vec = [coef_vec coef_var];
        avg_non_spike_V = [avg_non_spike_V mean(V_no_spikes)];
    end
else
    %previously determined from long running code at 20,000ms 
    spike_rates = [0,0,0,0,0.650000000000000,3.70000000000000,10.0500000000000,18.9000000000000,30.5500000000000,41.6000000000000,54.0500000000000,66.4500000000000,79.1000000000000];
    neuron_nums = [0,5,10,15,20,25,30,35,40,45,50,55,60];
    coef_vec = [NaN,NaN,NaN,NaN,1.06929538478065,1.02353697622528,0.841217020487820,0.746454698228152,0.667169542271561,0.614162138614899,0.540174201027236,0.491867418578280,0.487411790718094];
    avg_non_spike_V = [-65.0020958478540,-63.5991090533407,-62.2960040018253,-60.9294870847454,-59.6747113190395,-58.4218605637168,-57.3004668442995,-56.1468409581443,-55.0798243447637,-54.0985356900026,-53.0357073197125,-52.1679316680672,-51.1915492772132];
end

figure(2)

subplot(1,2,1);
scatter(neuron_nums, spike_rates)
xlabel('Excitatory neurons');
ylabel('Avg Spike rate (Hz)');

subplot(1,2,2);
scatter(avg_non_spike_V, coef_vec)
xlabel('Average voltage potential non-spiking');
ylabel('coefficient of variance of inter spike intervals');
sgtitle ({'Average spike rate per excitatory neuron &','Coefficient of variance against average non-spiking voltage potential'}, 'FontSize',10)

% ------------------- 4.2 Excitation and inhibition -------------------------
%Increase neuron numbers until required frequency reached
%Store the spike rates and times
neuron_decrease = 3;
goal_spike_rate_Hz = 150;
avg_spike_rate = 0;
Nex = 100;
Nin = 50;
T = 20000; %ms
dt = 0.1;
t = 0:dt:T;
spike_rates = [];
neuron_nums = [];
coef_vec = [];
avg_non_spike_V = []

%Used this to get all the spike rates for increasing neuron nums
%Takes a long time with 20,000ms so I saved the values below.
run_optimal_test = 0
if run_optimal_test
    while avg_spike_rate < goal_spike_rate_Hz
        %Get synaptic rates
        P_t_ex = synaptic_activation(Nex*Vex, t, Tau_ex);
        P_t_in = synaptic_activation(Nin*Vin, t, Tau_in);
        %Spiking and non-spiking avg
        %These could be the same function for better speed but I'm lazy
        [V_no_spikes, spike_rate_0] = calc_volt_no_spikes(V, P_t_ex, P_t_in, t, dt);
        [V, spike_t] = calc_volt(V, P_t_ex, P_t_in, t, dt);
        
        %Get stats
        [t_isi, mean_spike, std_spike, coef_var, avg_spike_rate] = get_Spike_stats(spike_t, T);
        spike_rates = [spike_rates avg_spike_rate];
        neuron_nums = [neuron_nums Nin];
        
        fprintf('%i neuron numbers calculated\n', Nin);
        avg_spike_rate
        Nin = Nin  - neuron_decrease;
        coef_vec = [coef_vec coef_var];
        avg_non_spike_V = [avg_non_spike_V mean(V_no_spikes)];
    end
else
    %previously determined from long running code at 20,000ms
    spike_rates = [0.750000000000000,0.700000000000000,1.50000000000000,2.55000000000000,3.45000000000000,5.60000000000000,8.80000000000000,12,17.1500000000000,24.9000000000000,35.8500000000000,47.0500000000000,65,84.0500000000000,104.900000000000,128.600000000000,154.750000000000];
    neuron_nums = [50,47,44,41,38,35,32,29,26,23,20,17,14,11,8,5,2];
    coef_vec = [0.964636917003063,0.909961141969051,0.864433559165279,1.03860847251034,1.13142019258801,1.11843625228701,1.07711813279846,1.08737546237905,0.970068922275194,1.02552373353212,0.971589032035350,0.901490423959994,0.840875157002311,0.781828494026483,0.676137092568253,0.559530411587103,0.437711033318903];
    avg_non_spike_V = [-65.7643464085578,-65.1689893226688,-64.7097328361696,-64.1263168739829,-63.4628731993306,-62.6464699038822,-61.7784481212210,-61.1398437304006,-60.0402380917300,-59.0804163595128,-57.7341881426554,-56.5055558388017,-54.9638700161041,-53.2942227925254,-51.4897205434677,-49.3003999417458,-46.6760747733664];
end

[m_cv, index] = max(coef_vec)
m_neuron_nums = neuron_nums(end - index)
m_spike_rates = spike_rates(end - index)
m_avg_non_spike_V = avg_non_spike_V(index)


figure(3)

subplot(1,2,1);
scatter(neuron_nums, spike_rates)
xlabel('Inhibitory neurons');
ylabel('Avg Spike rate (Hz)');

subplot(1,2,2);
scatter(avg_non_spike_V, coef_vec)
xlabel('Average voltage potential non-spiking');
ylabel('coefficient of variance of inter spike intervals');
sgtitle ({'Average spike rate per reduction in inhibitory neuron (Excitatory neurons fixed 100) &','Coefficient of variance against average non-spiking voltage potential'}, 'FontSize',10)

% -------- MAIN FUNCTION 1 ---------------------------

function [V, spike_t, V_no_spikes] = calc_volt(V, P_t_ex, P_t_in, t, dt)
    Vth = -54;%mV
    Vreset = -70;%mV
    cm = 10; %nF/mm^2
    %Reverse potentials
    %leak
    EL = -65; %mV
    %excitatory pot
    Eex = 0; %mV
    Ein = -80; %mV
    %conductance
    gL = 1.2; %microS/mm^2
    gEx = 0.1; %microS/mm^2
    gIn = 0.5; %microS/mm^2
    
    V_no_spikes(1) = V(1);

    Teff = [];
    Veff = [];
    spike_t = []; 
    for i=1:(size(t, 2)-1)  
        
        %New time varying constant using excitory and inhibitory rates
        Teff = [Teff (cm / (gL + gEx*P_t_ex(i) + gIn*P_t_in(i)))];
        
        %Veff - volrage equilibrium influenced by excitatory
        % and inhibitory input
        Veff = [Veff (gL*EL + gEx*P_t_ex(i)*Eex + gIn*P_t_in(i)*Ein) /(gL + gEx*P_t_ex(i) + gIn*P_t_in(i))];
        
        %Dynamical equations, all dependent on change in voltage
        %dv = (1/Teff)*(Veff - V(i))*dt;
        %V(i+1) = V(i) + dv;
        V(i+1) = Veff(i) + (V(i) - Veff(i))*exp(-dt/Teff(i));
        
        if V(i+1) >= Vth
            V(i+1) = Vreset;
            spike_t = [spike_t t(i)];
        end
        
    end
    
end

% Main function 2- no spike
function [V, spike_t] = calc_volt_no_spikes(V, P_t_ex, P_t_in, t, dt)
    Vth = -54;%mV
    Vreset = -70;%mV
    cm = 10; %nF/mm^2
    %Reverse potentials
    %leak
    EL = -65; %mV
    %excitatory pot
    Eex = 0; %mV
    Ein = -80; %mV
    %conductance
    gL = 1.2; %microS/mm^2
    gEx = 0.1; %microS/mm^2
    gIn = 0.5; %microS/mm^2

    Teff = [];
    Veff = [];
    spike_t = []; 
    for i=1:(size(t, 2)-1)  
        
        %New time varying constant using excitory and inhibitory rates
        Teff = [Teff (cm / (gL + gEx*P_t_ex(i) + gIn*P_t_in(i)))];
        
        %Veff - volrage equilibrium influenced by excitatory
        % and inhibitory input
        Veff = [Veff (gL*EL + gEx*P_t_ex(i)*Eex + gIn*P_t_in(i)*Ein) /(gL + gEx*P_t_ex(i) + gIn*P_t_in(i))];
        
        %Dynamical equations, all dependent on change in voltage
        %dv = (1/Teff)*(Veff - V(i))*dt;
        %V(i+1) = V(i) + dv;
        V(i+1) = Veff(i) + (V(i) - Veff(i))*exp(-dt/Teff(i));
        
    end
    
end

function[t_isi, mean_spike, std_spike, coef_var, avg_spike_rate] = get_Spike_stats(spike_t, T)
    t_isi = diff(spike_t);
    mean_spike = mean(t_isi);
    std_spike = std(t_isi);
    coef_var = std_spike/mean_spike;
    avg_spike_rate = length(spike_t)/(T/1000); %Hz
end
