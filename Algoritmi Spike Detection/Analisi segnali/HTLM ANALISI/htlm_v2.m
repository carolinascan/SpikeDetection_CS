clc, clear all, close all
%%
param1=1;
param2=10;
list_parameter=linspace(param1,param2,10);
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
list_snr=SNR_param(:,1);
%% MULTI UNIT
elapsed_time=zeros(length(list_parameter),length(list_snr));
timestamps_found_all=cell(length(list_parameter),length(list_snr));
list_rumori=1:10;
path_to_signal='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\SIGNAL V2\'
for i=1:length(list_snr)
    load([path_to_signal 'snr_' num2str(list_snr(i)) '.mat']);
    for j=1:length(list_parameter)
        disp(['snr ' num2str(i) ' ,param: ' num2str(j)])
        noise_filt=load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\N' num2str(list_rumori(i)) '\N' num2str(list_rumori(i)) '_FilteredData\N' num2str(list_rumori(i)) '_Mat_Files\' num2str(list_rumori(i)) '\noise.mat']);
        tic;
        [timestamps_found] = htlm(signal,list_parameter(j),noise_filt);
        timestamps_found_all{j,i}=timestamps_found;
        elapsed_time(j,i)=toc;
    end
end
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HTLM ANALISI\HTLM\MULTI UNIT V2\timestamps_all_andtime.mat'],'timestamps_found_all','elapsed_time','list_parameter')

%% load locations
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Multi-unit\Distribuzione 1\S1\loc_spike_s1.mat')

%%
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\SIGNAL V2\snr_0.5711.mat');

for i=1:length(SNR_param)
    for j=1:length(list_parameter)
        analysis_htlm= signal_analysis_multi_unit(timestamps_found_all{j,i},loc_spike_s1,signal);
        eff(j,1)=analysis_htlm.eff;
        TP(j,1)=analysis_htlm.tp;
        FP(j,1)=analysis_htlm.fp;
        TN(j,1)=analysis_htlm.tn;
        FN(j,1)=analysis_htlm.fn;
        Sensitivity(j,1)=analysis_htlm.sensitivity;
        Specificity(j,1)=analysis_htlm.specificity;
        FN_rate(j,1)=analysis_htlm.FN_rate;
        FP_rate(j,1)=analysis_htlm.FP_rate;
        FDR(j,1)=analysis_htlm.false_discovery_rate;
        accuracy(j,1)=analysis_htlm.accuracy;
        F1_score(j,1)=analysis_htlm.F1_score;
        precision(j,1)=analysis_htlm.precision;
        FOR(j,1)=analysis_htlm.FOR;
        MCC(j,1)=analysis_htlm.MCC;
        git{j,:}=analysis_htlm.git
        NPV(j,:)=analysis_htlm.NPV;
        TS_TP{j,:}=analysis_htlm.TS_tp;
        TS_TP_from_model{j,:}=analysis_htlm.TS_tp_from_model;

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

