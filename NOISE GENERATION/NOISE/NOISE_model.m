% Add noise
noise_out=out.ScopeData.signals(2).values;
NOISE=reshape(noise_out,1,[]); %.*1e6 
data=(NOISE-mean(NOISE)).*1e6;
figure, plot(data)
%%
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SEGNALI FILTRATI\RUMORE\SNR08\s_Mat_files\08\rumore.mat','data');
%%
% save('noise5_snr115.mat','rumore');
%%
clc, clear all
%%
% rumore=rumore.*1e6;
% thresh_vector=std(rumore)*4.5;
% % figure, plot(t,segnale,'r'), hold on, plot(t,rumore(2:end),'k')
% % data=segnale_microvolt+rumore(2:end);
% % figure, plot(t,signal_noise), xlabel('Time[s]'), ylabel('Voltage[V]'), title('signal model with noise')
% % save('signoise1_SNR1.mat','data')
% save('single13_thresh_vectorfile.mat','thresh_vector')
%%
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Multi-unit\Distribuzione 1\S1\signal1.mat');
no_noise=data;
clear data
%% SNR paper
[spikes2,maximum,minimum]= width_peaks(no_noise,timestamps_from_model);
% figure, plot(segnale),hold on, plot(dove_sort_samples,maximum,'r*'), plot(dove_sort_samples,minimum,'*g')
amplitude=abs(maximum-minimum);
SNR_paper=sqrt(mean(amplitude)/(6*std(data)))
%% Noise std check 
% load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Rumore\noise1_snr115.mat')
% %%
% load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Rumore\noise1_snr1.mat')
% %%
% load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Rumore\noise1_snr13.mat')
%% 
% fc=24414;
% noise=rumore.*1e6;
% w_time=1; %ms
% w_samples=1*fc; %samples
% windows=length(noise)/w_samples;
% for i=1:windows
%     signal_windowed_noise(i,:)=noise((i-1)*w_samples+1:i*w_samples);
%     signal_windowed(i,:)=data((i-1)*w_samples+1:i*w_samples);
%     dev_noise(i,1)=std(signal_windowed_noise(i,:));
%     dev(i,1)=std(signal_windowed(i,:));
% end 
% figure, plot(dev_noise), title('Standard Deviation') , xlabel('signal windows [1s]'), ylabel('[microV]')
% hold on, plot(dev,'r'), legend('noise','signal')
%% 
data=rumore(2:end).*1e6+no_noise;
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\NOISE\nuovi snr\SNR0.85\s_Mat_files\0.85\signoise1_SNR085.mat','data');

%% RICALCOLO SNR
% sig=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SEGNALI FILTRATI\MULTI UNIT\SNR1\SNR1_FilteredData\SNR1_Mat_Files\1\signoise1_SNR1.mat');
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Multi-unit\Distribuzione 1\S1\loc_spike_s1.mat');
spikes_position1=loc_spike_s1.unit1;
spikes_position2=loc_spike_s1.unit2;
spikes_position3=loc_spike_s1.unit3;
timestamps_from_model=sort([spikes_position1 spikes_position2 spikes_position3]);
%%
[value,loc]=max(diff(timestamps_from_model))
start=timestamps_from_model(loc)
figure, plot(data), xlim([start start+24000]), hold on, plot(timestamps_from_model,data(timestamps_from_model),'*r')
[x,y]=ginput(2)
%%
param=std(data(x(1):x(2)))
%%
[spikes2,maximum,minimum]= width_peaks(data,timestamps_from_model);
amplitude=abs(maximum-minimum);
SNR_paper=sqrt(mean(amplitude)/(6*param))


