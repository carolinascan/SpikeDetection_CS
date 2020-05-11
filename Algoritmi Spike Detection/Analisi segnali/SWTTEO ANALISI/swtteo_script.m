clc, clear all, close all

%% SWTTEO
fs=24414;
in.SaRa=fs;
params.method='auto'; % 'energy','lambda','numspikes'
param1=110;
param2=1e4;   
parameter=linspace(param1,param2,20);
list_snr=[1 13 115];
%%
%% EXPO
% gli do i filtrati perchè dovrebbe farlo lui 
path_to_expo='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SEGNALI FILTRATI\EXPO\';
path_to_swtteo='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SWTTEO ANALISI\SWTTEO\';
list_snr=[1 13 115];
for i=1:length(list_snr)
    for j=1:length(parameter) 
    load([path_to_expo 'SNR' num2str(list_snr(i)) '\SNR' num2str(list_snr(i)) '_FilteredData\SNR' num2str(list_snr(i)) '_Mat_Files\' num2str(list_snr(i)) '\expo_SNR' num2str(list_snr(i)) '.mat']); 
        in.M=data;
        params.global_fac = parameter(j);    
        [timestamps_found] = SWTTEO_adapted(in,params);
        [min_spikepos]= find_min_peaks(data,timestamps_found);
        name=[path_to_swtteo 'EXPO\Parametro ' num2str(parameter(j))];
        mkdir (name)
        save([path_to_swtteo 'EXPO\Parametro ' num2str(parameter(j)) '\swtteo_' num2str(list_snr(i)) '.mat'],'min_spikepos','parameter')
        clear timestamps_found min_spikepos
    end
end
%%
%% MU 
% gli do i filtrati 
path_to_mu='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SEGNALI FILTRATI\MULTI UNIT\';
path_to_swtteo='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SWTTEO ANALISI\SWTTEO\';
for i=1:length(list_snr)
    load([path_to_mu 'SNR' num2str(list_snr(i)) '\SNR' num2str(list_snr(i)) '_FilteredData\SNR' num2str(list_snr(i)) '_Mat_Files\' num2str(list_snr(i)) '\signoise1_SNR' num2str(list_snr(i)) '.mat']); 
    for j=1:length(parameter) 
        in.M=data;
        params.global_fac = parameter(j);    
        [timestamps_found] = SWTTEO_adapted(in,params);
        [min_spikepos]= find_min_peaks(data,timestamps_found);
        name=[path_to_swtteo 'MULTI UNIT\Parametro ' num2str(parameter(j))];
        mkdir (name)
%         save([path_to_swtteo 'MULTI UNIT\Parametro ' num2str(parameter(j)) '\swtteo_' num2str(list_snr(i)) '.mat'],'min_spikepos','parameter')
        clear timestamps_found min_spikepos
    end
end 
%% GAMMA 
%non gli do i filtrati perchè dovrebbe farlo lui 
path_to_swtteo='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\TIFCO\';
list_snr=[1 13 115];
parameter=linspace(0.15,1,10);
for i=1:length(list_snr)
    for j=1:length(parameter) 
        load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SINGLE UNIT DA ANALIZZARE\Gamma\gamma_SNR' num2str(list_snr(i)) '.mat']);
        in.M=data;
        params.global_fac = parameter(j);    
        [timestamps_found] = TIFCO_adapted(in,params);
        [min_spikepos]= find_min_peaks(data,timestamps_found);
        name=[path_to_swtteo 'GAMMA\Parametro ' num2str(parameter(j))];
        mkdir (name)
        save([path_to_swtteo 'GAMMA\Parametro ' num2str(parameter(j)) '\tifco_' num2str(list_snr(i)) '.mat'],'min_spikepos','parameter')
        clear timestamps_found min_spikepos
    end
end 

%% INVGAU 
%non gli do i filtrati perchè dovrebbe farlo lui 
path_to_swtteo='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\TIFCO\';
list_snr=[1 13 115];
parameter=linspace(0.15,1,10);
for i=1:length(list_snr)
    for j=1:length(parameter) 
        load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SINGLE UNIT DA ANALIZZARE\InvGau\ig_SNR' num2str(list_snr(i)) '.mat']);
        in.M=data;
        params.global_fac = parameter(j);    
        [timestamps_found] = TIFCO_adapted(in,params);
        [min_spikepos]= find_min_peaks(data,timestamps_found);
        name=[path_to_swtteo 'INVGAU\Parametro ' num2str(parameter(j))];
        mkdir (name)
        save([path_to_swtteo 'INVGAU\Parametro ' num2str(parameter(j)) '\tifco_' num2str(list_snr(i)) '.mat'],'min_spikepos','parameter')
        clear timestamps_found min_spikepos
    end
end 
