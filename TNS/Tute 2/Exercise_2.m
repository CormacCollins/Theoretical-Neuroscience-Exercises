% Course on theoretical neuroscience
% Teacher: Jochen Braun
% Assistent teachers: Adam Ponzi
% Exercise02: Single-compartment model
% Main script
% 30 October 2019


% Run and look at Ie_example.m and try to fully understand it!

% --------------------------------------------------------------
% ----------------------- Main Task ----------------------------
% --------------------------------------------------------------

% 1. Clear workspace (optional)
clear all
clc

% 2. Define parameters (rm, cm, i0, taum).
rm = 0.9
cm = 12
taum = 10.8

% 3. Define time vector (dt, T, t).
T = 250
dt = 0.05
t = 0:dt:T

% 4. Generate your own input current vector.
iCurrVec = ones(1, length(t))*25

% 5. Plot the current into the first axis
figure(1)
subplot(1,2,1);
plot(iCurrVec)
axis([0 length(t) 24 26])
xlabel('time [ms]');
ylabel('Input current [mV]');

% 6. Iteratively calculate membrane potential and capacitor current

V(1)= 0; % first entry in vector for membrane Potential, mV

% Numerically integrate the ODE dV/dt = -V/tau.
for i=1:(size(t, 2)-1)
    %rearranged original equation - where Vinf(i.e Equil potential) = Rm * Ie (membrane res * Input current)
    dV = (dt*(rm*iCurrVec(i) - V(i)))/taum; 
    V(i+1) = V(i)+dV;
end

% 7. Plot the voltage into the second axis
subplot(1,2,2);
plot(V)
axis([0 length(t) 0 25])
xlabel('time [ms]');
ylabel('Membrane Voltage [mV]');

% --------------------------------------------------------------
% ----------------------- Additional Current -------------------
% --------------------------------------------------------------

i0 = 2.5;
f = .01; %kHz
stepCurrent = i0*sign(sin(t.*(2*pi*f)))
for i=1:(size(t, 2)-1)
    dV = (dt*(rm*stepCurrent(i) - V(i)))/taum; 
    V(i+1) = V(i)+dV;
end
figure(2)
subplot(1,2,2);
plot(V)
axis([0 length(t) -3 3])
xlabel('time [ms]');
ylabel('Membrane Voltage [mV]');
subplot(1,2,1);
plot(stepCurrent)
axis([0 length(t) -3 3])
xlabel('time [ms]');
ylabel('Input current [mV]');

sinusCurrentLow = i0*sin(t*(2*pi*f))
for i=1:(size(t, 2)-1)
    dV = (dt*(rm*sinusCurrentLow(i) - V(i)))/taum; 
    V(i+1) = V(i)+dV;
end
figure(3)
subplot(1,2,2);
plot(V)
axis([0 length(t) -3 3])
xlabel('time [ms]');
ylabel('Membrane Voltage (sinus low) [mV]');
subplot(1,2,1);
plot(sinusCurrentLow)
axis([0 length(t) -3 3])
xlabel('time [ms]');
ylabel('Input current sinus low [mV]');


f = 0.1; %kHz
sinusCurrentHigh = i0*sin(t.*(2*pi*f))
for i=1:(size(t, 2)-1)
    dV = (dt*(rm*sinusCurrentHigh(i) - V(i)))/taum; 
    V(i+1) = V(i)+dV;
end
figure(4)
subplot(1,2,2);
plot(V)
axis([0 length(t) -3 3])
xlabel('time [ms]');
ylabel('Membrane Voltage (sinus high) [mV]');
subplot(1,2,1);
plot(sinusCurrentHigh)
axis([0 length(t) -3 3])
xlabel('time [ms]');
ylabel('Input current sinus high [mV]');

tcoarse = 0:10*dt:T;
ie = i0 * interp1( tcoarse, 2*(rand(size(tcoarse))-0.5), t); %from ie_example
for i=1:(size(t, 2)-1)
    dV = (dt*(rm*ie(i) - V(i)))/taum; 
    V(i+1) = V(i)+dV;
end
figure(5)
subplot(1,2,2);
plot(V)
axis([0 length(t) -3 3])
xlabel('time [ms]');
ylabel('Membrane Voltage (random) [mV]');
subplot(1,2,1);
plot(ie)
axis([0 length(t) -3 3])
xlabel('time [ms]');
ylabel('Input current random [mV]');


%use original voltage from constant input
capacitorCurrent = [];
membraneCurrent = []; %iR (resistance current)
equilbriumPot = []; %iC (capacitance current)

%make a slower relaxation for this graph
rm = 5
cm = 12
taum = rm*cm
v(1) = -65
for i=1:(size(t, 2)-1)
	%rearranged original equation - where Vinf(i.e Equil potential) = Rm * Ie (membrane res * Input current)
	dV = (dt*(rm*iCurrVec(i) - V(i)))/taum; 
	V(i+1) = V(i)+dV;
	capacitorCurrent(i) = rm*(dV/dt);
	membraneCurrent(i) = V(i)/rm; 
	equilbriumPot(i) = rm*iCurrVec(i);

end
subplot(1,3,1);
hold on
plot(membraneCurrent)
xlabel('time [ms]');
ylabel('membrane current [mV]');
subplot(1,3,1);
plot(capacitorCurrent)
xlabel('time [ms]');
ylabel('capacitor current [mV]');
legend('membrane current', 'capacitor current', 'Location','northoutside')

subplot(1,3,2);
plot(equilbriumPot)
xlabel('time [ms]');
ylabel('equilbrium potential [mV]');

subplot(1,3,3)
plot(V);
xlabel('time [ms]');
ylabel('Voltage [mV]');
