function Examples

clear all;
close all;


%% examples of using the function SensResp

% 10 stimuli A of strength s=4

'10 times A with s=4'
    
    Sin = repmat( [4 0]', 1, 10 )
    
    Xout = SensResp( Sin )
    
    Xmean = mean(Xout)  % mean of response
    
    Xsted = std(Xout)   % standard deviation
    
    
    
% 10 stimuli B with strength s=6

'10 times B with s=6'
    
    Sin = repmat( [0 6]', 1, 10 )
    
    Xout = SensResp( Sin )
    
    Xmean = mean(Xout)  % mean of response
    
    Xsted = std(Xout)   % standard deviation

    
    
    
% 10 stimuli A and 10 stimuli B, randomly intermixed, both with s=7


'20 stimuli, half A and half B, intermixed, with s=7'
    
    Xin = [repmat( [7 0]', 1, 10 ) repmat( [0 7]', 1, 210 )];
    
    [srt, idx] = sort( rand(1,20) );
    
    Sin = Xin(:,idx)
    
    Xout = SensResp( Sin )
    
    Xmean = mean(Xout)  % mean of response
    
    Xsted = std(Xout)   % standard deviation
    
    
