clc, clear all, close all
%%
time_window1=0.5; %s
time_window2=8; %s
list_TimeWindow=linspace(time_window1,time_window2,10);
param1=1;
param2=10;
list_parameter=linspace(param1,param2,10);
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
list_snr=SNR_param(:,1);
%% MULTI UNIT 
timestamps_found_all=cell(length(list_parameter),length(list_TimeWindow),length(list_snr));
path_to_signal='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\SIGNAL V2\'
for i=1:length(list_snr)
    load([path_to_signal 'snr_' num2str(list_snr(i)) '.mat']);
    for j=1:length(list_parameter)
        disp(['snr ' num2str(i) ' ,param: ' num2str(j)])
        for k=1:length(list_TimeWindow)
            tic;
            [timestamps_found,soglia,rp]=atlm(signal,list_parameter(j),list_TimeWindow(k));
            timestamps_found_all{j,k,i}=timestamps_found;
            soglia_all{j,k,i}=soglia;
            elapsed_time(j,k,i)=toc;
        end
    end
end
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\ATLM ANALISI\ATLM\timestamps_found_all.mat'],'timestamps_found_all','elapsed_time','soglia_all','list_parameter','list_TimeWindow');
%% load locations
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Multi-unit\Distribuzione 1\S1\loc_spike_s1.mat')
%% Create roc and isolate Efficiencies
% EFF=zeros(length(list_snr),length(list_parameter),length(list_TimeWindow));
% eff=zeros(length(list_parameter),length(list_TimeWindow));
% TP=zeros(length(list_parameter),length(list_TimeWindow));
% FP=zeros(length(list_parameter),length(list_TimeWindow));
% TP_all=zeros(length(list_snr),length(list_parameter),length(list_TimeWindow));
% FP_all=zeros(length(list_snr),length(list_parameter),length(list_TimeWindow));
for i=1:length(list_snr)
    for j=1:length(list_parameter)
        for k=1:length(list_TimeWindow)
            analysis_atlm= signal_analysis_multi_unit((timestamps_found_all{j,k,i}),loc_spike_s1,signal);
            eff(j,k)=analysis_atlm.eff;
            TP(j,k)=analysis_atlm.tp;
            FP(j,k)=analysis_atlm.fp;
            TN(j,k)=analysis_atlm.tn;
            FN(j,k)=analysis_atlm.fn;
            Sensitivity(j,k)=analysis_atlm.sensitivity;
            Specificity(j,k)=analysis_atlm.specificity;
            FN_rate(j,k)=analysis_atlm.FN_rate;
            FP_rate(j,k)=analysis_atlm.FP_rate;
            FDR(j,k)=analysis_atlm.false_discovery_rate;
            accuracy(j,k)=analysis_atlm.accuracy;
            F1_score(j,k)=analysis_atlm.F1_score;
            precision(j,k)=analysis_atlm.precision;
            FOR(j,k)=analysis_atlm.FOR;
            MCC(j,k)=analysis_atlm.MCC;
            git{j,k,:}=analysis_atlm.git;
            NPV(j,k)=analysis_atlm.NPV;
            TS_TP{j,k,:}=analysis_atlm.TS_tp;
            TS_TP_from_model{j,k,:}=analysis_atlm.TS_tp_from_model;
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
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\ATLM ANALISI\ATLM\MULTI UNIT V2\ANALYSIS.mat'],'TP_all','FP_all','EFF','list_parameter','list_snr','TN_all','FN_all','SPECIFICITY','SENSITIVITY','PRECISION','GIT_all','FOR_all','FN_rate_all','FP_rate_all','MCC_all','FDR_all','F1_SCORE','ACCURACY','NPV_all','TS_TP_all','TS_TP_FROM_MODEL_all')
%%
method='ATLM';
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
    makeFig_MAXIMIZE(ax,list_TimeWindow,(squeeze(SENSITIVITY((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_TimeWindow,(squeeze(FP_rate_all((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure2,method)
end 
%% PRECISION & FALSE OMISSION RATE
title_figure1='Precision'
title_figure2='FOR'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_TimeWindow,(squeeze(PRECISION((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_TimeWindow,(squeeze(FOR_all((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure2,method)
end 

%% SPECIFICITY & FALSE NEGATIVE RATE
title_figure1='Specificity'
title_figure2='FNR'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_TimeWindow,(squeeze(SPECIFICITY((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_TimeWindow,(squeeze(FN_rate_all((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure2,method)
end 
%% NEGATIVE PREDICTIVE VALUE & FALSE DISCOVERY RATE
FDR_ALL=FDR_all;
title_figure1='NPV'
title_figure2='FDR'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_TimeWindow,(squeeze(NPV_all((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_TimeWindow,(squeeze(FDR_ALL((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure2,method)
end 

%% EFFICIENCY & ACCURACY 
title_figure1='Efficiency'
title_figure2='Accuracy'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_TimeWindow,(squeeze(EFF((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MAXIMIZE(ax2,list_TimeWindow,(squeeze(ACCURACY((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure2,method)
end 

%% F1 SCORE && MATTHEWS CORRELATION COEFFICIENT 
title_figure1='F1Score'
title_figure2='MCC'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_TimeWindow,(squeeze(F1_SCORE((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MCC(ax2,list_TimeWindow,(squeeze(MCC_all((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure2,method)
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SINGLE UNIT 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5%%%%
%% DETECTION 
timestamps_found_all=cell(length(list_parameter),length(list_TimeWindow),length(list_snr));
path_to_signal='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\SINGLE UNIT V2\'
for i=1:length(list_snr)
    load([path_to_signal 'snr_' num2str(list_snr(i)) '.mat']);
    for j=1:length(list_parameter)
        disp(['snr ' num2str(i) ' ,param: ' num2str(j)])
        for k=1:length(list_TimeWindow)
            tic;
            [timestamps_found,soglia,rp]=atlm(signal,list_parameter(j),list_TimeWindow(k));
            timestamps_found_all{j,k,i}=timestamps_found;
            soglia_all{j,k,i}=soglia;
            elapsed_time(j,k,i)=toc;
        end
    end
end
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\ATLM ANALISI\ATLM\SINGLE UNIT V2\timestamps_found_all.mat'],'timestamps_found_all','elapsed_time','soglia_all','list_parameter','list_TimeWindow');
%% load locations
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Distribuzioni\1\ig_matrix1.mat')
loc_spikeSU=find(invgau_matrix.spikeTrain(87,:)); 

%% Create roc and isolate Efficiencies
% EFF=zeros(length(list_snr),length(list_parameter),length(list_TimeWindow));
% eff=zeros(length(list_parameter),length(list_TimeWindow));
% TP=zeros(length(list_parameter),length(list_TimeWindow));
% FP=zeros(length(list_parameter),length(list_TimeWindow));
% TP_all=zeros(length(list_snr),length(list_parameter),length(list_TimeWindow));
% FP_all=zeros(length(list_snr),length(list_parameter),length(list_TimeWindow));
for i=1:length(list_snr)
    for j=1:length(list_parameter)
        for k=1:length(list_TimeWindow)
            analysis_atlm= signal_analysis_single_unit((timestamps_found_all{j,k,i}),invgau_matrix,signal);
            eff(j,k)=analysis_atlm.eff;
            TP(j,k)=analysis_atlm.tp;
            FP(j,k)=analysis_atlm.fp;
            TN(j,k)=analysis_atlm.tn;
            FN(j,k)=analysis_atlm.fn;
            Sensitivity(j,k)=analysis_atlm.sensitivity;
            Specificity(j,k)=analysis_atlm.specificity;
            FN_rate(j,k)=analysis_atlm.FN_rate;
            FP_rate(j,k)=analysis_atlm.FP_rate;
            FDR(j,k)=analysis_atlm.false_discovery_rate;
            accuracy(j,k)=analysis_atlm.accuracy;
            F1_score(j,k)=analysis_atlm.F1_score;
            precision(j,k)=analysis_atlm.precision;
            FOR(j,k)=analysis_atlm.FOR;
            MCC(j,k)=analysis_atlm.MCC;
            git{j,k,:}=analysis_atlm.git;
            NPV(j,k)=analysis_atlm.NPV;
            TS_TP{j,k,:}=analysis_atlm.TS_tp;
            TS_TP_from_model{j,k,:}=analysis_atlm.TS_tp_from_model;
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
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\ATLM ANALISI\ATLM\SINGLE UNIT V2\ANALYSIS.mat'],'TP_all','FP_all','EFF','list_parameter','list_snr','TN_all','FN_all','SPECIFICITY','SENSITIVITY','PRECISION','GIT_all','FOR_all','FN_rate_all','FP_rate_all','MCC_all','FDR_all','F1_SCORE','ACCURACY','NPV_all','TS_TP_all','TS_TP_FROM_MODEL_all')
%%
method='ATLM';
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
    makeFig_MAXIMIZE(ax,list_TimeWindow,(squeeze(SENSITIVITY((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_TimeWindow,(squeeze(FP_rate_all((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure2,method)
end 
%% PRECISION & FALSE OMISSION RATE
title_figure1='Precision'
title_figure2='FOR'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_TimeWindow,(squeeze(PRECISION((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_TimeWindow,(squeeze(FOR_all((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure2,method)
end 

%% SPECIFICITY & FALSE NEGATIVE RATE
title_figure1='Specificity'
title_figure2='FNR'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_TimeWindow,(squeeze(SPECIFICITY((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_TimeWindow,(squeeze(FN_rate_all((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure2,method)
end 
%% NEGATIVE PREDICTIVE VALUE & FALSE DISCOVERY RATE
FDR_ALL=FDR_all;
title_figure1='NPV'
title_figure2='FDR'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_TimeWindow,(squeeze(NPV_all((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_TimeWindow,(squeeze(FDR_ALL((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure2,method)
end 

%% EFFICIENCY & ACCURACY 
title_figure1='Efficiency'
title_figure2='Accuracy'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_TimeWindow,(squeeze(EFF((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MAXIMIZE(ax2,list_TimeWindow,(squeeze(ACCURACY((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure2,method)
end 

%% F1 SCORE && MATTHEWS CORRELATION COEFFICIENT 
title_figure1='F1Score'
title_figure2='MCC'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_TimeWindow,(squeeze(F1_SCORE((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MCC(ax2,list_TimeWindow,(squeeze(MCC_all((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure2,method)
end 
%% CHECK
% ts_tw1=round(timestamps_found_all{1,1,5});
% ts_tw2=(timestamps_found_all{1,2,5});
% ts_tw3=(timestamps_found_all{1,3,5});
% ts_tw4=round(timestamps_found_all{1,4,5});

% sig=signal;
% sig_snr1=signal;
% sig_snr2=signal;
% sig_snr3=signal;
% sig_snr4=signal;
% figure(1)
% h(1)=subplot(141) ,plot(sig),hold on, plot(ts_tw1,sig(ts_tw1),'*r'), title('snr 0.5')
% h(2)=subplot(142) ,plot(sig),hold on, plot(ts_tw2,sig(ts_tw2),'*r'), title('snr 0.8')
% h(3)=subplot(143) ,plot(sig),hold on, plot(ts_tw3,sig(ts_tw3),'*r'), title('snr 0.16')
% h(4)=subplot(144) ,plot(sig),hold on, plot(ts_tw4,sig(ts_tw4),'*r'), title('snr 0.16')
% linkaxes(h,'xy')
% %%
% soglie_snr2=soglia_all(:,:,2);
% soglie_snr1=soglia_all(:,:,1);
% soglie_snr3=soglia_all(:,:,3);
% soglie_snr4=soglia_all(:,:,4);

% for i=1:4
% %     ts_tw1=timestamps_found_all{5,i,5};
%     p=soglia_all{5,i,5}
%     t=list_TimeWindow(i)/2:list_TimeWindow(i):(60*24414)-list_TimeWindow(i);
%     figure(1) 
%     plot(t,p), hold on
% end 
%  %%
% tp_tw1=TS_TP_all{5,1,1};
% tp_tw2=TS_TP_all{5,1,2};
% tp_tw3=TS_TP_all{5,1,3};
% tp_tw4=TS_TP_all{5,1,4};
% 
% ts_tw1=round(timestamps_found_all{1,1,5});
% ts_tw2=round(timestamps_found_all{1,2,5});
% ts_tw3=round(timestamps_found_all{1,3,5});
% ts_tw4=round(timestamps_found_all{1,4,5});
% 
% figure
% subplot 141, plot(sig), hold on, plot(ts_tw1,sig(ts_tw1),'*r'), plot(tp_tw1,sig(tp_tw1),'g*')
% subplot 142, plot(sig), hold on, plot(ts_tw2,sig(ts_tw2),'*r'), plot(tp_tw2,sig(tp_tw2),'g*')
% subplot 143, plot(sig), hold on, plot(ts_tw3,sig(ts_tw3),'*r'), plot(tp_tw3,sig(tp_tw3),'g*')
% subplot 144, plot(sig), hold on, plot(ts_tw4,sig(ts_tw4),'*r'), plot(tp_tw4,sig(tp_tw4),'g*')