clc, clear all, close all
%% final signal = signal_no_noise + filterd_noise
sig=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Multi-unit\Distribuzione 1\S1\signal1.mat');
signal_no_noise=sig.data;
%% Noise loading 
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
for i=1:length(SNR_param)
noise_filt=load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\N' num2str(i) '\N' num2str(i) '_FilteredData\N' num2str(i) '_Mat_Files\' num2str(i) '\noise.mat']);
signal=signal_no_noise+noise_filt.data(2:end);
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\SIGNAL V2\snr_' num2str(SNR_param(i,1)) '.mat'], 'signal');
clear noise_filt signal 
end 
%%
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Multi-unit\Distribuzione 1\S1\loc_spike_s1.mat');
spikes_position1=loc_spike_s1.unit1;
spikes_position2=loc_spike_s1.unit2;
spikes_position3=loc_spike_s1.unit3;
timestamps_from_model=sort([spikes_position1 spikes_position2 spikes_position3]);
