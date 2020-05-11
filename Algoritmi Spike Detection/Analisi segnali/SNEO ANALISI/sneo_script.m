%%
clc, clear all, close all
%% INPUT

%     pars      :       Parameters structure from SPIKEDETECTCLUSTER with
%                       the following fields:
%
%       -> SNEO_N    \\ number of samples for smoothing window
%       -> MULTCOEFF \\ factor to multiply NEO noise threshold by
%       -> FS        \\ sampling frequency
%       -> NS_AROUND \\ window to reduce concecutive crossings to single
%                       points
%       -> REFRTIME  \\ refractory period (minimum distance between spikes)
%% OUTPUT
%   ts        :       Timestamps (sample indices) of spike peaks.
%
%    pmin       :       Value at peak minimum. (pw) in SPIKEDETECTIONARRAY
%
%      dt       :       Time difference between spikes. (pp) in
%                       SPIKEDETECTIONARRAY
%
%      E        :       Smoothed nonlinear energy operator value at peaks.
%% PARAMETERS 
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
list_snr=SNR_param(:,1);
list_multCoeff=linspace(1,10,10);
list_smooth_factor=1:10:100; %must be integer
timestamps_found_all=cell(length(list_multCoeff),length(list_smooth_factor),length(list_snr));
fs=24414;
pars.REFRTIME= 1;  % Refractory period (suggest: 2 ms MAX).
pars.NS_AROUND= 15;    % Number of samples around the peak to "look" for negative peak SIMIL PLP???
pars.FS=fs;
art_idx=[];
%% MULTI UNIT
path_to_signal='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\SIGNAL V2\'
for i=1:length(list_snr)
    load([path_to_signal 'snr_' num2str(list_snr(i)) '.mat']);
     for j=1:length(list_multCoeff)
        disp(['snr ' num2str(i) ' ,multCoeff: ' num2str(j)])
        for k=1:length(list_smooth_factor)
            pars.MULTCOEFF=list_multCoeff(j);
            pars.SNEO_N=list_smooth_factor(k); 
            tic;
            [ts,pmin] = SNEOThreshold(signal,pars,art_idx);
            timestamps_found_all{j,k,i}=ts;
            elapsed_time(j,k,i)=toc;
        end
    end
end
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SNEO ANALISI\SNEO\timestamps_found_all.mat'],'timestamps_found_all','elapsed_time','list_multCoeff','list_smooth_factor');
%% load locations
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Multi-unit\Distribuzione 1\S1\loc_spike_s1.mat')

%% Create roc and isolate Efficiencies 
% EFF=zeros(length(list_snr),length(list_multCoeff),length(list_smooth_factor));
% eff=zeros(length(list_multCoeff),length(list_smooth_factor));
% TP=zeros(length(list_multCoeff),length(list_smooth_factor));
% FP=zeros(length(list_multCoeff),length(list_smooth_factor));
% TP_all=zeros(length(list_snr),length(list_multCoeff),length(list_smooth_factor));
% FP_all=zeros(length(list_snr),length(list_multCoeff),length(list_smooth_factor));
for i=1:length(list_snr)
    for j=1:length(list_multCoeff)
        for k=1:length(list_smooth_factor)
            analysis_sneo= signal_analysis_multi_unit(timestamps_found_all{j,k,i},loc_spike_s1,signal);
            eff(j,k)=analysis_sneo.eff;
            TP(j,k)=analysis_sneo.tp;
            FP(j,k)=analysis_sneo.fp;
            TN(j,k)=analysis_sneo.tn;
            FN(j,k)=analysis_sneo.fn;
            Sensitivity(j,k)=analysis_sneo.sensitivity;
            Specificity(j,k)=analysis_sneo.specificity;
            FN_rate(j,k)=analysis_sneo.FN_rate;
            FP_rate(j,k)=analysis_sneo.FP_rate;
            FDR(j,k)=analysis_sneo.false_discovery_rate;
            accuracy(j,k)=analysis_sneo.accuracy;
            F1_score(j,k)=analysis_sneo.F1_score;
            precision(j,k)=analysis_sneo.precision;
            FOR(j,k)=analysis_sneo.FOR;
            MCC(j,k)=analysis_sneo.MCC;
            git{j,k,:}=analysis_sneo.git;
            NPV(j,k)=analysis_sneo.NPV;
            TS_TP{j,k,:}=analysis_sneo.TS_tp;
            TS_TP_from_model{j,k,:}=analysis_sneo.TS_tp_from_model;
            clear analysis 
        end
    end
    TP_all(i,:,:)=TP;
    FP_all(i,:,:)=FP;
    EFF(i,:,:)=eff;
    TN_all(i,:,:)=TN;
    FN_all(i,:,:)=FN;
    SENSITIVITY(i,:,:)=Sensitivity;
    SPECIFICITY(i,:,:)=Specificity;
    FN_rate_all(i,:,:)=FN_rate;
    FP_rate_all(i,:,:)=FP_rate;
    FDR_all(i,:,:)=FDR;
    ACCURACY(i,:,:)=accuracy;
    F1_SCORE(i,:,:)=F1_score;
    PRECISION(i,:,:)=precision;
    FOR_all(i,:,:)=FOR;
    MCC_all(i,:,:)=MCC;
    GIT_all(i,:,:)=git;
    NPV_all(i,:,:)=NPV;
    TS_TP_all(i,:,:)=TS_TP;
    TS_TP_FROM_MODEL_all(i,:,:)=TS_TP_from_model;
