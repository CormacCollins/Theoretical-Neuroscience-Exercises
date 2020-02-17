% --------------------- stimulate_neuron -----------------------------
% Takes params needed to call any type of Spot stim (a function that
% takes no params)
% and any neuron function that returns a spike rate value
% also returns a weighted average value

function [resp_wt_avg]  = ...
    stimulate_neuron_get_weighted_resp(n_image_size, neuron_function_handle, image_stim_handle, n_simulations)
    s_scaled = zeros(n_image_size:n_image_size);
    r_vec = [];    
    for i = 1:n_simulations  
        S = image_stim_handle(n_image_size);
        r = neuron_function_handle(S);
        r_vec(i) = r;
        s_scaled = s_scaled + r*S;
    end    
    resp_wt_avg = (1/sum(r_vec))*s_scaled;   
end


