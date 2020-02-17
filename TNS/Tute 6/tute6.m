clear all
clc
close all


% ---------------------- onbar ---------------------------------
% -----------------------Neuron 1 & 2 ------------------------------
n_image_size = 50;
orientations = linspace(0, pi, 15);
neuron_func = @MysteriousNeuron1;
onbar_func = @OnBar;
n_simulations = 1000;

[avg_resp, avg_resp_sq, avg_resp_std, cv]  = ...
    stimulate_neuron(n_image_size, orientations, neuron_func, onbar_func, n_simulations);

figure;
subplot(1,2,1);
hold all
plot(orientations, avg_resp)
plot(orientations, avg_resp + cv, 'k--')
plot(orientations, avg_resp - cv, 'k--')

xlabel('Orientation (angle in radians)');
ylabel('Average spike frequency response - Neuron 1');
sgtitle ("On Bar average response for changes in angle", 'FontSize',10);
hold off

neuron_func = @MysteriousNeuron2;

[avg_resp, avg_resp_sq, avg_resp_std, cv]  = ...
    stimulate_neuron(n_image_size, orientations, neuron_func, onbar_func, n_simulations);

subplot(1,2,2);
hold all
plot(orientations, avg_resp)
plot(orientations, avg_resp + cv, 'k--')
plot(orientations, avg_resp - cv, 'k--')
xlabel('Orientation (angle in radians)');
ylabel('Average spike frequency response - Neuron 2');
hold off



% ---------------------- offbar ---------------------------------
% -----------------------Neuron 1 & 2 ---------------------------

neuron_func = @MysteriousNeuron1;
offbar_func = @OffBar;

[avg_resp, avg_resp_sq, avg_resp_std, cv]  = ...
    stimulate_neuron(n_image_size, orientations, neuron_func, offbar_func, n_simulations);

figure;
subplot(1,2,1);
hold all
plot(orientations, avg_resp)
plot(orientations, avg_resp + cv, 'k--')
plot(orientations, avg_resp - cv, 'k--')
xlabel('Orientation (angle in radians)');
ylabel('Average spike frequency response - Neuron 1');
hold off

neuron_func = @MysteriousNeuron2;

[avg_resp, avg_resp_sq, avg_resp_std, cv]  = ...
    stimulate_neuron(n_image_size, orientations, neuron_func, offbar_func, n_simulations);

subplot(1,2,2);
hold all
plot(orientations, avg_resp)
plot(orientations, avg_resp + cv, 'k--')
plot(orientations, avg_resp - cv, 'k--')
xlabel('Orientation (angle in radians) ');
ylabel('Average spike frequency response - Neuron 2');
sgtitle ("Off Bar average response for changes in angle", 'FontSize',10);
hold off


% ---------------------- OnSpot ---------------------------------
% -----------------------Neuron 1 & 2 ------------------------------
n_image_size = 50;
neuron_func = @MysteriousNeuron1;
neuron_func2 = @MysteriousNeuron2;
onspot_func = @OnSpot;
n_simulations = 1000;

[S_bar]  = stimulate_neuron_get_weighted_resp(n_image_size, neuron_func, onspot_func, n_simulations);
[S_bar2]  = stimulate_neuron_get_weighted_resp(n_image_size, neuron_func2, onspot_func, n_simulations);

figure;
subplot(1,2,1);
pcolor(S_bar)
subplot(1,2,2);
pcolor(S_bar2);
sgtitle ("On Spot weighted response", 'FontSize',10);

% ---------------------- OffSpot ---------------------------------
% -----------------------Neuron 1 & 2 ------------------------------

offspot_func = @OffSpot;

[S_bar]  = stimulate_neuron_get_weighted_resp(n_image_size, neuron_func, offspot_func, n_simulations);
[S_bar2]  = stimulate_neuron_get_weighted_resp(n_image_size, neuron_func2, offspot_func, n_simulations);

figure;
subplot(1,2,1);
pcolor(S_bar)
subplot(1,2,2);
pcolor(S_bar2);
sgtitle ("Off Spot weighted response", 'FontSize',10);

% ---------------------- Whitenoise ---------------------------------
% -----------------------Neuron 1 & 2 ------------------------------

n_image_size = 50;
neuron_func = @MysteriousNeuron1;
neuron_func2 = @MysteriousNeuron2;
WhiteNoise_func = @WhiteNoise;
n_simulations = 5000;

[S_bar]  = stimulate_neuron_get_weighted_resp(n_image_size, neuron_func, WhiteNoise_func, n_simulations);
[S_bar2]  = stimulate_neuron_get_weighted_resp(n_image_size, neuron_func2, WhiteNoise_func, n_simulations);

figure;
subplot(1,2,1);
pcolor(S_bar)
subplot(1,2,2);
pcolor(S_bar2);
sgtitle ("White noise weighted response", 'FontSize',10);


% ---------------------- Optional assignment ---------------------------------
% -----------------------Neuron 2 ------------------------------

n_image_size = 50;
neuron_func = @MysteriousNeuron2;
WhiteNoise_func = @OnSpot;
n_simulations = 1000;

[resp_wt_avg_cv]  = ...
    stimulate_neuron_get_weighted_resp_cov(n_image_size, neuron_func, WhiteNoise_func, n_simulations);


[V,D] = eig(resp_wt_avg_cv); 
X = sort(diag(D), 'descend');


%Plotting of principal eigen vecs togethar
figure;
subplot(1,2,1);
v = reshape(V(:, end), [n_image_size n_image_size]);
pcolor(v);
subplot(1,2,2);
v2 = reshape(V(:, end-1), [n_image_size n_image_size]);
pcolor(v2);
v = diag(D)

%Combine arbitrary amount of principal eigen vectors into filter image
lin_comb = zeros(n_image_size, n_image_size);
for i=0:50
    lin_comb = lin_comb + v(end-i).*reshape(V(:, end-i), [n_image_size n_image_size]);
end

subplot(1,2,1);
bar(1:500, X(1:500));
xlabel('Eigen values in order of strength');
ylabel('Strength of Eigen value');
sgtitle ("Eigen Values & Receptive strength of linear combination eig vec (50)", 'FontSize',10);
subplot(1,2,2);
pcolor(lin_comb);