end
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SNEO ANALISI\SNEO\ANALYSIS.mat'],'TP_all','FP_all','EFF','list_multCoeff','list_snr','TN_all','FN_all','SPECIFICITY','SENSITIVITY','PRECISION','GIT_all','FOR_all','FN_rate_all','FP_rate_all','MCC_all','FDR_all','F1_SCORE','ACCURACY','NPV_all','TS_TP_all','TS_TP_FROM_MODEL_all')
%% 
method='SNEO';
%% PLOTS
high=list_snr(1);
mid=list_snr(5);
low=list_snr(10);
chosen_snr=[high, mid, low];
%% SENSITIVITY & FPR
title_figure1='Sensitivity'
title_figure2='FPR'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_smooth_factor,(squeeze(SENSITIVITY((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_smooth_factor,(squeeze(FP_rate_all((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure2,method)
end 
%% PRECISION & FALSE OMISSION RATE
title_figure1='Precision'
title_figure2='FOR'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_smooth_factor,(squeeze(PRECISION((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_smooth_factor,(squeeze(FOR_all((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure2,method)
end 

%% SPECIFICITY & FALSE NEGATIVE RATE
title_figure1='Specificity'
title_figure2='FNR'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_smooth_factor,(squeeze(SPECIFICITY((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_smooth_factor,(squeeze(FN_rate_all((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure2,method)
end 
%% NEGATIVE PREDICTIVE VALUE & FALSE DISCOVERY RATE
FDR_ALL=FDR_all./100;
title_figure1='NPV'
title_figure2='FDR'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_smooth_factor,(squeeze(NPV_all((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_smooth_factor,(squeeze(FDR_ALL((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure2,method)
end 

%% EFFICIENCY & ACCURACY 
title_figure1='Efficiency'
title_figure2='Accuracy'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_smooth_factor,(squeeze(EFF((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MAXIMIZE(ax2,list_smooth_factor,(squeeze(ACCURACY((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure2,method)
end 

%% F1 SCORE && MATTHEWS CORRELATION COEFFICIENT 
title_figure1='F1Score'
title_figure2='MCC'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_smooth_factor,(squeeze(F1_SCORE((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MCC(ax2,list_smooth_factor,(squeeze(MCC_all((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure2,method)
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SINGLE UNIT 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5%%%%
%% DETECTION
path_to_signal='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\SINGLE UNIT V2\'
for i=1:length(list_snr)
    load([path_to_signal 'snr_' num2str(list_snr(i)) '.mat']);
     for j=1:length(list_multCoeff)
        disp(['snr ' num2str(i) ' ,multCoeff: ' num2str(j)])
        for k=1:length(list_smooth_factor)
            pars.MULTCOEFF=list_multCoeff(j);
            pars.SNEO_N=list_smooth_factor(k); 
            tic;
            [ts,pmin] = SNEOThreshold(signal,pars,art_idx);
            timestamps_found_all{j,k,i}=ts;
            elapsed_time(j,k,i)=toc;
        end
    end
end
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SNEO ANALISI\SNEO\SINGLE UNIT V2\timestamps_found_all.mat'],'timestamps_found_all','elapsed_time','list_multCoeff','list_smooth_factor');
%% load locations
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Distribuzioni\1\ig_matrix1.mat')
loc_spikeSU=find(invgau_matrix.spikeTrain(87,:)); 
%%
for i=1:length(list_snr)
    for j=1:length(list_multCoeff)
        for k=1:length(list_smooth_factor)
            analysis_sneo= signal_analysis_single_unit(timestamps_found_all{j,k,i},invgau_matrix,signal);
            eff(j,k)=analysis_sneo.eff;
            TP(j,k)=analysis_sneo.tp;
            FP(j,k)=analysis_sneo.fp;
            TN(j,k)=analysis_sneo.tn;
            FN(j,k)=analysis_sneo.fn;
            Sensitivity(j,k)=analysis_sneo.sensitivity;
            Specificity(j,k)=analysis_sneo.specificity;
            FN_rate(j,k)=analysis_sneo.FN_rate;
            FP_rate(j,k)=analysis_sneo.FP_rate;
            FDR(j,k)=analysis_sneo.false_discovery_rate;
            accuracy(j,k)=analysis_sneo.accuracy;
            F1_score(j,k)=analysis_sneo.F1_score;
            precision(j,k)=analysis_sneo.precision;
            FOR(j,k)=analysis_sneo.FOR;
            MCC(j,k)=analysis_sneo.MCC;
            git{j,k,:}=analysis_sneo.git;
            NPV(j,k)=analysis_sneo.NPV;
            TS_TP{j,k,:}=analysis_sneo.TS_tp;
            TS_TP_from_model{j,k,:}=analysis_sneo.TS_tp_from_model;
            clear analysis 
        end
    end
    TP_all(i,:,:)=TP;
    FP_all(i,:,:)=FP;
    EFF(i,:,:)=eff;
    TN_all(i,:,:)=TN;
    FN_all(i,:,:)=FN;
    SENSITIVITY(i,:,:)=Sensitivity;
    SPECIFICITY(i,:,:)=Specificity;
    FN_rate_all(i,:,:)=FN_rate;
    FP_rate_all(i,:,:)=FP_rate;
    FDR_all(i,:,:)=FDR;
    ACCURACY(i,:,:)=accuracy;
    F1_SCORE(i,:,:)=F1_score;
    PRECISION(i,:,:)=precision;
    FOR_all(i,:,:)=FOR;
    MCC_all(i,:,:)=MCC;
    GIT_all(i,:,:)=git;
    NPV_all(i,:,:)=NPV;
    TS_TP_all(i,:,:)=TS_TP;
    TS_TP_FROM_MODEL_all(i,:,:)=TS_TP_from_model;
end
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SNEO ANALISI\SNEO\SINGLE UNIT V2\ANALYSIS.mat'],'TP_all','FP_all','EFF','list_multCoeff','list_snr','TN_all','FN_all','SPECIFICITY','SENSITIVITY','PRECISION','GIT_all','FOR_all','FN_rate_all','FP_rate_all','MCC_all','FDR_all','F1_SCORE','ACCURACY','NPV_all','TS_TP_all','TS_TP_FROM_MODEL_all')
%% 
method='SNEO';
%% PLOTS
high=list_snr(1);
mid=list_snr(5);
low=list_snr(10);
chosen_snr=[high, mid, low];
%% SENSITIVITY & FPR
title_figure1='Sensitivity'
title_figure2='FPR'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_smooth_factor,(squeeze(SENSITIVITY((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_smooth_factor,(squeeze(FP_rate_all((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure2,method)
end 
%% PRECISION & FALSE OMISSION RATE
title_figure1='Precision'
title_figure2='FOR'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_smooth_factor,(squeeze(PRECISION((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_smooth_factor,(squeeze(FOR_all((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure2,method)
end 

%% SPECIFICITY & FALSE NEGATIVE RATE
title_figure1='Specificity'
title_figure2='FNR'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_smooth_factor,(squeeze(SPECIFICITY((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_smooth_factor,(squeeze(FN_rate_all((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure2,method)
end 
%% NEGATIVE PREDICTIVE VALUE & FALSE DISCOVERY RATE
FDR_ALL=FDR_all;
title_figure1='NPV'
title_figure2='FDR'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_smooth_factor,(squeeze(NPV_all((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_smooth_factor,(squeeze(FDR_ALL((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure2,method)
end 

%% EFFICIENCY & ACCURACY 
title_figure1='Efficiency'
title_figure2='Accuracy'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_smooth_factor,(squeeze(EFF((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MAXIMIZE(ax2,list_smooth_factor,(squeeze(ACCURACY((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure2,method)
end 

%% F1 SCORE && MATTHEWS CORRELATION COEFFICIENT 
title_figure1='F1Score'
title_figure2='MCC'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_smooth_factor,(squeeze(F1_SCORE((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MCC(ax2,list_smooth_factor,(squeeze(MCC_all((list_snr==chosen_snr(l)),:,:))),list_multCoeff,list_snr(l),title_figure2,method)
end 