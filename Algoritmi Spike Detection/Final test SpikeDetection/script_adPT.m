clc, clear all, close all
%% adPT
fs=24414;
mPW=0.24*1e-3;
data_in=data;
T=2.7*median(abs(rumore.*1e6))./0.6745;
% T=thresh_vector;
%%
[timestamps]= adPT(data_in,mPW,T,fs);
%%
[spikepos_adpt_min]= find_min_peaks(data_in,timestamps);
%%
delta=1/4*1e-3;
[spikespos_dmt]= DMT(data_in,delta,T,fs)
%% ground truth
% s1=loc_spike_s1.unit1;
% s2=loc_spike_s1.unit2;
% s3=loc_spike_s1.unit3;
spike_locations=sort([s1 s2 s3]);
% [spikes_found_matched_from_model,spikes_found_matched_from_adpt,check] =match_spikes(spikepos_adpt_min,spike_locations)
[roc] = HT_signal_analysis_multi_unit(spikepos_adpt_min,loc_spike_s1)
%  NCS=roc.tp;
%     FP=roc.fp;
%     NREF=roc.NREF;
%     [FP_rate,TP_rate] = roc_parameters(NREF,FP,NCS,data)
%%
figure, plot (data), hold on, plot(spikes_found_matched_from_model,data(spikes_found_matched_from_model),'*g');
% , hold on, plot(spikespos_dmt,data(spikespos_dmt),'r*'), title('DMT')
 hold on, plot(spikepos_adpt_min,data(spikepos_adpt_min),'m*'), title('adPT')