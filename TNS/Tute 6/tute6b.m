% ---------------------- Optional assignment ---------------------------------
% -----------------------Neuron 2 ------------------------------

n_image_size = 50;
neuron_func = @MysteriousNeuron2;
WhiteNoise_func = @WhiteNoise;
n_simulations = 100000;

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
%v = diag(D)

%Combine arbitrary amount of principal eigen vectors into filter image
%lin_comb = zeros(n_image_size, n_image_size);
%for i=0:50
 %   lin_comb = lin_comb + v(end-i).*reshape(V(:, end-i), [n_image_size n_image_size]);
%end
