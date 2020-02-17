% -------------------- Stimulate neuron response ------------------------
% Params: n = num of columns, stim strength 1 & 2 (s1 & s2)
%           simulations = number of simulations
% Return: resp: avg resp vector for series of stimuli
%         Sin: Stimulus vec (2*n) constructed from strengths s1&s2

function [resp, Sin] = stim_response(s1, s2, n)
    A = repmat( [s1 0]', 1, n ); 
    B = repmat( [0 s2]', 1, n );
    Xin = [A B];
    [srt, idx] = sort( rand(1, n*2));
    Sin = Xin(:,idx(1:n));
    resp = SensResp(Sin);
end