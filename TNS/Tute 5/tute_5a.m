%Increase neuron numbers until required frequency reached
%Store the spike rates and times
neuron_increase = 5;
goal_spike_rate_Hz = 70;
avg_spike_rate = 0;
Nex = 0;
spike_rates = [];
neuron_nums = [];
T = 20000; %ms
dt = 0.1;
t = 0:dt:T;
while avg_spike_rate < goal_spike_rate_Hz
    P_t_ex = synaptic_activation(Nex*Vex, t, Tau_ex);
    P_t_in = synaptic_activation(Nin*Vin, t, Tau_in);

    [V, spike_t] = calc_volt(V, P_t_ex, P_t_in, t, dt);
    avg_spike_rate = length(spike_t)/(T/1000); %Hz
    spike_rates = [spike_rates avg_spike_rate];
    neuron_nums = [neuron_nums Nex];
    Nex = Nex + neuron_increase;
end

figure(2)
scatter(spike_rates, neuron_nums)
xlabel('neurons');
ylabel('Spike rate (Hz)');