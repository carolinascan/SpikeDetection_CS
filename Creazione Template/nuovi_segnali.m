%% ADS1_WAVEDATA5 SINTETICO
clc, clear all, close all
load('ADS1_WaveData5_Output.mat') %ms
fc=24414;
spikes_s=XY_SelectedSpikes(:,1)./1000; %s
voltage=XY_SelectedSpikes(:,2);
spikes_camp=spikes_s.*fc; %samples
% figure
% plot(data(2:end))
% spikes_camp=spikes_camp.*fc;
% voltage=XY_SelectedSpikes(:,2);
[spikes,inspection_length_s,mfr]= gSpikes(data,spikes_camp,voltage, spikes_s);
[allSpikes,class0,class1,class2,class3,class4,class5]=DoClustering(spikes_s,inspection_length_s,spikes);
[isi_cl0_s,isi_cl1_s,isi_cl2_s] = check_isi_distribution(1,class1,1);
figure, histogram(isi_cl1_s,'Normalization','probability')
%% BASAL2_WAVEDATA10 SINTETICO
clc, clear all, close all
load('Basal2_WaveData10_Output.mat') %ms
fc=24414;
spikes_camp=XY_SelectedSpikes(:,1); %samples
voltage=XY_SelectedSpikes(:,2);
spikes_s=spikes_camp./fc; %samples
[spikes,inspection_length_s,mfr]= gSpikes(data,spikes_camp,voltage, spikes_s);
[allSpikes,class0,class1,class2,class3,class4,class5]=DoClustering(spikes_s,inspection_length_s,spikes);
[isi_cl0_s,isi_cl1_s,isi_cl2_s] = check_isi_distribution(1,class1,1);
figure, histogram(isi_cl1_s,'Normalization','probability')
%% QUESTI SONO SOLO GLI INDICI DEGLI SPIKE CHE LEI USA PER FARE IL CANALE 1
clc, clear all, close all
load('ref2_ch1_fiveSec_SpikePoints.mat') %ms
%% 
clc, clear all, close all
load('Ref2_Ch1.mat') %ms
fc=24414;
spikes_camp=XY_SelectedSpikes(:,1); %samples
voltage=XY_SelectedSpikes(:,2);
spikes_s=spikes_camp./fc; %samples
[spikes,inspection_length_s,mfr]= gSpikes(data,spikes_camp,voltage, spikes_s);
[allSpikes,class0,class1,class2,class3,class4,class5]=DoClustering(spikes_s,inspection_length_s,spikes);
[isi_cl0_s,isi_cl1_s,isi_cl2_s] = check_isi_distribution(1,class1,class2);
figure, histogram(isi_cl1_s,'Normalization','probability')
figure, histogram(isi_cl2_s,'Normalization','probability')