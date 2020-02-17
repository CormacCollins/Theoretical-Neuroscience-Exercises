%% Joint probability and conditional likelihood
sin=5:20; %Sensory inputs
xout=0:30;%sensory responses
[PN_XandS, EXN_S]=RespPDF(sin, xout);

%Joint probability for neurons 1 through 4
jointN1=squeeze(PN_XandS(1,:,:));
jointN2=squeeze(PN_XandS(2,:,:));
jointN3=squeeze(PN_XandS(3,:,:));
jointN4=squeeze(PN_XandS(4,:,:));

%Marginal probability for neurons 1 through 4
marginalN1=sum(jointN1,2);
marginalN2=sum(jointN2,2);
marginalN3=sum(jointN3,2);
marginalN4=sum(jointN4,2);

%Conditional probability for neurons 1 to 4
conditionalN1=jointN1./(repmat(marginalN1,1,16)); %repeat the value of the marginal probability of the neuron for every value of the joint probability for that neuron
conditionalN2=jointN2./(repmat(marginalN2,1,16));
conditionalN3=jointN3./(repmat(marginalN3,1,16));
conditionalN4=jointN4./(repmat(marginalN4,1,16));

%The conditional probability is converted to a 3 dimensional matrix, and
%this is used to plot the graph
P_cl(1,:,:)= conditionalN1;
P_cl(2,:,:)= conditionalN2;
P_cl(3,:,:)= conditionalN3;
P_cl(4,:,:)= conditionalN4; 

ShowRespPDF(sin,xout,P_cl,EXN_S) 

%% Stimulus likelihood
response_A = [11;8;3;1];
response_B = [1;4;10;4];
response_C = [2;0;5;8];

ProbA=zeros(4,16); %Crerate matrix of zeros with dimensions 4x16
ProbB=zeros(4,16);
ProbC=zeros(4,16);

for n=1:4
    ProbA(n,:)=squeeze(P_cl(n, xout == response_A(n),:));
    ProbB(n,:)=squeeze(P_cl(n, xout == response_B(n),:));
    ProbC(n,:)=squeeze(P_cl(n, xout == response_C(n),:));
end   

log_ProbA = log(ProbA(1,:)) + log(ProbA(2,:)) + log(ProbA(3,:)) +log(ProbA(4,:));
log_ProbB = log(ProbB(1,:)) + log(ProbB(2,:)) + log(ProbB(3,:)) +log(ProbB(4,:));
log_ProbC = log(ProbC(1,:)) + log(ProbC(2,:)) + log(ProbC(3,:)) +log(ProbC(4,:));

figure;
plot(sin,log_ProbA)
hold all
plot(sin,log_ProbB)
plot(sin,log_ProbC)
legend('log-likelihood for response ra','log-likelihood for response rb','log-likelihood for response rc','Location','southwest')
xlabel('stimulus s')
ylabel('log P(s|r)')

%% Stimulus decoding 

for l = [1:length(sin)];
    S(l,:) = repmat(sin(l),1,100); %S with all stimuli copied into 100 columns
    
    for k = [1:100]
        r(:,k,l) = SensResp4(S(l,k)); %generates new response for every single of the 100 columns of S
          
       for n = [1:4]
        P_cl1(n,k,l) = squeeze(PN_XandS(n,find(xout==r(n,k,l)),l));
       end
       
       log_cl(k,l) = log(P_cl1(1,k,l))+log(P_cl1(2,k,l))+log(P_cl1(3,k,l))+log(P_cl1(4,k,l)); % log conditional likelihood (r fixed) 
       
    end
    
[max_value, index] = max(log_cl,[],2); % find SML, index= index of the maximum values, over the ks (so Dimension is 2)

SML = sin(index); 

SML_AVG(l) = sum(SML)./100;             % Average over all 100 ks
SML_STD(l) = sqrt((sum(SML.^2)./100)-(sum(SML)./100).^2); % Standard deviation 

               
end

figure; 

plot(sin,SML_AVG)
xlabel('true stimulus')
ylabel('average S_{ML}')

figure;

plot(sin,SML_STD)
xlabel('true stimulus')
ylabel('S_{ML} standard deviation') 

