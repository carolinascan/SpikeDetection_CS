clc, clear all, close all
%% TIFCO
fs=24414;
in.SaRa=fs;
% params.filter=[]; %out_=modulo del segnale
params.method='auto';
param1=1;
param2=20;
parameter=linspace(param1,param2,30);
%% EXPO
% gli do i filtrati perchè dovrebbe farlo lui 
path_to_expo='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SEGNALI FILTRATI\EXPO\';
path_to_tifco='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\TIFCO\';
list_snr=[1 13 115];
for i=1:length(list_snr)j
    for j=1:length(parameter) 
    load([path_to_expo 'SNR' num2str(list_snr(i)) '\SNR' num2str(list_snr(i)) '_FilteredData\SNR' num2str(list_snr(i)) '_Mat_Files\' num2str(list_snr(i)) '\expo_SNR' num2str(list_snr(i)) '.mat']); 
        in.M=data;
        params.global_fac = parameter(j);    
        [timestamps_found] = TIFCO_adapted(in,params);
        [min_spikepos]= find_min_peaks(data,timestamps_found);
        name=[path_to_tifco 'EXPO\Parametro ' num2str(parameter(j))];
        mkdir (name)
        save([path_to_tifco 'EXPO\Parametro ' num2str(parameter(j)) '\tifco_' num2str(list_snr(i)) '.mat'],'min_spikepos','parameter')
        clear timestamps_found min_spikepos
    end
end
%%
%% MU 
% gli do i filtrati 
path_to_mu='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SEGNALI FILTRATI\MULTI UNIT\';
path_to_tifco='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\TIFCO\';
list_snr=[1 13 115];
for i=1:length(list_snr)
    load([path_to_mu 'SNR' num2str(list_snr(i)) '\SNR' num2str(list_snr(i)) '_FilteredData\SNR' num2str(list_snr(i)) '_Mat_Files\' num2str(list_snr(i)) '\signoise1_SNR' num2str(list_snr(i)) '.mat']); 
    for j=1:length(parameter) 
        in.M=data;
        params.global_fac = parameter(j);    
        [timestamps_found] = TIFCO_adapted(in,params);
        [min_spikepos]= find_min_peaks(data,timestamps_found);
        name=[path_to_tifco 'MULTI UNIT\Parametro ' num2str(parameter(j))];
        mkdir (name)
        save([path_to_tifco 'MULTI UNIT\Parametro ' num2str(parameter(j)) '\tifco_' num2str(list_snr(i)) '.mat'],'min_spikepos','parameter')
        clear timestamps_found min_spikepos
    end
end 
%% GAMMA 
%non gli do i filtrati perchè dovrebbe farlo lui 
path_to_tifco='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\TIFCO\';
list_snr=[1 13 115];
parameter=linspace(0.15,1,10);
for i=1:length(list_snr)
    for j=1:length(parameter) 
        load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SINGLE UNIT DA ANALIZZARE\Gamma\gamma_SNR' num2str(list_snr(i)) '.mat']);
        in.M=data;
        params.global_fac = parameter(j);    
        [timestamps_found] = TIFCO_adapted(in,params);
        [min_spikepos]= find_min_peaks(data,timestamps_found);
        name=[path_to_tifco 'GAMMA\Parametro ' num2str(parameter(j))];
        mkdir (name)
        save([path_to_tifco 'GAMMA\Parametro ' num2str(parameter(j)) '\tifco_' num2str(list_snr(i)) '.mat'],'min_spikepos','parameter')
        clear timestamps_found min_spikepos
    end
end 

%% INVGAU 
%non gli do i filtrati perchè dovrebbe farlo lui 
path_to_tifco='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\TIFCO\';
list_snr=[1 13 115];
parameter=linspace(0.15,1,10);
for i=1:length(list_snr)
    for j=1:length(parameter) 
        load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SINGLE UNIT DA ANALIZZARE\InvGau\ig_SNR' num2str(list_snr(i)) '.mat']);
        in.M=data;
        params.global_fac = parameter(j);    
        [timestamps_found] = TIFCO_adapted(in,params);
        [min_spikepos]= find_min_peaks(data,timestamps_found);
        name=[path_to_tifco 'INVGAU\Parametro ' num2str(parameter(j))];
        mkdir (name)
        save([path_to_tifco 'INVGAU\Parametro ' num2str(parameter(j)) '\tifco_' num2str(list_snr(i)) '.mat'],'min_spikepos','parameter')
        clear timestamps_found min_spikepos
    end
end 
%%
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\MULTIUNIT+NOISE\SNR 1\Distribuzioni 1\1\signoise1_SNR1.mat')
in.M=data;
params.global_fac =0.;
[timestamps_found] = TIFCO_adapted(in,params);
[min_spikepos]= find_min_peaks(data,timestamps_found);
%%
        [roc] = signal_analysis_multi_unit(min_spikepos,loc_spikes);

%%
figure, plot(data), hold on, plot(min_spikepos,data(min_spikepos),'r*')