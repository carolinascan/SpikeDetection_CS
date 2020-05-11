clc, clear all, close all
%%
%% Data
snr1=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SEGNALI FILTRATI\MULTI UNIT\SNR1\SNR1_FilteredData\SNR1_Mat_Files\1\signoise1_SNR1.mat')
snr13=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SEGNALI FILTRATI\MULTI UNIT\SNR13\SNR13_FilteredData\SNR13_Mat_Files\13\signoise1_SNR13.mat')
snr115=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SEGNALI FILTRATI\MULTI UNIT\SNR115\SNR115_FilteredData\SNR115_Mat_Files\115\signoise1_SNR115.mat')
%% Locations from model
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Multi-unit\Distribuzione 1\S1\loc_spike_s1.mat')
spikes_position1=loc_spike_s1.unit1;
spikes_position2=loc_spike_s1.unit2;
spikes_position3=loc_spike_s1.unit3;
timestamps_from_model=sort([spikes_position1 spikes_position2 spikes_position3]);
%%
[value,loc]=max(diff(timestamps_from_model))
timestamps_from_model(loc)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HARD THRESHOLD 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SNR 1
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\coordinate roc ht soglia fissa\XY_fix_MU_snr1.mat');
idx_maxeff_ht_snr1=find(eff==max(eff));
best_param_ht_snr1=parametro(idx_maxeff_ht_snr1);
load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\SOGLIA SECCA FISSA\MULTI UNIT\Parametro ', num2str(best_param_ht_snr1,'%1.4f'), '\ht_fix_1.mat'])
[spikes_found_matched_ht_snr1,spikes_found_matched_ht_from_model_snr1,idx_fp_ht_snr1] = match_spikes(timestamps_found,timestamps_from_model); 
fp_ht_snr1=timestamps_found(idx_fp_ht_snr1);
[tp_waveform_ht_snr1,fp_waveform_ht_snr1] = getSpikesWaveform(snr1.data,spikes_found_matched_ht_snr1,fp_ht_snr1');

% find git
git=(spikes_found_matched_ht_from_model_snr1-spikes_found_matched_ht_snr1);
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\GIT\git_ht_snr1.mat','git')
clear git timestamps_found

% data for the bar plot
eff_max_ht_snr1=max(eff);
nTP_ht_snr1=length(spikes_found_matched_ht_snr1);
NFP_ht_snr1=length(idx_fp_ht_snr1);
clear eff
%% SNR 1.3
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\coordinate roc ht soglia fissa\XY_fix_MU_snr13.mat');
idx_maxeff_ht_snr13=find(eff==max(eff));
best_param_ht_snr13=parametro(idx_maxeff_ht_snr13);
load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\SOGLIA SECCA FISSA\MULTI UNIT\Parametro ', num2str(best_param_ht_snr13,'%1.4f'), '\ht_fix_13.mat'])
[spikes_found_matched_ht_snr13,spikes_found_matched_ht_from_model_snr13,idx_fp_ht_snr13] = match_spikes(timestamps_found,timestamps_from_model); 
fp_ht_snr13=timestamps_found(idx_fp_ht_snr13);
[tp_waveform_ht_snr13,fp_waveform_ht_snr13] = getSpikesWaveform(snr13.data,spikes_found_matched_ht_snr13,fp_ht_snr13');

% find git
git=(spikes_found_matched_ht_from_model_snr13-spikes_found_matched_ht_snr13);
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\GIT\git_ht_snr13.mat','git')
clear git timestamps_found 

% data for the bar plot
eff_max_ht_snr13=max(eff);
nTP_ht_snr13=length(spikes_found_matched_ht_snr13);
NFP_ht_snr13=length(idx_fp_ht_snr13);
clear eff

%% SNR 1.15
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\coordinate roc ht soglia fissa\XY_fix_MU_snr115.mat');
idx_maxeff_ht_snr115=find(eff==max(eff));
eff_max_ht_snr115=max(eff);
best_param_ht_snr115=parametro(idx_maxeff_ht_snr115);
load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\SOGLIA SECCA FISSA\MULTI UNIT\Parametro ', num2str(best_param_ht_snr115,'%1.4f'), '\ht_fix_115.mat'])
[spikes_found_matched_ht_snr115,spikes_found_matched_ht_from_model_snr115,idx_fp_ht_snr115] = match_spikes(timestamps_found,timestamps_from_model); 
fp_ht_snr115=timestamps_found(idx_fp_ht_snr115);
[tp_waveform_ht_snr115,fp_waveform_ht_snr115] = getSpikesWaveform(snr115.data,spikes_found_matched_ht_snr115,fp_ht_snr115');
% find git
git=(spikes_found_matched_ht_from_model_snr115-spikes_found_matched_ht_snr115);
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\GIT\git_ht_snr115.mat','git')
clear git timestamps_found 

% data for the bar plot
eff_max_ht_snr115=max(eff);
nTP_ht_snr115=length(spikes_found_matched_ht_snr115);
NFP_ht_snr115=length(idx_fp_ht_snr115);
clear eff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HADT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SNR 1
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HADT ANALISI\SOGLIA SECCA VARIABILE\param_RP_snr\MULTI UNIT\params_RP_snr1.mat')
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HADT ANALISI\max_eff_1.mat')
ts_bestRP_snr1=timestamps_found_all_SNR1(:,y);
spikes_found_hadt_snr1=ts_bestRP_snr1{x,:};
[spikes_found_matched_hadt_snr1,spikes_found_matched_hadt_from_model_snr1,idx_fp_hadt_snr1] = match_spikes(spikes_found_hadt_snr1,timestamps_from_model); 
fp_hadt_snr1=spikes_found_hadt_snr1(idx_fp_hadt_snr1);
[tp_waveform_hadt_snr1,fp_waveform_hadt_snr1] = getSpikesWaveform(snr1.data,spikes_found_matched_hadt_snr1,fp_hadt_snr1');
% find git
git=(spikes_found_matched_hadt_from_model_snr1-spikes_found_matched_hadt_snr1);
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\GIT\git_hadt_snr1.mat','git')
clear git timestamps_found

% data for the bar plot
eff_max_hadt_snr1=MAX;
nTP_hadt_snr1=length(spikes_found_matched_hadt_snr1);
NFP_hadt_snr1=length(idx_fp_hadt_snr1);
clear  MAX

%% SNR 1.3
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HADT ANALISI\SOGLIA SECCA VARIABILE\param_RP_snr\MULTI UNIT\params_RP_snr13.mat')
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HADT ANALISI\max_eff_13.mat')
ts_bestRP_snr13=timestamps_found_all_SNR13(:,y);
spikes_found_hadt_snr13=ts_bestRP_snr13{x,:};
[spikes_found_matched_hadt_snr13,spikes_found_matched_hadt_from_model_snr13,idx_fp_hadt_snr13] = match_spikes(spikes_found_hadt_snr13,timestamps_from_model); 
fp_hadt_snr13=spikes_found_hadt_snr13(idx_fp_hadt_snr13);
[tp_waveform_hadt_snr13,fp_waveform_hadt_snr13] = getSpikesWaveform(snr13.data,spikes_found_matched_hadt_snr13,fp_hadt_snr13');
% find git
git=(spikes_found_matched_hadt_from_model_snr13-spikes_found_matched_hadt_snr13);
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\GIT\git_hadt_snr13.mat','git')
clear git timestamps_found 

% data for the bar plot
eff_max_hadt_snr13=MAX;
nTP_hadt_snr13=length(spikes_found_matched_hadt_snr13);
NFP_hadt_snr13=length(idx_fp_hadt_snr13);
clear eff MAX

%% SNR 1.15
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HADT ANALISI\SOGLIA SECCA VARIABILE\param_RP_snr\MULTI UNIT\params_RP_snr115.mat')
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HADT ANALISI\max_eff_115.mat')
ts_bestRP_snr115=timestamps_found_all_SNR115(:,y);
spikes_found_hadt_snr115=ts_bestRP_snr115{x,:};
[spikes_found_matched_hadt_snr115,spikes_found_matched_hadt_from_model_snr115,idx_fp_hadt_snr115] = match_spikes(spikes_found_hadt_snr115,timestamps_from_model); 
fp_hadt_snr115=spikes_found_hadt_snr115(idx_fp_hadt_snr115);
[tp_waveform_hadt_snr115,fp_waveform_hadt_snr115] = getSpikesWaveform(snr115.data,spikes_found_matched_hadt_snr115,fp_hadt_snr115');
% find git
git=(spikes_found_matched_hadt_from_model_snr115-spikes_found_matched_hadt_snr115);
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\GIT\git_hadt_snr115.mat','git')
clear git timestamps_found 

% data for the bar plot
eff_max_hadt_snr115=MAX;
nTP_hadt_snr115=length(spikes_found_matched_hadt_snr115);
NFP_hadt_snr115=length(idx_fp_hadt_snr115);
clear eff MAX

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PTSD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SNR 1
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\param_PLP_snr1.mat')
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\max_eff_1.mat')
ts_bestPlp_snr1=timestamps_found_all_SNR1(:,y);
ts_bPLP_bestParam_snr1=ts_bestPlp_snr1{x,:};
spikes_found_ptsd_snr1=find(ts_bPLP_bestParam_snr1.peak_train);
NS_ptsd_snr1=length(spikes_found_ptsd_snr1);
[spikes_found_matched_ptsd_snr1,spikes_found_matched_ptsd_from_model_snr1,idx_fp_ptsd_snr1] = match_spikes(spikes_found_ptsd_snr1,timestamps_from_model'); 
fp_ptsd_snr1=spikes_found_ptsd_snr1(idx_fp_ptsd_snr1);
[tp_waveform_ptsd_snr1,fp_waveform_ptsd_snr1] = getSpikesWaveform(snr1.data,spikes_found_matched_ptsd_snr1,fp_ptsd_snr1);
git=(spikes_found_matched_ptsd_from_model_snr1-spikes_found_matched_ptsd_snr1);
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\GIT\git_ptsd_snr1.mat','git')
clear git timestamps_found 

% data for the bar plot
eff_max_ptsd_snr1=MAX;
nTP_ptsd_snr1=length(spikes_found_matched_ptsd_snr1);
NFP_ptsd_snr1=length(idx_fp_ptsd_snr1);
clear eff MAX

%% SNR 1.3
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\param_PLP_snr13.mat');
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\max_eff_13.mat')
ts_bestPlp_snr13=timestamps_found_all_SNR13(:,y);
ts_bPLP_bestParam_snr13=ts_bestPlp_snr13{x,:};
spikes_found_ptsd_snr13=find(ts_bPLP_bestParam_snr13.peak_train);
NS_ptsd_snr13=length(spikes_found_ptsd_snr13);
[spikes_found_matched_ptsd_snr13,spikes_found_matched_ptsd_from_model_snr13,idx_fp_ptsd_snr13] = match_spikes(spikes_found_ptsd_snr13,timestamps_from_model'); 
fp_ptsd_snr13=spikes_found_ptsd_snr13(idx_fp_ptsd_snr13);
[tp_waveform_ptsd_snr13,fp_waveform_ptsd_snr13] = getSpikesWaveform(snr13.data,spikes_found_matched_ptsd_snr13,fp_ptsd_snr13);

git=(spikes_found_matched_ptsd_from_model_snr13-spikes_found_matched_ptsd_snr13);
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\GIT\git_ptsd_snr13.mat','git')
clear git timestamps_found 

% data for the bar plot
eff_max_ptsd_snr13=MAX;
nTP_ptsd_snr13=length(spikes_found_matched_ptsd_snr13);
NFP_ptsd_snr13=length(idx_fp_ptsd_snr13);
clear eff MAX

%% SNR 1.15
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\param_PLP_snr115.mat');
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\max_eff_115.mat')
ts_bestPlp_snr115=timestamps_found_all_SNR115(:,y);
ts_bPLP_bestParam_snr115=ts_bestPlp_snr115{x,:};
spikes_found_ptsd_snr115=find(ts_bPLP_bestParam_snr115.peak_train);
NS_ptsd_snr115=length(spikes_found_ptsd_snr115);
[spikes_found_matched_ptsd_snr115,spikes_found_matched_ptsd_from_model_snr115,idx_fp_ptsd_snr115] = match_spikes(spikes_found_ptsd_snr115,timestamps_from_model'); 
fp_ptsd_snr115=spikes_found_ptsd_snr115(idx_fp_ptsd_snr115);
[tp_waveform_ptsd_snr115,fp_waveform_ptsd_snr115] = getSpikesWaveform(snr115.data,spikes_found_matched_ptsd_snr115,fp_ptsd_snr115);

git=(spikes_found_matched_ptsd_from_model_snr115-spikes_found_matched_ptsd_snr115);
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\GIT\git_ptsd_snr115.mat','git')
clear git timestamps_found 

% data for the bar plot
eff_max_ptsd_snr115=MAX;
nTP_ptsd_snr115=length(spikes_found_matched_ptsd_snr115);
NFP_ptsd_snr115=length(idx_fp_ptsd_snr115);
clear eff MAX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TIFCO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SNR 1
param1=1;
param2=20;
parametro=linspace(param1,param2,30);
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\coordinate roc tifco\XY_MU_snr1.mat');
idx_maxeff_tifco_snr1=find(eff==max(eff));
best_param_tifco_snr1=parametro(idx_maxeff_tifco_snr1);
load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\TIFCO\MULTI UNIT\Parametro ', num2str(best_param_tifco_snr1,'%1.4f'), '\tifco_1.mat'])
[spikes_found_matched_tifco_snr1,spikes_found_matched_tifco_from_model_snr1,idx_fp_tifco_snr1] = match_spikes(min_spikepos,timestamps_from_model); 
fp_tifco_snr1=min_spikepos(idx_fp_tifco_snr1);
[tp_waveform_tifco_snr1,fp_waveform_tifco_snr1] = getSpikesWaveform(snr1.data,spikes_found_matched_tifco_snr1,fp_tifco_snr1');
% find git
git=(spikes_found_matched_tifco_from_model_snr1-spikes_found_matched_tifco_snr1);
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\GIT\git_tifco_snr1.mat','git')
clear git timestamps_found 

% data for the bar plot
eff_max_tifco_snr1=max(eff);
nTP_tifco_snr1=length(spikes_found_matched_tifco_snr1);
NFP_tifco_snr1=length(idx_fp_tifco_snr1);
clear eff

%% SNR 1.3
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\coordinate roc tifco\XY_MU_snr13.mat');
idx_maxeff_tifco_snr13=find(eff==max(eff));
best_param_tifco_snr13=parametro(idx_maxeff_tifco_snr13);
load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\TIFCO\MULTI UNIT\Parametro ', num2str(best_param_tifco_snr13,'%1.4f'), '\tifco_13.mat'])
[spikes_found_matched_tifco_snr13,spikes_found_matched_tifco_from_model_snr13,idx_fp_tifco_snr13] = match_spikes(min_spikepos,timestamps_from_model); 
fp_tifco_snr13=min_spikepos(idx_fp_tifco_snr13);
[tp_waveform_tifco_snr13,fp_waveform_tifco_snr13] = getSpikesWaveform(snr13.data,spikes_found_matched_tifco_snr13,fp_tifco_snr13');
% find git
git=(spikes_found_matched_tifco_from_model_snr13-spikes_found_matched_tifco_snr13);
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\GIT\git_tifco_snr13.mat','git')
clear git timestamps_found 

% data for the bar plot
eff_max_tifco_snr13=max(eff);
nTP_tifco_snr13=length(spikes_found_matched_tifco_snr13);
NFP_tifco_snr13=length(idx_fp_tifco_snr13);
clear eff

%% SNR 1.15
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\coordinate roc tifco\XY_MU_snr115.mat');
idx_maxeff_tifco_snr115=find(eff==max(eff));
best_param_tifco_snr115=parametro(idx_maxeff_tifco_snr115);
load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\TIFCO\MULTI UNIT\Parametro ', num2str(best_param_tifco_snr115,'%1.4f'), '\tifco_115.mat'])
[spikes_found_matched_tifco_snr115,spikes_found_matched_tifco_from_model_snr115,idx_fp_tifco_snr115] = match_spikes(min_spikepos,timestamps_from_model); 
fp_tifco_snr115=min_spikepos(idx_fp_tifco_snr115);
[tp_waveform_tifco_snr115,fp_waveform_tifco_snr115] = getSpikesWaveform(snr115.data,spikes_found_matched_tifco_snr115,fp_tifco_snr115');
% find git
git=(spikes_found_matched_tifco_from_model_snr115-spikes_found_matched_tifco_snr115);
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\GIT\git_tifco_snr115.mat','git')
clear git timestamps_found 

% data for the bar plot
eff_max_tifco_snr115=max(eff);
nTP_tifco_snr115=length(spikes_found_matched_tifco_snr115);
NFP_tifco_snr115=length(idx_fp_tifco_snr115);
clear eff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SWTTEO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SNR 1
param1=110;
param2=10000;
parametro=linspace(param1,param2,20);
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SWTTEO ANALISI\coordinate roc swtteo\XY_MU_snr1.mat');
idx_maxeff_swtteo_snr1=find(eff==max(eff));
best_param_swtteo_snr1=parametro(idx_maxeff_swtteo_snr1);
load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SWTTEO ANALISI\SWTTEO\MULTI UNIT\Parametro ', num2str(best_param_swtteo_snr1,'%1.4f'), '\swtteo_1.mat'])
[spikes_found_matched_swtteo_snr1,spikes_found_matched_swtteo_from_model_snr1,idx_fp_swtteo_snr1] = match_spikes(min_spikepos,timestamps_from_model); 
fp_swtteo_snr1=min_spikepos(idx_fp_swtteo_snr1);
[tp_waveform_swtteo_snr1,fp_waveform_swtteo_snr1] = getSpikesWaveform(snr1.data,spikes_found_matched_swtteo_snr1,fp_swtteo_snr1');
% find git
git=(spikes_found_matched_swtteo_from_model_snr1-spikes_found_matched_swtteo_snr1);
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\GIT\git_swtteo_snr1.mat','git')
clear git timestamps_found 

% data for the bar plot
eff_max_swtteo_snr1=max(eff);
nTP_swtteo_snr1=length(spikes_found_matched_swtteo_snr1);
NFP_swtteo_snr1=length(idx_fp_swtteo_snr1);
clear eff
%% SNR 1.3
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SWTTEO ANALISI\coordinate roc swtteo\XY_MU_snr13.mat');
idx_maxeff_swtteo_snr13=find(eff==max(eff));
best_param_swtteo_snr13=parametro(idx_maxeff_swtteo_snr13);
load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SWTTEO ANALISI\SWTTEO\MULTI UNIT\Parametro ', num2str(best_param_swtteo_snr13,'%1.4f'), '\swtteo_13.mat'])
[spikes_found_matched_swtteo_snr13,spikes_found_matched_swtteo_from_model_snr13,idx_fp_swtteo_snr13] = match_spikes(min_spikepos,timestamps_from_model); 
fp_swtteo_snr13=min_spikepos(idx_fp_swtteo_snr13);
[tp_waveform_swtteo_snr13,fp_waveform_swtteo_snr13] = getSpikesWaveform(snr13.data,spikes_found_matched_swtteo_snr13,fp_swtteo_snr13');
% find git
git=(spikes_found_matched_swtteo_from_model_snr13-spikes_found_matched_swtteo_snr13);
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\GIT\git_swtteo_snr13.mat','git')
clear git timestamps_found 

% data for the bar plot
eff_max_swtteo_snr13=max(eff);
nTP_swtteo_snr13=length(spikes_found_matched_swtteo_snr13);
NFP_swtteo_snr13=length(idx_fp_swtteo_snr13);
clear eff

%% SNR 1.15
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SWTTEO ANALISI\coordinate roc swtteo\XY_MU_snr13.mat');
idx_maxeff_swtteo_snr115=find(eff==max(eff));
best_param_swtteo_snr115=parametro(idx_maxeff_swtteo_snr115);
load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SWTTEO ANALISI\SWTTEO\MULTI UNIT\Parametro ', num2str(best_param_swtteo_snr115,'%1.4f'), '\swtteo_115.mat'])
[spikes_found_matched_swtteo_snr115,spikes_found_matched_swtteo_from_model_snr115,idx_fp_swtteo_snr115] = match_spikes(min_spikepos,timestamps_from_model); 
fp_swtteo_snr115=min_spikepos(idx_fp_swtteo_snr115);
[tp_waveform_swtteo_snr115,fp_waveform_swtteo_snr115] = getSpikesWaveform(snr115.data,spikes_found_matched_swtteo_snr115,fp_swtteo_snr115');
% find git
git=(spikes_found_matched_swtteo_from_model_snr115-spikes_found_matched_swtteo_snr115);
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\GIT\git_swtteo_snr115.mat','git')
clear git timestamps_found 

% data for the bar plot
eff_max_swtteo_snr115=max(eff);
nTP_swtteo_snr115=length(spikes_found_matched_swtteo_snr115);
NFP_swtteo_snr115=length(idx_fp_swtteo_snr115);
clear eff

%% FIGURES
%% WAVEFORMS SNR 1
figure
subplot 521, plot(tp_waveform_ht_snr1'), ylabel('HT'), title(['N° of TP = ' ,num2str(length(spikes_found_matched_ht_snr1))]) 
subplot 522, plot(fp_waveform_ht_snr1(2:end,:)'), title(['N° of FP = ' , num2str(length(idx_fp_ht_snr1))]) 
subplot 523, plot(tp_waveform_hadt_snr1'), ylabel('HADT'), title(['N° of TP = ' ,num2str(length(spikes_found_matched_hadt_snr1))]) 
subplot 524, plot(fp_waveform_hadt_snr1(2:end,:)'), title(['N° of FP = ' , num2str(length(idx_fp_hadt_snr1))]) 
subplot 525, plot(tp_waveform_ptsd_snr1'), ylabel('PTSD'), title(['N° of TP = ' ,num2str(length(spikes_found_matched_ptsd_snr1))]) 
subplot 526, plot(fp_waveform_ptsd_snr1(2:end,:)'), title(['N° of FP = ' , num2str(length(idx_fp_ptsd_snr1))]) 
subplot 527, plot(tp_waveform_tifco_snr1'), ylabel('TIFCO'), title(['N° of TP = ' ,num2str(length(spikes_found_matched_tifco_snr1))]) 
subplot 528, plot(fp_waveform_tifco_snr1(2:end,:)'), title(['N° of FP = ' , num2str(length(idx_fp_tifco_snr1))]) 
subplot 529, plot(tp_waveform_swtteo_snr1'), ylabel('SWTTEO'), title(['N° of TP = ' ,num2str(length(spikes_found_matched_swtteo_snr1))]) 
subplot (5,2,10), plot(fp_waveform_swtteo_snr1(2:end,:)'), title(['N° of FP = ' , num2str(length(idx_fp_swtteo_snr1))]) 
suptitle('NREF = 1407, SNR = 1')

figure
subplot 521, plot(tp_waveform_ht_snr13'), ylabel('HT'), title(['N° of TP = ' ,num2str(length(spikes_found_matched_ht_snr13))]) 
subplot 522, plot(fp_waveform_ht_snr13(2:end,:)'), title(['N° of FP = ' , num2str(length(idx_fp_ht_snr13))]) 
subplot 523, plot(tp_waveform_hadt_snr13'), ylabel('HADT'), title(['N° of TP = ' ,num2str(length(spikes_found_matched_hadt_snr13))]) 
subplot 524, plot(fp_waveform_hadt_snr13(2:end,:)'), title(['N° of FP = ' , num2str(length(idx_fp_hadt_snr13))]) 
subplot 525, plot(tp_waveform_ptsd_snr13'), ylabel('PTSD'), title(['N° of TP = ' ,num2str(length(spikes_found_matched_ptsd_snr13))]) 
subplot 526, plot(fp_waveform_ptsd_snr13(2:end,:)'), title(['N° of FP = ' , num2str(length(idx_fp_ptsd_snr13))]) 
subplot 527, plot(tp_waveform_tifco_snr13'), ylabel('TIFCO'), title(['N° of TP = ' ,num2str(length(spikes_found_matched_tifco_snr13))]) 
subplot 528, plot(fp_waveform_tifco_snr13(2:end,:)'), title(['N° of FP = ' , num2str(length(idx_fp_tifco_snr13))]) 
subplot 529, plot(tp_waveform_swtteo_snr13'), ylabel('SWTTEO'), title(['N° of TP = ' ,num2str(length(spikes_found_matched_swtteo_snr13))]) 
subplot (5,2,10), plot(fp_waveform_swtteo_snr13(2:end,:)'), title(['N° of FP = ' , num2str(length(idx_fp_swtteo_snr13))]) 
suptitle('NREF = 1407, SNR = 1.3')

figure
subplot 521, plot(tp_waveform_ht_snr115'), ylabel('HT'), title(['N° of TP = ' ,num2str(length(spikes_found_matched_ht_snr115))]) 
subplot 522, plot(fp_waveform_ht_snr115(2:end,:)'), title(['N° of FP = ' , num2str(length(idx_fp_ht_snr115))]) 
subplot 523, plot(tp_waveform_hadt_snr115'), ylabel('HADT'), title(['N° of TP = ' ,num2str(length(spikes_found_matched_hadt_snr115))]) 
subplot 524, plot(fp_waveform_hadt_snr115(2:end,:)'), title(['N° of FP = ' , num2str(length(idx_fp_hadt_snr115))]) 
subplot 525, plot(tp_waveform_ptsd_snr115'), ylabel('PTSD'), title(['N° of TP = ' ,num2str(length(spikes_found_matched_ptsd_snr115))]) 
subplot 526, plot(fp_waveform_ptsd_snr115(2:end,:)'), title(['N° of FP = ' , num2str(length(idx_fp_ptsd_snr115))]) 
subplot 527, plot(tp_waveform_tifco_snr115'), ylabel('TIFCO'), title(['N° of TP = ' ,num2str(length(spikes_found_matched_tifco_snr115))]) 
subplot 528, plot(fp_waveform_tifco_snr115(2:end,:)'), title(['N° of FP = ' , num2str(length(idx_fp_tifco_snr115))]) 
subplot 529, plot(tp_waveform_swtteo_snr115'), ylabel('SWTTEO'), title(['N° of TP = ' ,num2str(length(spikes_found_matched_swtteo_snr115))]) 
subplot (5,2,10), plot(fp_waveform_swtteo_snr1(2:end,:)'), title(['N° of FP = ' , num2str(length(idx_fp_swtteo_snr115))]) 
suptitle('NREF = 1407, SNR = 1')
%% TP and FP
list={'HT','HADT','PTSD','TIFCO','SWTTEO'};
algorithms=categorical(list,list);
NTP_snr1=[nTP_ht_snr1 nTP_hadt_snr1 nTP_ptsd_snr1 nTP_tifco_snr1 nTP_swtteo_snr1];
NFP_snr1=[NFP_ht_snr1 NFP_hadt_snr1 NFP_ptsd_snr1 NFP_tifco_snr1 NFP_swtteo_snr1];
NTP_snr13=[nTP_ht_snr13 nTP_hadt_snr13 nTP_ptsd_snr13 nTP_tifco_snr13 nTP_swtteo_snr13];
NFP_snr13=[NFP_ht_snr13 NFP_hadt_snr13 NFP_ptsd_snr13 NFP_tifco_snr13 NFP_swtteo_snr13];
NTP_snr115=[nTP_ht_snr115 nTP_hadt_snr115 nTP_ptsd_snr115 nTP_tifco_snr115 nTP_swtteo_snr115];
NFP_snr115=[NFP_ht_snr115 NFP_hadt_snr115 NFP_ptsd_snr115 NFP_tifco_snr115 NFP_swtteo_snr115];

figure
subplot 321, b1=bar(algorithms,NTP_snr1), xlim=get(gca,'xlim'), hold on, plot(xlim,[1407 1407],'r', 'LineWidth',2) , title('SNR 1, NREF 1407'), ylabel('Number of TP')
subplot 322, b2=bar(algorithms,NFP_snr1), title('SNR 1'), ylabel('Number of false FP')
subplot 323, b3=bar(algorithms,NTP_snr115), xlim=get(gca,'xlim'), hold on, plot(xlim,[1407 1407],'r', 'LineWidth',2) , title('SNR 1.15, NREF 1407'), ylabel('Number of TP')
subplot 324, b4=bar(algorithms,NFP_snr115), title('SNR 1.15'), ylabel('Number of FP')
subplot 325, b5=bar(algorithms,NTP_snr13), xlim=get(gca,'xlim'), hold on, plot(xlim,[1407 1407],'r', 'LineWidth',2) , title('SNR 1.3, NREF 1407'), ylabel('Number of TP')
subplot 326, b6=bar(algorithms,NFP_snr13), title('SNR 1.3'), ylabel('Number of FP')


b1.FaceColor = 'flat';
b1.CData(1,:) = [0 0.4470 0.7410];
b1.CData(2,:) = [0.8500 0.3250 0.0980];
b1.CData(3,:) = [0.9290 0.6940 0.1250];
b1.CData(4,:) = [0.4940 0.1840 0.5560];
b1.CData(5,:) = [0.4660 0.6740 0.1880];

b2.FaceColor = 'flat';
b2.CData(1,:) = [0 0.4470 0.7410];
b2.CData(2,:) = [0.8500 0.3250 0.0980];
b2.CData(3,:) = [0.9290 0.6940 0.1250];
b2.CData(4,:) = [0.4940 0.1840 0.5560];
b2.CData(5,:) = [0.4660 0.6740 0.1880];

b3.FaceColor = 'flat';
b3.CData(1,:) = [0 0.4470 0.7410];
b3.CData(2,:) = [0.8500 0.3250 0.0980];
b3.CData(3,:) = [0.9290 0.6940 0.1250];
b3.CData(4,:) = [0.4940 0.1840 0.5560];
b3.CData(5,:) = [0.4660 0.6740 0.1880];

b4.FaceColor = 'flat';
b4.CData(1,:) = [0 0.4470 0.7410];
b4.CData(2,:) = [0.8500 0.3250 0.0980];
b4.CData(3,:) = [0.9290 0.6940 0.1250];
b4.CData(4,:) = [0.4940 0.1840 0.5560];
b4.CData(5,:) = [0.4660 0.6740 0.1880];

b5.FaceColor = 'flat';
b5.CData(1,:) = [0 0.4470 0.7410];
b5.CData(2,:) = [0.8500 0.3250 0.0980];
b5.CData(3,:) = [0.9290 0.6940 0.1250];
b5.CData(4,:) = [0.4940 0.1840 0.5560];
b5.CData(5,:) = [0.4660 0.6740 0.1880];

b6.FaceColor = 'flat';
b6.CData(1,:) = [0 0.4470 0.7410];
b6.CData(2,:) = [0.8500 0.3250 0.0980];
b6.CData(3,:) = [0.9290 0.6940 0.1250];
b6.CData(4,:) = [0.4940 0.1840 0.5560];
b6.CData(5,:) = [0.4660 0.6740 0.1880];

%% Efficiency
EFF_snr1=[eff_max_ht_snr1 eff_max_hadt_snr1 eff_max_ptsd_snr1 eff_max_tifco_snr1 eff_max_swtteo_snr1];
EFF_snr13=[eff_max_ht_snr13 eff_max_hadt_snr13 eff_max_ptsd_snr13 eff_max_tifco_snr13 eff_max_swtteo_snr13];
EFF_snr115=[eff_max_ht_snr115 eff_max_hadt_snr115 eff_max_ptsd_snr115 eff_max_tifco_snr115 eff_max_swtteo_snr115];

figure
subplot 311, b7=bar(algorithms,EFF_snr1), title('SNR 1'), ylabel('efficiency'),  ylim([0 100])
subplot 312, b8=bar(algorithms,EFF_snr115), title('SNR 1.15'), ylabel('efficiency'), ylim([0 100])
subplot 313, b9=bar(algorithms,EFF_snr13), title('SNR 1.3'), ylabel('efficiency'), ylim([0 100])
suptitle('Max Efficiency')
 
b7.FaceColor = 'flat';
b7.CData(1,:) = [0 0.4470 0.7410];
b7.CData(2,:) = [0.8500 0.3250 0.0980];
b7.CData(3,:) = [0.9290 0.6940 0.1250];
b7.CData(4,:) = [0.4940 0.1840 0.5560];
b7.CData(5,:) = [0.4660 0.6740 0.1880];

b8.FaceColor = 'flat';
b8.CData(1,:) = [0 0.4470 0.7410];
b8.CData(2,:) = [0.8500 0.3250 0.0980];
b8.CData(3,:) = [0.9290 0.6940 0.1250];
b8.CData(4,:) = [0.4940 0.1840 0.5560];
b8.CData(5,:) = [0.4660 0.6740 0.1880];

b8.FaceColor = 'flat';
b8.CData(1,:) = [0 0.4470 0.7410];
b8.CData(2,:) = [0.8500 0.3250 0.0980];
b8.CData(3,:) = [0.9290 0.6940 0.1250];
b8.CData(4,:) = [0.4940 0.1840 0.5560];
b8.CData(5,:) = [0.4660 0.6740 0.1880];

b9.FaceColor = 'flat';
b9.CData(1,:) = [0 0.4470 0.7410];
b9.CData(2,:) = [0.8500 0.3250 0.0980];
b9.CData(3,:) = [0.9290 0.6940 0.1250];
b9.CData(4,:) = [0.4940 0.1840 0.5560];
b9.CData(5,:) = [0.4660 0.6740 0.1880];



























