% ---------------- Tute 7 ------------------------
clear all
clc
close all

%% Assignment 1: Conditional response probability

n = 1000;
s1 = 2;
s2 = s1;

%Function to create stim vector (2*n) named Sin and the response of the neuron (resp)
[resp, Sin] = stim_response(s1, s2, n);

% ------- A = 2, B = 2 ------------------------------------

figure;
subplot(1, 3, 1)
histogram(resp,'Normalization','probability')
title("P(A & B) s1, s2 = 2");
xlabel('Hz response');
xlim([0 30])

%A - get A from first row of signal
ind1 = find(Sin(1,:));
% get signal responses that corresponded with those A stimuli
p_x_given_A = resp(ind1);
subplot(1, 3, 2)
histogram(p_x_given_A,'Normalization','probability')
title("P(x|A) s1 = 2");
xlabel('Hz response');
xlim([0 30])

%B - get B from first row of signal
ind2 = find(Sin(2,:));
% get signal responses that corresponded with those B stimuli
p_x_given_B = resp(ind2);
subplot(1, 3, 3)
histogram(p_x_given_B,'Normalization','probability')
title("P(x|B) s2 = 2");
xlabel('Hz response');
xlim([0 30])

% Same as above but with new signal strenghts --------------
% ------- A = 7, B = 20 ------------------------------------

[resp, Sin] = stim_response(7, 20, n);
figure;
subplot(1, 3, 1)
histogram(resp,'Normalization','probability')
title("P(A & B) s1=7 s2=20");
xlabel('Hz response');
xlim([0 30])

%A
ind1 = find(Sin(1,:));
p_x_given_A = resp(ind1);
subplot(1, 3, 2)
histogram(p_x_given_A,'Normalization','probability')
title("P(x|A) s1 = 7");
xlabel('Hz response');
xlim([0 30])

%B
ind2 = find(Sin(2,:));
p_x_given_B = resp(ind2);
subplot(1, 3, 3)
histogram(p_x_given_B,'Normalization','probability')
title("P(x|B) s1 = 20");
xlabel('Hz response');
xlim([0 30])

%% Assignment 2 - ROC curve 

n = 1000;
s1 = 20; s2 = 20;
[resp, Sin] = stim_response(s1, s2, n);  

% Get response distribution for signal A in terms of probability - i.e. probability
% that of getting some neuronal freq. x given Stim A (This of course is a
% distribution and varies arond a mean)
ind1 = find(Sin(1,:));
p_x_A = histcounts(resp(ind1), 'Normalization', 'probability', 'BinLimits',[0 30]);
% Same for B
ind2 = find(Sin(2,:));
p_x_B = histcounts(resp(ind2), 'Normalization', 'probability', 'BinLimits',[0 30]);
%Calculating AUC from rhs:
% that is taking 1=(total AUC) and minusing AUC corresponding to small step along x-axis
A_AUC_vec = ones(1, length(p_x_A)) - cumsum(p_x_A);
B_AUC_vec = ones(1, length(p_x_B)) - cumsum(p_x_B);

figure;
plot(B_AUC_vec, A_AUC_vec);
title("ROC")
'reliability (fraction correct)'
xlabel('B fraction');
ylabel('A fraction');
reliability = trapz(B_AUC_vec, A_AUC_vec)

%% Assignment 3 - Stimulus likelihood

%Marginal probabilities P(x)
p_x = (1/2).*p_x_A + (1/2).*p_x_B;
%Likelihood probabilities
L_a_x = (p_x_A.*1/2)./p_x;
L_b_x = (p_x_B.*1/2)./p_x;

figure;
hold all
plot(L_a_x)
plot(L_b_x)
xlabel('Observed response (Hz)');
ylabel('Likelihood');
legend('A', 'B')
sgtitle ("L(A|x) & L(B|x)", 'FontSize',10);
hold off


    
    
    
    
    
    


