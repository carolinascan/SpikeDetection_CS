clc, clear all, close all
%% template loading 
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_CS\DATI\VISUAL INSPECTION\Spikes.mat');
%% distributions loading 
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_CS\Creazione Segnali\Distribuzioni\1\expo_matrix1.mat');
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_CS\Creazione Segnali\Distribuzioni\1\gamma_matrix1.mat');
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_CS\Creazione Segnali\Distribuzioni\1\ig_matrix1.mat');
%% template
for i=1:20
template_1=randi(64);
template_2=randi(64);
template_3=randi(64);
T_1=Spikes(template_1).wave;
T_2=Spikes(template_2).wave;
T_3=Spikes(template_3).wave;
%% expo
row_expo_train=randi(100);
spikeT_EXPO=expo_matrix.spikeTrain(row_expo_train,:);
[signal_e,ts_expo,template_expo] = Signal_Generator(spikeT_EXPO,T_1);
%% gamma
row_gamma_train=randi(100);
spikeT_GAMMA=gamma_matrix.spikeTrain(row_gamma_train,:);
[signal_g,ts_gamma,template_gamma] = Signal_Generator(spikeT_GAMMA,T_2);
%% inv_gau
row_ig_train=randi(100);
spikeT_IG=invgau_matrix.spikeTrain(row_ig_train,:);
[signal_ig,ts_ig,template_ig] = Signal_Generator(spikeT_IG,T_3);
%% MU
mu_signal=signal_e+signal_g+signal_ig; 
ts=[ts_expo ts_gamma ts_ig];
timestamps=sort(ts);
%% struct
MU.T_1=template_1;
MU.T_2=template_2;
MU.T_3=template_3;
MU.expo_train=row_expo_train;
MU.ts_expo=ts_expo;
MU.expo_signal=signal_e;
MU.gamma_train=row_gamma_train;
MU.ts_gamma=ts_gamma;
MU.gamma_signal=signal_g;
MU.ig_train=row_ig_train;
MU.ts_ig=ts_ig;
MU.ig_signal=signal_ig;
MU.timestamps=timestamps; 
MU.signal=mu_signal; 
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_CS\New Signals-no noise\MU_ ', num2str(i),'.mat'],'MU');
end 


