% --------------------- stimulate_neuron -----------------------------
% Takes params needed to call any type of Bar image stim (a function that
% takes a param)
% and any neuron function that returns a spike rate value

function [avg_resp, avg_resp_sq, avg_resp_std, cv]  = ...
    stimulate_neuron(n_image_size, var_range_function, neuron_function_handle, image_stim_handle, n_simulations)
    avg_resp = [];
    avg_resp_sq = [];
    avg_resp_std = [];
    r_vec = [];
    %Loop through a theta range as per var_range_function
    for theta=var_range_function
        avg_r = 0;
        avg_r_sq = 0;
        for i = 1:n_simulations  
            %Get image stimulus (will be either OnBar or Offbar)
            S = image_stim_handle(n_image_size, theta);
            %Stimulate neuron
            r = neuron_function_handle(S);
            %Store neuron spike rates to create statistics after n
            %simulations
            r_vec(i) = r;            
        end        
        avg_resp = [avg_resp (sum(r_vec)/n_simulations)];
        avg_resp_sq = [avg_resp_sq (sum(r_vec.*r_vec)/n_simulations)];
    end
    avg_resp_std = sqrt(avg_resp_sq - avg_resp.*avg_resp);
    cv = avg_resp_std./avg_resp;   
   
end


