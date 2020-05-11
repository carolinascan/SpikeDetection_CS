% clc, clear all, close all
%%
% PLP=2;  %ms default
RP=1; %ms
DMdpolar=1;
fs=24414;
w_pre=12;
w_post=16;
%%
<<<<<<< HEAD
param1=2;
param2=8;
=======
param1=4;
param2=9;
>>>>>>> 128f3fc441808cc5c880652150d41040436a2ca5
plp1=0.5;
plp2=2.5;
parameter=linspace(param1,param2,50);
list_PLP=linspace(plp1,plp2,5);
list_snr=[1 13 115];
%%
%% Change the current folder to the folder of this m-file.
if(~isdeployed)
    cd(fileparts(which(mfilename)));
end
cd ..
cd ..
%% run ptsd_for_runnin_parameters for all parameters MU 
timestamps_found_all=cell(length(parameter),length(list_PLP),length(list_snr));
% path_to_multiunit='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SEGNALI FILTRATI\MULTI UNIT\'
path_to_multiunit_notfilt='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\MULTIUNIT+NOISE\';
for i=1:length(list_snr)
<<<<<<< HEAD
    load(['Creazione Segnali\MULTIUNIT+NOISE\SNR ' num2str(list_snr(i)) '\Distribuzioni 1\1\signoise1_SNR' num2str(list_snr(i)) '.mat']);
