clc, clear all, close all
%% NOISE V2
% SNR = db2mag(SNR(signal_no_noise, filtered_noise))
% noise = 1 noise simulation scaled 
% final signal = signal_no_noise + filterd_noise

%% NOISE CREATION
list_param_noise=linspace(0.1,0.5,10);
for i=1:length(list_param_noise);
noise_out=out.SimulationMetadata.signals(2).values;
NOISE=reshape(noise_out,1,[]); % -300/+300  mV, filtered -100/+100 mV
data=(NOISE-mean(NOISE)).*1e6;
% figure, plot(data)
%%Noise scaling 
data=data.*list_param_noise(i);
num_noise=i;
mkdir(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\N' num2str(num_noise) '\N_Mat_files\' num2str(num_noise)]);
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\N' num2str(num_noise) '\N_Mat_files\' num2str(num_noise) '\noise.mat'],'data');
clear data
end 
%%
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Multi-unit\Distribuzione 1\S1\loc_spike_s1.mat');
sig=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Multi-unit\Distribuzione 1\S1\signal1.mat');
spikes_position1=loc_spike_s1.unit1;
spikes_position2=loc_spike_s1.unit2;
spikes_position3=loc_spike_s1.unit3;
timestamps_from_model=sort([spikes_position1 spikes_position2 spikes_position3]);
signal_no_noise=sig.data;
%%
% list_param_noise=linspace(0.03,0.1,10);
for i=1:length(list_param_noise)
noise_filt=load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\N' num2str(i) '\N' num2str(i) '_FilteredData\N' num2str(i) '_Mat_Files\' num2str(i) '\noise.mat']);
SNR=db2mag(snr(signal_no_noise,noise_filt.data(2:end)))
SNR_param(i,:)=[SNR list_param_noise(i)];
end %SNR_n1=0.04

save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat','SNR_param')
