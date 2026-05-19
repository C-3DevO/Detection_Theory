%% Lab 7
clear;clc;close all

Ntrial = 1e6; %% INCREASE this to have better results (forexample try 1e5 or 1e6)
Nsample = 50; %% INCREASE this to have better results (forexample try 50)
M = 2;
SNR_dB = -15:1:20;
Pfa = [1e-1,1e-2,1e-3,1e-4,1e-5];
sigma2 = 1;

figure
grid on
hold on
xlabel('Signal-to-noise ratio (dB)', FontWeight='bold');
ylabel('Probability of detection P_d', FontWeight='bold');
title('Probability of Detection vs SNR for Different P_{FA} :: N=50', FontWeight='bold')

ylim([0 1]);
legend_labels = cell(length(Pfa),1);


%%Defining the channel Matrix H
H = randn(Nsample,M);

for j=1:length(Pfa)
    legend_labels{j} = sprintf('P_{FA} = %g',Pfa(j));
    for i=1:length(SNR_dB)
        SNR = 10.^(SNR_dB(i)/10);
        sigma_s2 = SNR * sigma2;

        %%Signal Covariance
        Cs = sigma_s2*(H*H');
        
        a = chi2inv(1-Pfa(j),Nsample);
        Pd(i,j) = 0;

        for itrial = 1:Ntrial
            %% signal generation           
            d = sqrt(sigma_s2)*randn(M,1);
            s =H*d;
            w=sqrt(1)*randn(Nsample,1);
            x = s + w;
            
            %% detection            
            %determining the threshold gamma''
            threshold_pp = a;
                
            % calculate Tx
            Tx = x' * Cs / (Cs + sigma2*eye(Nsample)) * x;
                if Tx > threshold_pp
                Pd(i,j) = Pd(i,j)+1/Ntrial;
                end
        end
    end
    plot(SNR_dB,Pd(:,j))
end
legend(legend_labels,'Location','southeast')

    
    