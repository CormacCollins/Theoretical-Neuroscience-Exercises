close all;
clear all;
clc;

rm = 1.5; %MOhmm2;` 
cm = 20; %nF/mm2
taum = rm*cm;
Vreset = -65; %mV
EL = Vreset;
V_th = -50;
V(1) = -65;

T = 500; %ms
dt = 0.1;
t = 0:dt:T;

iCurrVec = ones(1, length(t))*12; %12 nA/mm2
tSpike = [];
interSpikeInt = [];

for i=1:(size(t, 2)-1)

    V(i + 1) = V(i)*exp(-dt/taum) + (iCurrVec(i)*rm + EL)*(1 - exp(-dt/taum));
    if (V(i+1)>=V_th)

        V(i+1) = Vreset;
        tSpike = [tSpike t(i+1)];
        if length(tSpike) > 1
            interSpikeInt = [interSpikeInt (tSpike(end-1)-tSpike(end))];
        end
    end

end



% 7. Plot the voltage into the second axis
figure(1)
subplot(1,2,1);
plot(t, iCurrVec)
xlim([0 T])
xlabel('Time [ms]');
ylabel('Current [nA/mm^2]');
subplot(1,2,2);
plot(t,V)
xlim([0 T])
xlabel('Time [0.1ms]');
ylabel('Membrane Voltage [mV]');
sgtitle ("Constant input current (12 nA/mm^2)", 'FontSize',10)

% Write reset_steps into command window


'Figure 1 spikes'
tSpike
'Figure 1 spike intervals'
interSpikeInt


tSpike = [];
interSpikeInt = [];

i0 = 12;
f = .004; %kHz
sineLow = i0*sin(t*(2*pi*f));
for i=1:(size(t, 2)-1)

    V(i + 1) = V(i)*exp(-dt/taum) + (sineLow(i)*rm + EL)*(1 - exp(-dt/taum));

    if (V(i+1)>=V_th)

        V(i+1) = Vreset;
        tSpike = [tSpike t(i+1)];
        if length(tSpike) > 1
            interSpikeInt = [interSpikeInt (tSpike(end-1)-tSpike(end))];
        end
    end

end
figure(2)
subplot(1,2,1);
plot(sineLow)
xlim([0 length(t)])
xlabel('Time [ms]');
ylabel('Current [nA/mm^2]');
subplot(1,2,2);
plot(t,V)
xlim([0 T])
xlabel('Time [0.1ms]');
ylabel('Membrane Voltage [mV]');
sgtitle("Sinusoidal input current, 4 Hz, (nA/mm^2)", 'FontSize',10)

'Figure 2 spikes'
tSpike
'Figure 2 spike intervals'
interSpikeInt

tSpike = [];
interSpikeInt = [];

i0 = 12;
f = .020; %kHz
sineHigh = i0*sin(t*(2*pi*f));
for i=1:(size(t, 2)-1)

    V(i + 1) = V(i)*exp(-dt/taum) + (sineHigh(i)*rm + EL)*(1 - exp(-dt/taum));

    if (V(i+1)>=V_th)

        V(i+1) = Vreset;
        tSpike = [tSpike t(i+1)];
        if length(tSpike) > 1
            interSpikeInt = [interSpikeInt (tSpike(end-1)-tSpike(end))];
        end
    end

end

'Figure 3 spikes'
tSpike
'Figure 3 spike intervals'
interSpikeInt


figure(3)
subplot(1,2,1);
plot(sineHigh)
xlim([0 length(t)])
xlabel('Time [ms]');
ylabel('Current [nA/mm^2]');
subplot(1,2,2);
plot(t,V)
xlim([0 T])
xlabel('Time [0.1ms]');
ylabel('Membrane Voltage [mV]');
sgtitle("Sinusoidal input current, 20 Hz, (nA/mm^2)", 'FontSize',10)

tSpike = [];
interSpikeInt = [];

i0 = 12;
f = .020; %kHz
current = [];


for i=1:(size(t, 2)-1)

    i_t = i0*(t(i)/150);
    current = [current i_t];
    V(i + 1) = V(i)*exp(-dt/taum) + ( i_t*rm + EL)*(1 - exp(-dt/taum));

    if (V(i+1)>=V_th)

        V(i+1) = Vreset;
        tSpike = [tSpike t(i+1)];
        if length(tSpike) > 1
            interSpikeInt = [interSpikeInt (tSpike(end-1)-tSpike(end))];
        end
    end

end

'Figure 4 spikes' 
tSpike
'Figure 4 spike intervals'
interSpikeInt

figure(4)
subplot(1,2,1);
plot(current)
xlim([0 length(t)])
xlabel('Time [ms]');
ylabel('Current [nA/mm^2]');
subplot(1,2,2);
plot(t,V)
xlim([0 T])
xlabel('Time [0.1ms]');
ylabel('Membrane Voltage [mV]');
sgtitle("Ramping current increasing i0*t/150ms (nA/mm^2)", 'FontSize',10)


