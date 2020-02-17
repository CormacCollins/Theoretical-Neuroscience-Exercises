
% -------------------------------------------------------------
% Simulated changing of Neuron response to stimulus type 1 & 2
% -------------------------------------------------------------

clc
clear all

n = 1000;
s1 = 20;
s2 = s1;

[resp, Sin] = stim_response(s1, s2, n);   
    
criteria_range = 0:0.5:50
figure;
for iX=criteria_range
    [resp, Sin] = stim_response(iX, iX, n);
    
    %A
    ind1 = find(Sin(1,:));
    p_x_given_A = resp(ind1);
    histogram(p_x_given_A,'Normalization','probability')
    title(['P(x| A & B) s = ', num2str(iX)]);
    xlabel('Hz response');
    xlim([0 40])
    hold on
    %B
    ind2 = find(Sin(2,:));
    p_x_given_B = resp(ind2);
    histogram(p_x_given_B,'Normalization','probability')
    legend('A', 'B')'
    hold off
    pause(0.2);
end