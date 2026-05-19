%% Lab 7
clear;clc;close all

Ntrial = 1e5; %% INCREASE this to have better results (forexample try 1e5 or 1e6)
Nsample = 50; %% INCREASE this to have better results (forexample try 50)
SNR_dB = -20:1:10;
Pfa = [1e-1,1e-2,1e-3,1e-4,1e-5];
figure
grid on
hold on
xlabel('Signal-to-noise ratio (dB)', FontWeight='bold');
ylabel('Probability of detection P_d', FontWeight='bold');
title('Probability of Detection vs SNR for Different P_{FA} :: N=50', FontWeight='bold')

ylim([0 1]);
legend_labels = cell(length(Pfa),1);

for j=1:length(Pfa)
    legend_labels{j} = sprintf('P_{FA} = %g',Pfa(j));
    for i=1:length(SNR_dB)
        SNR = 10.^(SNR_dB(i)/10);
        a = chi2inv(1-Pfa(j),Nsample);
        Pd(i,j) = 0;
        for itrial = 1:Ntrial
            %% signal generation            SNR = sigma_s^2/sigma^2
            s =sqrt(SNR)*randn(Nsample,1);
            w=sqrt(1)*randn(Nsample,1);
            x = s+w;
            
            %% detection            
            %determining the threshold gamma''
            threshold_pp = a;
                
            % calculate Tx
            Tx = sum(x.^2);
                if Tx > threshold_pp
                Pd(i,j) = Pd(i,j)+1/Ntrial;
                end
        end
    end
    plot(SNR_dB,Pd(:,j))
end
legend(legend_labels,'Location','southeast')
