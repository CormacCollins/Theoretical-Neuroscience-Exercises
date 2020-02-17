% --------------------- stimulate_neuron -----------------------------
% Takes params needed to call any type of Spot stim (a function that
% takes no params)
% and any neuron function that returns a spike rate value
% also returns a weighted average value

function [resp_wt_avg_cv]  = ...
    stimulate_neuron_get_weighted_resp_cov(n_image_size, neuron_function_handle, image_stim_handle, n_simulations)
    
    r_vec = zeros(n_simulations, 1); 
    Cnm = zeros(n_image_size*n_image_size, n_image_size*n_image_size);
    
    for i = 1:n_simulations  
        s = image_stim_handle(n_image_size);
        r = neuron_function_handle(s);
        r_vec(i) = r;
        
        %See slides for - 4 Optional assignment for the equations
        %calculated
        
        %Reshape nxn matrix into column vector [nxn, 1]
        Sn = reshape(s, [n_image_size*n_image_size, 1]);
        %Multiple vec by itself to get covariance (Sn*Sn)
        %then multiply it by the response for this iteration
        %update the Cnm
        Cnm_temp = Sn*transpose(Sn);
        Cnm = Cnm + (r*(Cnm_temp));        
    end    
    %Final calc for response weighted average (divide by sum of responses)
    %or as writen in code scalar*matrix
    resp_wt_avg_cv = Cnm./sum(r_vec);
    
end


