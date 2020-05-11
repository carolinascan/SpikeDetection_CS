clc, clear all, close all
%%
fs=24414;
in.SaRa=fs;
params.method='auto'; % 'energy','lambda','numspikes'
param1=110;
param2=1e4;
parameter=linspace(param1,param2,10);
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
list_snr=SNR_param(:,1);
%% MULTI UNIT
min_spikepos_all=cell(length(parameter),length(list_snr));
list_rumori=1:10;
path_to_signal='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\SIGNAL V2\'
for i=1:length(list_snr)
    load([path_to_signal 'snr_' num2str(list_snr(i)) '.mat']);
    in.M=signal;
    for j=1:length(parameter)
        params.global_fac = parameter(j); 
        disp(['snr ' num2str(i) ' ,param: ' num2str(j)])
        tic;
        [timestamps_found] = SWTTEO_adapted(in,params);
        [min_spikepos]= find_min_peaks(signal,timestamps_found);
        min_spikepos_all{j,i}=min_spikepos;
        elapsed_time(j,i)=toc;
        clear timestamps_found min_spikepos
    end
    
end

save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SWTTEO ANALISI\SWTTEO\MULTI UNIT V2\timestamps_all_andtime.mat'],'min_spikepos_all','elapsed_time')
%% load locations
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Multi-unit\Distribuzione 1\S1\loc_spike_s1.mat')

%%
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\SIGNAL V2\snr_0.5711.mat');
for i=1:length(SNR_param)
    for j=1:length(parameter)
        analysis_swtteo= signal_analysis_multi_unit(min_spikepos_all{j,i},loc_spike_s1,signal);
        eff(j,1)=analysis_swtteo.eff;
        TP(j,1)=analysis_swtteo.tp;
        FP(j,1)=analysis_swtteo.fp;
        TN(j,1)=analysis_swtteo.tn;
        FN(j,1)=analysis_swtteo.fn;
        Sensitivity(j,1)=analysis_swtteo.sensitivity;
        Specificity(j,1)=analysis_swtteo.specificity;
        FN_rate(j,1)=analysis_swtteo.FN_rate;
        FP_rate(j,1)=analysis_swtteo.FP_rate;
        FDR(j,1)=analysis_swtteo.false_discovery_rate;
        accuracy(j,1)=analysis_swtteo.accuracy;
        F1_score(j,1)=analysis_swtteo.F1_score;
        precision(j,1)=analysis_swtteo.precision;
        FOR(j,1)=analysis_swtteo.FOR;
        MCC(j,1)=analysis_swtteo.MCC;
        git{j,:}=analysis_swtteo.git;
        NPV(j,:)=analysis_swtteo.NPV;
        TS_TP{j,:}=analysis_swtteo.TS_tp;
        TS_TP_from_model{j,:}=analysis_swtteo.TS_tp_from_model;
        clear analysis
    end
    TP_all(i,:)=TP;
    FP_all(i,:)=FP;
    EFF(i,:)=eff;
    TN_all(i,:)=TN;
    FN_all(i,:)=FN;
    SENSITIVITY(i,:)=Sensitivity;
    SPECIFICITY(i,:)=Specificity;
    FN_rate_all(i,:)=FN_rate;
    FP_rate_all(i,:)=FP_rate;
    FDR_all(i,:)=FDR;
    ACCURACY(i,:)=accuracy;
    F1_SCORE(i,:)=F1_score;
    PRECISION(i,:)=precision;
    FOR_all(i,:)=FOR;
    MCC_all(i,:)=MCC;
    GIT_all(i,:)=git;
    NPV_all(i,:)=NPV;
    TS_TP_all(i,:,:)=TS_TP;
    TS_TP_FROM_MODEL_all(i,:,:)=TS_TP_from_model;
end

