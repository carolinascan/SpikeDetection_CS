clc, clear all, close all
%%
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\param_PLP_snr13.mat');
%%
%% Locations from model
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Multi-unit\Distribuzione 1\S1\loc_spike_s1.mat')
spikes_position1=loc_spike_s1.unit1;
spikes_position2=loc_spike_s1.unit2;
spikes_position3=loc_spike_s1.unit3;
timestamps_from_model=sort([spikes_position1 spikes_position2 spikes_position3]);

%%
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\max_eff_13.mat')
sig=timestamps_found_all_SNR13{x,y};
spikes_found_from_alg=find(sig.peak_train);
[spikes_found_matched_from_alg,spikes_found_matched_from_model,fp] =match_spikes(spikes_found_from_alg,timestamps_from_model)
%%
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SEGNALI FILTRATI\MULTI UNIT\SNR1\SNR1_FilteredData\SNR1_Mat_Files\1\signoise1_SNR1.mat')

idx_fn=find(~ismember(timestamps_from_model',spikes_found_matched_from_model));

fn=timestamps_from_model(idx_fn);
%% 
[fn_waveform,fn_waveform] = getSpikesWaveform(data,fn,fn)
figure, plot(fn_waveform')
m=min(min(fn_waveform))