clc, clear all, close all
%% Locations from model
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Multi-unit\Distribuzione 1\S1\loc_spike_s1.mat')
spikes_position1=loc_spike_s1.unit1;
spikes_position2=loc_spike_s1.unit2;
spikes_position3=loc_spike_s1.unit3;
timestamps_from_model=sort([spikes_position1 spikes_position2 spikes_position3]);
%% 
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
list_snr=SNR_param(:,1);
%% HT (snr x param) 
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\HT\MULTI UNIT V2\timestamps_all_andtime.mat');
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\HT\MULTI UNIT V2\TP_FP_EFF.mat')
[x_tp,y_tp]=find(TP_all==max(TP_all),1)
for i=1:10
    [x_tp(i,1),y_tp(i,1)]=find(TP_all==max(TP_all(i,:)));
    [x_fp(i,1),y_fp(i,1)]=find(FP_all==max(FP_all(i,:)));
    [x_eff(i,1),y_eff(i,1)]=find(EFF==max(EFF(i,:)));
end 
%%
best_eff_ht=parameter(y_eff);
path_to_signal='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\SIGNAL V2\'
%%
tp_waveform_ht=cell(10,1);
fp_waveform_ht=cell(10,1);
for j=1:10
    TS(j,:)=timestamps_found_all{x_eff(j),best_eff_ht(j)}
    [spikes_found_matched_ht,spikes_found_matched_ht_from_model,idx_fp_ht] = match_spikes(TS(j,:),timestamps_from_model); 
    fp_ht=TS(j,idx_fp_ht);
    load([path_to_signal 'snr_' num2str(list_snr(j)) '.mat']);
    [tp_waveform_ht{j,:},fp_waveform_ht{j,:}] = getSpikesWaveform(signal,spikes_found_matched_ht,fp_ht');
    git{j,:}=(spikes_found_matched_ht_from_model-spikes_found_matched_ht);
    clear TS
end 
%%
list_snr=SNR_param(:,1); 
%%
for i=1:10
p=git{i,1};
figure(1)
subplot(2,5,i),histogram(p), title(['SNR ' num2str(list_snr(i),'%1.2f')]), xlabel('git in samples'), ylabel('Number of timestamps'),
% suptitle('HT')
end 
%%
idx=[1 4 6 10];
for p=1:length(idx)
    figure(1)
    subplot (4,1,p), plot(tp_waveform_ht{idx(p)}')
    title(['N° of TP = ' ,num2str(length(tp_waveform_ht{idx(p)}))]) 
    figure (2)
    app=fp_waveform_ht{idx(p)}';
    subplot (4,1,p), plot(app(:,2:end))
    title(['N° of TP = ' ,num2str(size(fp_waveform_ht{idx(p)}),1)]) 
end 
%%
tp_waveform_htlm=cell(10,1);
fp_waveform_htlm=cell(10,1);
for j=1:10
    TS(j,:)=timestamps_found_all{x_eff(j),best_eff_ht(j)}
    [spikes_found_matched_ht,spikes_found_matched_ht_from_model,idx_fp_ht] = match_spikes(TS(j,:),timestamps_from_model); 
    fp_htlm=TS(j,idx_fp_ht);
    load([path_to_signal 'snr_' num2str(list_snr(j)) '.mat']);
    [tp_waveform_ht{j,:},fp_waveform_ht{j,:}] = getSpikesWaveform(signal,spikes_found_matched_ht,fp_ht');
    git{j,:}=(spikes_found_matched_ht_from_model-spikes_found_matched_ht);
    clear TS
end 