save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SWTTEO ANALISI\SWTTEO\MULTI UNIT V2\ANALYSIS.mat'],'TP_all','FP_all','EFF','parameter','list_snr','TN_all','FN_all','SPECIFICITY','SENSITIVITY','PRECISION','GIT_all','FOR_all','FN_rate_all','FP_rate_all','MCC_all','FDR_all','F1_SCORE','ACCURACY','NPV_all','TS_TP_all','TS_TP_FROM_MODEL_all')
%% PLOTS
high=list_snr(1);
mid=list_snr(5);
low=list_snr(10);
chosen_snr=[high, mid, low];
%%
for l=1:length(chosen_snr)
    figure(1), 
    subplot(321), plot(parameter,SENSITIVITY((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('Sensitivity'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(322), plot(parameter,FP_rate_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('FPR'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(323), plot(parameter,PRECISION((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('Precision'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(324), plot(parameter,FOR_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('FOR'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(325), plot(parameter,SPECIFICITY((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('Specificity'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(326), plot(parameter,FN_rate_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('FNR'), ylim([0 1])
    legend1=legend('SNR High' ,'SNR Mid', 'SNR Low');
    set(legend1,...
    'Position',[0.719669855692367 0.873965179591807 0.172500001941408 0.10333333551316]);

end
   suptitle(['SWTTEO'])


%%
for l=1:length(chosen_snr)
    figure(2),
    subplot(321), plot(parameter,NPV_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('NPV'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(322), plot(parameter,FDR_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('FDR'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(323), plot(parameter,EFF((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('Efficiency'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(324), plot(parameter,ACCURACY((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('Accuracy'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(325), plot(parameter,F1_SCORE((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('F1Score'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(326), plot(parameter,MCC_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('MCC'), ylim([-1 1])
%     legend1=legend('SNR High' ,'SNR Mid', 'SNR Low');
%     set(legend1,...
%     'Position',[0.719669855692367 0.873965179591807 0.172500001941408 0.10333333551316]);

end
% suptitle(['SWTTEO'])
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SINGLE UNIT 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5%%%%
%% DETECTION
min_spikepos_all=cell(length(parameter),length(list_snr));
list_rumori=1:10;
path_to_signal='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\SINGLE UNIT V2\easy\'
for i=1:length(list_snr)
    load([path_to_signal 'snr_' num2str(list_snr(i)) '.mat']);
    in.M=signal;
    for j=1:length(parameter)
        params.global_fac = parameter(j); 
        disp(['snr ' num2str(i) ' ,param: ' num2str(j)])
        tic;
        [timestamps_found] = SWTTEO_adapted(in,params);
        [min_spikepos]= find_min_peaks(signal,timestamps_found);
        min_spikepos_all{j,i}=min_spikepos;
        elapsed_time(j,i)=toc;
        clear timestamps_found min_spikepos
    end
    
end
mkdir(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SWTTEO ANALISI\SWTTEO\SINGLE UNIT V2\easy']);
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SWTTEO ANALISI\SWTTEO\SINGLE UNIT V2\easy\timestamps_all_andtime.mat'],'min_spikepos_all','elapsed_time')
%% load locations
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Distribuzioni\1\ig_matrix1.mat')
loc_spikeSU=find(invgau_matrix.spikeTrain(87,:)); 
%%
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\SIGNAL V2\snr_0.5711.mat');
for i=1:length(SNR_param)
    for j=1:length(parameter)
        analysis_swtteo= signal_analysis_single_unit(min_spikepos_all{j,i},invgau_matrix,signal);
        eff(j,1)=analysis_swtteo.eff;
        TP(j,1)=analysis_swtteo.tp;
        FP(j,1)=analysis_swtteo.fp;
        TN(j,1)=analysis_swtteo.tn;
        FN(j,1)=analysis_swtteo.fn;
        Sensitivity(j,1)=analysis_swtteo.sensitivity;
        Specificity(j,1)=analysis_swtteo.specificity;
        FN_rate(j,1)=analysis_swtteo.FN_rate;
        FP_rate(j,1)=analysis_swtteo.FP_rate;
        FDR(j,1)=analysis_swtteo.false_discovery_rate;
        accuracy(j,1)=analysis_swtteo.accuracy;
        F1_score(j,1)=analysis_swtteo.F1_score;
        precision(j,1)=analysis_swtteo.precision;
        FOR(j,1)=analysis_swtteo.FOR;
        MCC(j,1)=analysis_swtteo.MCC;
        git{j,:}=analysis_swtteo.git;
        NPV(j,:)=analysis_swtteo.NPV;
        TS_TP{j,:}=analysis_swtteo.TS_tp;
        TS_TP_from_model{j,:}=analysis_swtteo.TS_tp_from_model;
        clear analysis
    end
    TP_all(i,:)=TP;
    FP_all(i,:)=FP;
    EFF(i,:)=eff;
    TN_all(i,:)=TN;
    FN_all(i,:)=FN;
    SENSITIVITY(i,:)=Sensitivity;
    SPECIFICITY(i,:)=Specificity;
    FN_rate_all(i,:)=FN_rate;
    FP_rate_all(i,:)=FP_rate;
    FDR_all(i,:)=FDR;
    ACCURACY(i,:)=accuracy;
    F1_SCORE(i,:)=F1_score;
    PRECISION(i,:)=precision;
    FOR_all(i,:)=FOR;
    MCC_all(i,:)=MCC;
    GIT_all(i,:)=git;
    NPV_all(i,:)=NPV;
    TS_TP_all(i,:,:)=TS_TP;
    TS_TP_FROM_MODEL_all(i,:,:)=TS_TP_from_model;
end

save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SWTTEO ANALISI\SWTTEO\SINGLE UNIT V2\easy\ANALYSIS.mat'],'TP_all','FP_all','EFF','parameter','list_snr','TN_all','FN_all','SPECIFICITY','SENSITIVITY','PRECISION','GIT_all','FOR_all','FN_rate_all','FP_rate_all','MCC_all','FDR_all','F1_SCORE','ACCURACY','NPV_all','TS_TP_all','TS_TP_FROM_MODEL_all')
%% PLOTS
high=list_snr(1);
mid=list_snr(5);
low=list_snr(10);
chosen_snr=[high, mid, low];
%%
for l=1:length(chosen_snr)
    figure(1), 
    subplot(321), plot(parameter,SENSITIVITY((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('Sensitivity'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(322), plot(parameter,FP_rate_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('FPR'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(323), plot(parameter,PRECISION((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('Precision'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(324), plot(parameter,FOR_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('FOR'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(325), plot(parameter,SPECIFICITY((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('Specificity'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(326), plot(parameter,FN_rate_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('FNR'), ylim([0 1])
    legend1=legend('SNR High' ,'SNR Mid', 'SNR Low');
    set(legend1,...
    'Position',[0.719669855692367 0.873965179591807 0.172500001941408 0.10333333551316]);

end
   suptitle(['SWTTEO'])


%%
for l=1:length(chosen_snr)
    figure(2),
    subplot(321), plot(parameter,NPV_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('NPV'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(322), plot(parameter,FDR_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('FDR'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(323), plot(parameter,EFF((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('Efficiency'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(324), plot(parameter,ACCURACY((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('Accuracy'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(325), plot(parameter,F1_SCORE((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('F1Score'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(326), plot(parameter,MCC_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('MCC'), ylim([-1 1])
    legend1=legend('SNR High' ,'SNR Mid', 'SNR Low');
    set(legend1,...
    'Position',[0.719669855692367 0.873965179591807 0.172500001941408 0.10333333551316]);

end
suptitle(['SWTTEO'])
   
