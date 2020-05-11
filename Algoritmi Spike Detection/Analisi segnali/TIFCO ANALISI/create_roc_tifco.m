clc, clear all, close all
%% 
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Distribuzioni\1\ig_matrix1');
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Distribuzioni\1\gamma_matrix1');
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Distribuzioni\1\expo_matrix1');
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Multi-unit\Distribuzione 1\S1\loc_spike_s1.mat');
%%
param1=1;
param2=20;
list_soglia=linspace(param1,param2,30);
%% EXPO
path_to_tifco='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\TIFCO\EXPO\';
list_snr=[1 13 115];
for i=1:length(list_soglia)
    for j=1:length(list_snr)
        load([path_to_tifco 'Parametro ' num2str(list_soglia(i)) '\tifco_' num2str(list_snr(j)) '.mat'])
        [roc] = signal_analysis_single_unit(min_spikepos,expo_matrix);
        save([path_to_tifco 'Parametro ' num2str(list_soglia(i)) '\expo' num2str(list_snr(j)) '_roc.mat'], 'roc');
        clear roc timestamps_found
    end
end

%% GAMMA
path_to_tifco='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\SOGLIA SECCA\'
list_snr=[1 13 115];
for i=1:length(list_soglia)
    for j=1:length(list_snr)
        load([path_to_tifco 'GAMMA\Parametro ' num2str(list_soglia(i)) '\ht_' num2str(list_snr(j)) '.mat'])
        [roc] = signal_analysis_single_unit(timestamps_found,gamma_matrix);
        save([path_to_tifco 'GAMMA\Parametro ' num2str(list_soglia(i)) '\gamma' num2str(list_snr(j)) '_roc.mat'], 'roc');
        clear roc timestamps_found
    end
end
%% IG
path_to_tifco='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\SOGLIA SECCA\'
list_snr=[1 13 115];
for i=1:length(list_soglia)
    for j=1:length(list_snr)
        load([path_to_tifco 'INVGAU\Parametro ' num2str(list_soglia(i)) '\ht_' num2str(list_snr(j)) '.mat'])
        [roc] = signal_analysis_single_unit(timestamps_found,invgau_matrix);
        save([path_to_tifco 'INVGAU\Parametro ' num2str(list_soglia(i)) '\ig' num2str(list_snr(j)) '_roc.mat'], 'roc');
        clear roc timestamps_found
    end
end

%% MULTI UNIT
path_to_tifco='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\TIFCO\'
list_snr=[1 13 115];
for i=1:length(list_soglia)
    for j=1:length(list_snr)
        load([path_to_tifco 'MULTI UNIT\Parametro ' num2str(list_soglia(i)) '\tifco_' num2str(list_snr(j)) '.mat'])
        [roc] = signal_analysis_multi_unit(min_spikepos,loc_spike_s1);
        save([path_to_tifco 'MULTI UNIT\Parametro ' num2str(list_soglia(i)) '\s' num2str(list_snr(j)) '_roc.mat'], 'roc');
        clear roc timestamps_found min_spikepos
    end
end