save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HTLM ANALISI\HTLM\MULTI UNIT V2\ANALYSIS.mat'],'TP_all','FP_all','EFF','parameter','list_snr','TN_all','FN_all','SPECIFICITY','SENSITIVITY','PRECISION','GIT_all','FOR_all','FN_rate_all','FP_rate_all','MCC_all','FDR_all','F1_SCORE','ACCURACY','NPV_all','TS_TP_all','TS_TP_FROM_MODEL_all')
%%
%% PLOTS
high=list_snr(1);
mid=list_snr(5);
low=list_snr(10);
chosen_snr=[high, mid, low];
%%
for l=1:length(chosen_snr)
    figure(1), 
    subplot(321), plot(list_parameter,SENSITIVITY((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('Sensitivity'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(322), plot(list_parameter,FP_rate_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('FPR'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(323), plot(list_parameter,PRECISION((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('Precision'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(324), plot(list_parameter,FOR_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('FOR'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(325), plot(list_parameter,SPECIFICITY((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('Specificity'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(326), plot(list_parameter,FN_rate_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('FNR'), ylim([0 1])
    legend1=legend('SNR High' ,'SNR Mid', 'SNR Low');
    set(legend1,...
    'Position',[0.719669855692367 0.873965179591807 0.172500001941408 0.10333333551316]);

end
   suptitle(['Hard Threshold Local Maxima'])


%%
for l=1:length(chosen_snr)
    figure(1),
    subplot(321), plot(list_parameter,NPV_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('NPV'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(322), plot(list_parameter,FDR_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('FDR'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(323), plot(list_parameter,EFF((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('Efficiency'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(324), plot(list_parameter,ACCURACY((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('Accuracy'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(325), plot(list_parameter,F1_SCORE((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('F1Score'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(326), plot(list_parameter,MCC_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('MCC'), ylim([-1 1])
    legend1=legend('SNR High' ,'SNR Mid', 'SNR Low');
    set(legend1,...
    'Position',[0.719669855692367 0.873965179591807 0.172500001941408 0.10333333551316]);

end
   suptitle(['Hard Threshold Local Maxima'])

   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SINGLE UNIT 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5%%%%
%% DETECTION 
timestamps_found_all=cell(length(list_parameter),length(list_snr));
list_rumori=1:10;
path_to_signal='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\SINGLE UNIT V2\'
for i=1:length(list_snr)
    load([path_to_signal 'snr_' num2str(list_snr(i)) '.mat']);
    for j=1:length(list_parameter)
        disp(['snr ' num2str(i) ' ,param: ' num2str(j)])
        noise_filt=load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\N' num2str(list_rumori(i)) '\N' num2str(list_rumori(i)) '_FilteredData\N' num2str(list_rumori(i)) '_Mat_Files\' num2str(list_rumori(i)) '\noise.mat']);
        tic;
        [timestamps_found] = ht(signal,list_parameter(j),noise_filt);
        timestamps_found_all{j,i}=timestamps_found;
        elapsed_time(j,i)=toc;
    end
end
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HTLM ANALISI\HTLM\SINGLE UNIT V2\timestamps_all_andtime.mat'],'timestamps_found_all','elapsed_time','list_parameter')
%% load locations
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Distribuzioni\1\ig_matrix1.mat')
loc_spikeSU=find(invgau_matrix.spikeTrain(87,:)); 
%% ANALYSIS
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\SIGNAL V2\snr_0.5711.mat');
for i=1:length(SNR_param)
    for j=1:length(list_parameter)
        analysis_htlm= signal_analysis_single_unit(timestamps_found_all{j,i},invgau_matrix,signal);
        eff(j,1)=analysis_htlm.eff;
        TP(j,1)=analysis_htlm.tp;
        FP(j,1)=analysis_htlm.fp;
        TN(j,1)=analysis_htlm.tn;
        FN(j,1)=analysis_htlm.fn;
        Sensitivity(j,1)=analysis_htlm.sensitivity;
        Specificity(j,1)=analysis_htlm.specificity;
        FN_rate(j,1)=analysis_htlm.FN_rate;
        FP_rate(j,1)=analysis_htlm.FP_rate;
        FDR(j,1)=analysis_htlm.false_discovery_rate;
        accuracy(j,1)=analysis_htlm.accuracy;
        F1_score(j,1)=analysis_htlm.F1_score;
        precision(j,1)=analysis_htlm.precision;
        FOR(j,1)=analysis_htlm.FOR;
        MCC(j,1)=analysis_htlm.MCC;
        git{j,:}=analysis_htlm.git;
        NPV(j,:)=analysis_htlm.NPV;
        TS_TP{j,:}=analysis_htlm.TS_tp;
        TS_TP_from_model{j,:}=analysis_htlm.TS_tp_from_model;
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

save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HTLM ANALISI\HTLM\SINGLE UNIT V2\ANALYSIS.mat'],'TP_all','FP_all','EFF','list_parameter','list_snr','TN_all','FN_all','SPECIFICITY','SENSITIVITY','PRECISION','GIT_all','FOR_all','FN_rate_all','FP_rate_all','MCC_all','FDR_all','F1_SCORE','ACCURACY','NPV_all','TS_TP_all','TS_TP_FROM_MODEL_all')
%% PLOTS
high=list_snr(1);
mid=list_snr(5);
low=list_snr(10);
chosen_snr=[high, mid, low];
%%
for l=1:length(chosen_snr)
    figure(1), 
    subplot(321), plot(list_parameter,SENSITIVITY((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('Sensitivity'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(322), plot(list_parameter,FP_rate_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('FPR'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(323), plot(list_parameter,PRECISION((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('Precision'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(324), plot(list_parameter,FOR_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('FOR'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(325), plot(list_parameter,SPECIFICITY((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('Specificity'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(326), plot(list_parameter,FN_rate_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('FNR'), ylim([0 1])
    legend1=legend('SNR High' ,'SNR Mid', 'SNR Low');
    set(legend1,...
    'Position',[0.719669855692367 0.873965179591807 0.172500001941408 0.10333333551316]);

end
suptitle(['Hard Threshold Local Maxima'])


%%
for l=1:length(chosen_snr)
    figure(2),
    subplot(321), plot(list_parameter,NPV_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('NPV'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(322), plot(list_parameter,FDR_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('FDR'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(323), plot(list_parameter,EFF((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('Efficiency'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(324), plot(list_parameter,ACCURACY((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('Accuracy'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(325), plot(list_parameter,F1_SCORE((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('F1Score'), ylim([0 1])
%     legend('SNR High' ,'SNR Mid', 'SNR Low')
    subplot(326), plot(list_parameter,MCC_all((list_snr==chosen_snr(l)),:),'LineWidth',3), hold on, xlabel('multCoeff'), ylabel('MCC'), ylim([-1 1])
    legend1=legend('SNR High' ,'SNR Mid', 'SNR Low');
    set(legend1,...
    'Position',[0.719669855692367 0.873965179591807 0.172500001941408 0.10333333551316]);

end
suptitle(['Hard Threshold Local Maxima'])



