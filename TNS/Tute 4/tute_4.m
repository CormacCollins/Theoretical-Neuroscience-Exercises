close all;
clear all;
clc;

% -------------------------------------------------------
% ------------------- Calc 1 ----------------------------
% 0 Current input
% we will observe a slow approach to voltage equilibrium
% for each voltage gate (& total voltage)

T = 40; %ms
dt = 0.1;
t = 0:dt:T;

ie = zeros(1, length(t)); %0 nA/mm2
V(1) = -70; %mV
n(1) = 0.3; %mV 
m(1) = 0.0; %mV
h(1) = 0.0; %mV

gNA= 1200; %microS/mm^2
gK = 360; %microS/mm^2

%see function at the bottom of file 
[V, n, m, h] = calc_volt(gNA, gK, V, n, m, h, ie, t ,dt);

figure(1)
subplot(1,2,1);
plot(t, V)
xlabel('time [ms]');
ylabel('Membrane Voltage [mV]');
subplot(1,2,2);
plot(t, n, 'r', 'LineWidth', 2.0);
hold on
plot(t, m, 'g--', 'LineWidth', 2.0);
plot(t, h, 'b', 'LineWidth', 2.0);
legend({"n", "m", "h"})

sgtitle ("No input current", 'fontweight', 'bold', 'FontSize',10)
hold off
xlabel('time [ms]');
ylabel('Gating rates');

% ------------------------------------------------------------------
% -------------- Calc 2 --------------------------------------------
% 100mV/mm2 current, we expect to see now constant action potentials
% given our fully functioning gating mechanism ---------------------
% We see the rapid m gate activity allowing an influx of Na, while 
% the h gate is already open at resting membraine voltage. Finally 
% the slowly inactivating h gate inhibits Na outlow, while the slowly
% increasing activity of the n gate causes the K+ influx to grow 
% larger and larger, causing the voltage to drop back towards the 
% resting potential with a slight over shoot (hyperpolarization)

ie = ones(1, length(t))*100; %100 nA/mm2

V_ss = V(end);
n_ss = n(end);
m_ss = m(end); 
h_ss = h(end);

V = [V_ss];
n = [n_ss];
m = [m_ss];
h = [h_ss];

[V, n, m, h] = calc_volt(gNA, gK, V, n, m, h, ie, t ,dt);

figure(2)
subplot(1,2,1);
plot(t,V)
xlabel('time [ms]');
ylabel('Membrane Voltage [mV]');
subplot(1,2,2);
plot(t, n, 'r', 'LineWidth', 2.0);
hold on
plot(t, m, 'g--', 'LineWidth', 2.0);
plot(t, h, 'b', 'LineWidth', 2.0);
legend({"n", "m", "h"}, 'Location', 'northeast')
sgtitle ("Constant current input - 100nA/mm^2", 'fontweight', 'bold', 'FontSize',10)
hold off
xlabel('time [ms]');
ylabel('Gating rates');

% ------------------------------------ Calc 3 -----------------------
% sodium block - our Veff becomes much smaller due to the 0 Na conductance
% this provides some +ve influx before the system reaches equilibrium 
% which is from the n gate reaching it's equil pot for K while the other gate has
% no influence and therefore no more +ve spikes occur

% ALso Leak conductance gives the initial -ve increase?


%new constant current
ie = ones(1, length(t))*100; %100 nA/mm2

V = [V_ss];
n = [n_ss];
m = [m_ss];
h = [h_ss];

gNA = 0;

[V, n, m, h] = calc_volt(gNA, gK, V, n, m, h, ie, t ,dt);

figure(3)
subplot(1,2,1);
plot(t, V)
xlabel('time [ms]');
ylabel('Membrane Voltage [mV]');
subplot(1,2,2);
plot(t, n, 'r', 'LineWidth', 2.0);
hold on
plot(t, m, 'g--', 'LineWidth', 2.0);
plot(t,h, 'b', 'LineWidth', 2.0);
legend({"n", "m", "h"}, 'Location', 'northwest')
sgtitle ("Na+ conductance block - Constant current input - 100nA/mm^2", 'fontweight', 'bold', 'FontSize',10)
hold off
xlabel('time [ms]');
ylabel('Gating rates');

% ---------------- Calc 4 -------------------------------
% K block - we see the inverse of calc 3. Where our initial m 
% gate rapid increase causes a rapid Na & +ve increase before
% the m gate brings the rate back down. Eventually this gate
% Na reach an equilibrium at a much more +ve charge
% Note: h never re-activates due to this high voltage, this shows
% the effect safety mechanism against an eccessive Na+ influx

V = [V_ss];
n = [n_ss];
m = [m_ss];
h = [h_ss];

gNA= 1200; %microS/mm^2
gK = 0; %microS/mm^2

[V, n, m, h] = calc_volt(gNA, gK, V, n, m, h, ie, t ,dt);

figure(4)
subplot(1,2,1);
plot(t, V)
xlabel('time [ms]');
ylabel('Membrane Voltage [mV]');
subplot(1,2,2);
plot(t, n, 'r', 'LineWidth', 2.0);
hold on
plot(t, m, 'g--', 'LineWidth', 2.0);
plot(t,h, 'b', 'LineWidth', 2.0);
legend({"n", "m", "h"}, 'Location', 'northeast')
sgtitle ("K+ conductance block - Constant current input - 100nA/mm^2", 'fontweight', 'bold', 'FontSize',10)
hold off
xlabel('time [ms]');
ylabel('Gating rates');



% -------- MAIN FUNCTION ---------------------------
% Input: various starting parameters that change
% through the tutorial.
% Returns: Voltage and gating variable rates vectors

function [V, n, m, h] = calc_volt(gNa, gK, V, n, m, h, ie, t, dt)
    
    %Reverse potentials
    EL = -54.402; %mV
    ENa = 50; %mV
    Ek = -77; %mV
    %Mem capacitance / leaky conductance
    cm = 10; %nF/mm^2
    gL = 3; % microS/mm^2

    for i=1:(size(t, 2)-1)  
        
        %New time varying constant for gating system (Now changes with voltage)
        Teff = cm / (gL + gNa*(m(i)^3)*h(i) + gK*(n(i)^4));
        %New equil pot, also influenced by changes in our gating variables.
        %Thus having an influence on our driving force (e.g. How +ve a spike the system might produce)
        Veff = (gL*EL + gNa*(m(i)^3)*h(i)*ENa + gK*(n(i)^4)*Ek + ie(i))/(gL + gNa*(m(i)^3)*h(i) + gK*(n(i)^4));
        
        %reaction times and equilibrium fractions for gates based off
        %kinetics equations
        %as functions of voltage
        [nInf, tau_n] = HH_equi_tau_n(V(i));
        [mInf, tau_m] = HH_equi_tau_m(V(i));
        [hInf, tau_h] = HH_equi_tau_h(V(i));
        
        %our 4 dynamical equations, all dependent on change in voltage
        n(i+1) = nInf + (n(i) - nInf)*exp(-dt/tau_n);
        m(i+1) = mInf + (m(i) - mInf)*exp(-dt/tau_m);
        h(i+1) = hInf + (h(i) - hInf)*exp(-dt/tau_h);
        V(i+1) = Veff + (V(i) - Veff)*exp(-dt/Teff);
        
    end
end