=======
%     load([path_to_multiunit 'SNR' num2str(list_snr(i)) '\SNR' num2str(list_snr(i)) '_FilteredData\SNR' num2str(list_snr(i)) '_Mat_Files\' num2str(list_snr(i)) '\signoise1_SNR' num2str(list_snr(i)) '.mat']);
    load([path_to_multiunit_notfilt 'SNR ' num2str(list_snr(i)) '\Distribuzioni 1\1\signoise1_SNR' num2str(list_snr(i)) '.mat']); 
>>>>>>> 128f3fc441808cc5c880652150d41040436a2ca5
    for j=1:length(parameter)
        disp(['snr ' num2str(i) ' ,param: ' num2str(j)])
        load(['Dati\THRESH_VECTOR\param_snr1\thresh_vector_param' num2str(parameter(j)) '_snr' num2str(list_snr(i)) '.mat']);
        for k=1:length(list_PLP)
            [timestamps_found,dthresh]=ptsd_for_running_parameters(data,thresh_vector,fs,w_pre,w_post,DMdpolar,list_PLP(k),RP);
            timestamps_found_all{j,k,i}=timestamps_found;
        end
    end
end
%% save timestamps 
% it's too big just for just one matrix :( 
% timestamps_found_all_SNR1=cell(length(parameter),length(list_PLP));
% timestamps_found_all_SNR13=cell(length(parameter),length(list_PLP));
% timestamps_found_all_SNR115=cell(length(parameter),length(list_PLP));
timestamps_found_all_SNR1_notfilt=cell(length(parameter),length(list_PLP));
timestamps_found_all_SNR13_notfilt=cell(length(parameter),length(list_PLP));
timestamps_found_all_SNR115_notfilt=cell(length(parameter),length(list_PLP));
%%
timestamps_found_all_SNR1_notfilt=timestamps_found_all(:,:,1);
timestamps_found_all_SNR13_notfilt=timestamps_found_all(:,:,2);
timestamps_found_all_SNR115_notfilt=timestamps_found_all(:,:,3);
%%
% mkdir('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr')
<<<<<<< HEAD
save('Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\param_PLP_snr1_modified','timestamps_found_all_SNR1','list_PLP','parameter','list_snr','-v7.3')
%%
save('Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\param_PLP_snr13','timestamps_found_all_SNR13','list_PLP','parameter','list_snr','-v7.3')
%%
save('Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\param_PLP_snr115','timestamps_found_all_SNR115','list_PLP','parameter','list_snr','-v7.3')
=======
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\MULTI UNIT\param_PLP_snr1_notfilt','timestamps_found_all_SNR1_notfilt','list_PLP','parameter','list_snr','-v7.3')
%%
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\MULTI UNIT\param_PLP_snr13_notfilt','timestamps_found_all_SNR13_notfilt','list_PLP','parameter','list_snr','-v7.3')
%%
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\MULTI UNIT\param_PLP_snr115_notfilt','timestamps_found_all_SNR115_notfilt','list_PLP','parameter','list_snr','-v7.3')
>>>>>>> 128f3fc441808cc5c880652150d41040436a2ca5

%% load locations
load('Creazione Segnali\Multi-unit\Distribuzione 1\S1\loc_spike_s1.mat')
%% load saved timestamps SNR 1
% load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\MULTI UNIT\param_PLP_snr1.mat')
roc=cell(length(parameter),length(list_PLP));
for j=1:length(parameter)
    for k=1:length(list_PLP)
        roc{j,k} = PTSD_signal_analysis_multi_unit(timestamps_found_all_SNR1_notfilt{j,k},loc_spike_s1);
    end
end
<<<<<<< HEAD
save('Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\roc_snr1_modified','roc','list_PLP','parameter')
=======
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\MULTI UNIT\roc_snr1_notfilt','roc','list_PLP','parameter')
>>>>>>> 128f3fc441808cc5c880652150d41040436a2ca5
%% load saved timestamps SNR 1.3
% load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\MULTI UNIT\param_PLP_snr13.mat')
roc=cell(length(parameter),length(list_PLP));
for j=1:length(parameter)
    for k=1:length(list_PLP)
        roc{j,k} = PTSD_signal_analysis_multi_unit(timestamps_found_all_SNR13_notfilt{j,k},loc_spike_s1);
    end
end
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\MULTI UNIT\roc_snr13_notfilt','roc','list_PLP','parameter')
%% load saved timestamps SNR 1.15
% load('ANALISI SEGNALI\PTSD\param_PLP_snr\param_PLP_snr115.mat')
roc=cell(length(parameter),length(list_PLP));
for j=1:length(parameter)
    for k=1:length(list_PLP)
        roc{j,k} = PTSD_signal_analysis_multi_unit(timestamps_found_all_SNR115_notfilt{j,k},loc_spike_s1);
    end
end
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\MULTI UNIT\roc_snr115_notfilt','roc','list_PLP','parameter')
%% evaluate FP_rate and TP_rate (just for the graphic)
load('SINGLE UNIT DA ANALIZZARE\single_unit_ig.mat')
for j=1:length(parameter)
    for k=1:length(list_PLP)
        NREF=roc{j,k}.NREF;
        FP=roc{j,k}.fp;
        NCS=roc{j,k}.tp;
        [FP_rate(j,k),TP_rate(j,k)] = roc_parameters(NREF,FP,NCS,data);
    end
end
<<<<<<< HEAD
% save('Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\XY_roc_snr115','FP_rate','TP_rate','list_PLP','parameter')
%% plots
snr_level=1; %1.3 1.15
=======
% save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\XY_roc_snr13','FP_rate','TP_rate','list_PLP','parameter')
%% plots
snr_level=1.3; %1.3 1.15
>>>>>>> 128f3fc441808cc5c880652150d41040436a2ca5
make_figure(list_PLP,TP_rate,FP_rate,parameter,snr_level)
% savefig(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\params_ptsd_snr' num2str(snr_level) '.fig'])
%% EXPO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ù
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
timestamps_found_all=cell(length(parameter),length(list_PLP),length(list_snr));
path_to_expo='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SEGNALI FILTRATI\EXPO\';
for i=1:length(list_snr)
    load([path_to_expo 'SNR' num2str(list_snr(i)) '\SNR' num2str(list_snr(i)) '_FilteredData\SNR' num2str(list_snr(i)) '_Mat_Files\' num2str(list_snr(i)) '\expo_SNR' num2str(list_snr(i)) '.mat']);
    for j=1:length(parameter)
        load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\THRESH_VECTOR\thresh_vector_param' num2str(parameter(j)) '_snr' num2str(list_snr(i)) '.mat']);
        for k=1:length(list_PLP)
            [timestamps_found,dthresh]=ptsd_for_running_parameters(data,thresh_vector,fs,w_pre,w_post,DMdpolar,list_PLP(k),RP)
            timestamps_found_all{j,k,i}=timestamps_found;
        end
    end
end
%% save timestamps 
% it's too big just for just one matrix :( 
timestamps_found_all_SNR1_notfilt=cell(length(parameter),length(list_PLP));
timestamps_found_all_SNR13_notfilt=cell(length(parameter),length(list_PLP));
timestamps_found_all_SNR115_notfilt=cell(length(parameter),length(list_PLP));
%%
timestamps_found_all_SNR1_notfilt=timestamps_found_all(:,:,1);
timestamps_found_all_SNR13_notfilt=timestamps_found_all(:,:,2);
timestamps_found_all_SNR115_notfilt=timestamps_found_all(:,:,3);
%%
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\EXPO\param_PLP_expo_snr1','timestamps_found_all_SNR1','list_PLP','parameter','list_snr','-v7.3')
%%
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\EXPO\param_PLP_expo_snr13','timestamps_found_all_SNR13','list_PLP','parameter','list_snr','-v7.3')
%%
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\EXPO\param_PLP_expo_snr115','timestamps_found_all_SNR115','list_PLP','parameter','list_snr','-v7.3')

%% load locations
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Distribuzioni\1\expo_matrix1.mat')
%% load saved timestamps SNR 1
% load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\EXPO\param_PLP_expo_snr1.mat')
roc=cell(length(parameter),length(list_PLP));
for j=1:length(parameter)
    for k=1:length(list_PLP)
        roc{j,k} = PTSD_signal_analysis_single_unit(timestamps_found_all_SNR1_notfilt{j,k},expo_matrix);
    end
end
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\EXPO\roc_expo_snr1','roc','list_PLP','parameter')
clearvars -except expo_matrix parameter list_PLP
%% load saved timestamps SNR 1.3
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\EXPO\param_PLP_expo_snr13.mat')
roc=cell(length(parameter),length(list_PLP));
for j=1:length(parameter)
    for k=1:length(list_PLP)
        roc{j,k} = PTSD_signal_analysis_single_unit(timestamps_found_all_SNR13_notfilt{j,k},expo_matrix);
    end
end
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\EXPO\roc_expo_snr13','roc','list_PLP','parameter')
clearvars -except expo_matrix parameter list_PLP
%% load saved timestamps SNR 1.15
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\EXPO\param_PLP_expo_snr115.mat')
roc=cell(length(parameter),length(list_PLP));
for j=1:length(parameter)
    for k=1:length(list_PLP)
        roc{j,k} = PTSD_signal_analysis_single_unit(timestamps_found_all_SNR115_notfilt{j,k},expo_matrix);
    end
end
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\EXPO\roc_expo_snr115','roc','list_PLP','parameter')
clearvars -except expo_matrix parameter list_PLP 
%%
%% evaluate FP_rate and TP_rate (just for the graphic)
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SINGLE UNIT DA ANALIZZARE\single_unit_ig.mat')
for j=1:length(parameter)
    for k=1:length(list_PLP)
        NREF=roc{j,k}.NREF;
        FP=roc{j,k}.fp;
        NCS=roc{j,k}.tp;
        [FP_rate(j,k),TP_rate(j,k)] = roc_parameters(NREF,FP,NCS,data);
    end
end

%% plots
snr_level=1.15; %1.3 1.15
make_figure(list_PLP,TP_rate,FP_rate,parameter,snr_level)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% GAMMA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
timestamps_found_all=cell(length(parameter),length(list_PLP),length(list_snr));
path_to_gamma='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SEGNALI FILTRATI\GAMMA\';
for i=1:length(list_snr)
    load([path_to_gamma 'SNR' num2str(list_snr(i)) '\SNR' num2str(list_snr(i)) '_FilteredData\SNR' num2str(list_snr(i)) '_Mat_Files\' num2str(list_snr(i)) '\g_SNR' num2str(list_snr(i)) '.mat']);
    for j=1:length(parameter)
        load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\THRESH_VECTOR\thresh_vector_param' num2str(parameter(j)) '_snr' num2str(list_snr(i)) '.mat']);
        for k=1:length(list_PLP)
            [timestamps_found,dthresh]=ptsd_for_running_parameters(data,thresh_vector,fs,w_pre,w_post,DMdpolar,list_PLP(k),RP)
            timestamps_found_all{j,k,i}=timestamps_found;
        end
    end
end
%% save timestamps 
% it's too big just for just one matrix :( 
timestamps_found_all_SNR1_notfilt=cell(length(parameter),length(list_PLP));
timestamps_found_all_SNR13_notfilt=cell(length(parameter),length(list_PLP));
timestamps_found_all_SNR115_notfilt=cell(length(parameter),length(list_PLP));
%%
timestamps_found_all_SNR1_notfilt=timestamps_found_all(:,:,1);
timestamps_found_all_SNR13_notfilt=timestamps_found_all(:,:,2);
timestamps_found_all_SNR115_notfilt=timestamps_found_all(:,:,3);
%%
% mkdir('ANALISI SEGNALI\PTSD\param_PLP_snr')
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\GAMMA\param_PLP_gamma_snr1','timestamps_found_all_SNR1','list_PLP','parameter','list_snr','-v7.3')
%%
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\GAMMA\param_PLP_gamma_snr13','timestamps_found_all_SNR13','list_PLP','parameter','list_snr','-v7.3')
%%
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\GAMMA\param_PLP_gamma_snr115','timestamps_found_all_SNR115','list_PLP','parameter','list_snr','-v7.3')
%% load locations
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Distribuzioni\1\gamma_matrix1.mat')
%% load saved timestamps SNR 1
% load('ANALISI SEGNALI\PTSD ANALISI\PTSD\param_PLP_snr\param_PLP_gamma_snr1.mat')
roc=cell(length(parameter),length(list_PLP));
for j=1:length(parameter)
    for k=1:length(list_PLP)
        roc{j,k} = PTSD_signal_analysis_single_unit(timestamps_found_all_SNR1_notfilt{j,k},gamma_matrix);
    end
end
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\GAMMA\roc_gamma_snr1','roc','list_PLP','parameter')
clearvars -except gamma_matrix parameter list_PLP
%% load saved timestamps SNR 1.3
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\GAMMA\param_PLP_gamma_snr13.mat')
roc=cell(length(parameter),length(list_PLP));
for j=1:length(parameter)
    for k=1:length(list_PLP)
        roc{j,k} = PTSD_signal_analysis_single_unit(timestamps_found_all_SNR13_notfilt{j,k},gamma_matrix);
    end
end
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\GAMMA\roc_gamma_snr13','roc','list_PLP','parameter')
clearvars -except gamma_matrix parameter list_PLP
%% load saved timestamps SNR 1.15
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\GAMMA\param_PLP_gamma_snr115.mat')
roc=cell(length(parameter),length(list_PLP));
for j=1:length(parameter)
    for k=1:length(list_PLP)
        roc{j,k} = PTSD_signal_analysis_single_unit(timestamps_found_all_SNR115_notfilt{j,k},gamma_matrix);
    end
end
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\GAMMA\roc_gamma_snr115','roc','list_PLP','parameter')
clearvars -except gamma_matrix parameter list_PLP 
%% evaluate FP_rate and TP_rate (just for the graphic)
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SINGLE UNIT DA ANALIZZARE\single_unit_ig.mat')
for j=1:length(parameter)
    for k=1:length(list_PLP)
        NREF=roc{j,k}.NREF;
        FP=roc{j,k}.fp;
        NCS=roc{j,k}.tp;
        [FP_rate(j,k),TP_rate(j,k)] = roc_parameters(NREF,FP,NCS,data);
    end
end

%% plots
snr_level=1.15; %1.3 1.15
make_figure(list_PLP,TP_rate,FP_rate,parameter,snr_level)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% IG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
timestamps_found_all=cell(length(parameter),length(list_PLP),length(list_snr));
path_to_ig='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SEGNALI FILTRATI\INVGAU'
for i=1:length(list_snr)
    load([path_to_ig 'SNR' num2str(list_snr(i)) '\SNR' num2str(list_snr(i)) '_FilteredData\SNR' num2str(list_snr(i)) '_Mat_Files\' num2str(list_snr(i)) '\ig_SNR' num2str(list_snr(i)) '.mat']);
    for j=1:length(parameter)
        load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\THRESH_VECTOR\thresh_vector_param' num2str(parameter(j)) '_snr' num2str(list_snr(i)) '.mat']);
        for k=1:length(list_PLP)
            [timestamps_found,dthresh]=ptsd_for_running_parameters(data,thresh_vector,fs,w_pre,w_post,DMdpolar,list_PLP(k),RP)
            timestamps_found_all{j,k,i}=timestamps_found;
        end
    end
end
%% save timestamps 
% it's too big just for just one matrix :( 
timestamps_found_all_SNR1_notfilt=cell(length(parameter),length(list_PLP));
timestamps_found_all_SNR13_notfilt=cell(length(parameter),length(list_PLP));
timestamps_found_all_SNR115_notfilt=cell(length(parameter),length(list_PLP));
%%
timestamps_found_all_SNR1_notfilt=timestamps_found_all(:,:,1);
timestamps_found_all_SNR13_notfilt=timestamps_found_all(:,:,2);
timestamps_found_all_SNR115_notfilt=timestamps_found_all(:,:,3);
%%
% mkdir('ANALISI SEGNALI\PTSD\param_PLP_snr')
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\INVGAU\param_PLP_ig_snr1','timestamps_found_all_SNR1','list_PLP','parameter','list_snr','-v7.3')
%%
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\INVGAU\param_PLP_ig_snr13','timestamps_found_all_SNR13','list_PLP','parameter','list_snr','-v7.3')
%%
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\INVGAU\param_PLP_ig_snr115','timestamps_found_all_SNR115','list_PLP','parameter','list_snr','-v7.3')

%% load locations
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Distribuzioni\1\ig_matrix1.mat')
%% load saved timestamps SNR 1
%load('ANALISI SEGNALI\PTSD ANALISI\PTSD\param_PLP_snr\param_PLP_ig_snr1.mat')
roc=cell(length(parameter),length(list_PLP));
for j=1:length(parameter)
    for k=1:length(list_PLP)
        roc{j,k} = PTSD_signal_analysis_single_unit(timestamps_found_all_SNR1_notfilt{j,k},invgau_matrix);
    end
end
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\INVGAU\roc_ig_snr1','roc','list_PLP','parameter')
clearvars -except invgau_matrix parameter list_PLP
%% load saved timestamps SNR 1.3
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\INVGAU\param_PLP_ig_snr13.mat')
roc=cell(length(parameter),length(list_PLP));
for j=1:length(parameter)
    for k=1:length(list_PLP)
        roc{j,k} = PTSD_signal_analysis_single_unit(timestamps_found_all_SNR13_notfilt{j,k},invgau_matrix);
    end
end
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\INVGAU\roc_ig_snr13','roc','list_PLP','parameter')
clearvars -except invgau_matrix parameter list_PLP
%% load saved timestamps SNR 1.15
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\INVGAU\param_PLP_ig_snr115.mat')
roc=cell(length(parameter),length(list_PLP));
for j=1:length(parameter)
    for k=1:length(list_PLP)
        roc{j,k} = PTSD_signal_analysis_single_unit(timestamps_found_all_SNR115_notfilt{j,k},invgau_matrix);
    end
end
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\INVGAU\roc_ig_snr115','roc','list_PLP','parameter')
clearvars -except invgau_matrix parameter list_PLP 
%% evaluate FP_rate and TP_rate (just for the graphic)
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SINGLE UNIT DA ANALIZZARE\single_unit_ig.mat')
for j=1:length(parameter)
    for k=1:length(list_PLP)
        NREF=roc{j,k}.NREF;
        FP=roc{j,k}.fp;
        NCS=roc{j,k}.tp;
        [FP_rate(j,k),TP_rate(j,k)] = roc_parameters(NREF,FP,NCS,data);
    end
end

%% plots
snr_level=1.15; %1.3 1.15
make_figure(list_PLP,TP_rate,FP_rate,parameter,snr_level)
