clc, clear all, close all
%% IG MATRIX 
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\SINGLE UNIT\Distribuzioni 1\IG1_R1319_cl1.mat')
SU_noNoise=struct_IG1_R1319.signal(87,:);
% Line 87: MFR 6.6 N° spikes 395 
%% EASY SU
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\SINGLE UNIT\Distribuzioni 1\IG1_ch6_cl0.mat')
SU_noNoise=struct_IG1_ch6.signal(87,:);

%%
%% Noise loading + signal creation 
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
for i=1:length(SNR_param)
noise_filt=load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\N' num2str(i) '\N' num2str(i) '_FilteredData\N' num2str(i) '_Mat_Files\' num2str(i) '\noise.mat']);
signal=SU_noNoise+noise_filt.data(2:end);
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\SINGLE UNIT V2\easy\snr_' num2str(SNR_param(i,1)) '.mat'], 'signal');
clear noise_filt signal 
end 
%%