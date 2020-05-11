clc, clear all, close all
%%
% PLP=2;  %ms default
RP=1; %ms
DMdpolar=1;
fs=24414;
w_pre=12;
w_post=16;
%%
param1=3;
param2=16;
% param1=4;
% param2=9;
plp1=0.5;
plp2=2.5;
list_parameter=linspace(param1,param2,10);
list_PLP=linspace(plp1,plp2,5);
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
list_snr=SNR_param(:,1);
%%
%% run ptsd_for_runnin_parameters for the first half parameters
timestamps_found_all=cell(length(list_parameter),length(list_PLP),length(list_snr)/2);
list_rumori=1:10;
path_to_signal='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\SINGLE UNIT V2\easy\'
for i=1:length(list_snr)/2
    load([path_to_signal 'snr_' num2str(list_snr(i)) '.mat']);
    for j=1:length(list_parameter)
        disp(['snr ' num2str(i) ' ,param: ' num2str(j)])
        noise_filt=load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\N' num2str(list_rumori(i)) '\N' num2str(list_rumori(i)) '_FilteredData\N' num2str(list_rumori(i)) '_Mat_Files\' num2str(list_rumori(i)) '\noise.mat']);
        thresh_vector=std(noise_filt.data)*list_parameter(j);
        for k=1:length(list_PLP)
            tic;
            [timestamps_found,dthresh]=ptsd_for_running_parameters(signal,thresh_vector,fs,w_pre,w_post,DMdpolar,list_PLP(k),RP);
            timestamps_found_all{j,k,i}=timestamps_found;
            elapsed_time(j,k,i)=toc;
        end
    end
end
% mkdir(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\SINGLE UNIT V2\'])
%SINGLE UNIT V2\easy\PARAMETRO 1-20
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\MULTI UNIT V2\timestamps_firstHalf_all_andtime.mat'],'timestamps_found_all','elapsed_time', '-v7.3')

% clear timestamps_found_all
%% Second half of parameters
path_to_signal='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\SINGLE UNIT V2\'
timestamps_found_all=cell(length(list_parameter),length(list_PLP),length(list_snr)/2);
list_rumori=1:10;

for i=1:length(list_snr)/2
    load([path_to_signal 'snr_' num2str(list_snr(i+5)) '.mat']);
    for j=1:length(list_parameter)
        disp(['snr ' num2str(i+5) ' ,param: ' num2str(j)])
        noise_filt=load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\N' num2str(list_rumori(i+5)) '\N' num2str(list_rumori(i+5)) '_FilteredData\N' num2str(list_rumori(i+5)) '_Mat_Files\' num2str(list_rumori(i+5)) '\noise.mat']);
        thresh_vector=std(noise_filt.data)*list_parameter(j);
        for k=1:length(list_PLP)
            tic;
            [timestamps_found,dthresh]=ptsd_for_running_parameters(signal,thresh_vector,fs,w_pre,w_post,DMdpolar,list_PLP(k),RP);
            timestamps_found_all{j,k,i}=timestamps_found;
            elapsed_time(j,k,i)=toc;
        end
    end
end
% save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\SINGLE UNIT V2\easy\timestamps_secondoHalf_all_andtime.mat'],'timestamps_found_all','elapsed_time', '-v7.3')

%%
% timestamps_found_all_SNR_n1=cell(length(list_parameter),length(list_PLP));
% timestamps_found_all_SNR_n2=cell(length(list_parameter),length(list_PLP));
% timestamps_found_all_SNR_n3=cell(length(list_parameter),length(list_PLP));
% timestamps_found_all_SNR_n4=cell(length(list_parameter),length(list_PLP));
% timestamps_found_all_SNR_n5=cell(length(list_parameter),length(list_PLP));

% %%
% timestamps_found_all_SNR_n6=cell(length(list_parameter),length(list_PLP));
% timestamps_found_all_SNR_n7=cell(length(list_parameter),length(list_PLP));
% timestamps_found_all_SNR_n8=cell(length(list_parameter),length(list_PLP));
% timestamps_found_all_SNR_n9=cell(length(list_parameter),length(list_PLP));
% timestamps_found_all_SNR_n10=cell(length(list_parameter),length(list_PLP));
% %%
% 
% timestamps_found_all_SNR_n1=timestamps_found_all(:,:,1);
% timestamps_found_all_SNR_n2=timestamps_found_all(:,:,2);
% timestamps_found_all_SNR_n3=timestamps_found_all(:,:,3);
% timestamps_found_all_SNR_n4=timestamps_found_all(:,:,4);
% timestamps_found_all_SNR_n5=timestamps_found_all(:,:,5);
% %%
% timestamps_found_all_SNR_n6=timestamps_found_all(:,:,1);
% timestamps_found_all_SNR_n7=timestamps_found_all(:,:,2);
% timestamps_found_all_SNR_n8=timestamps_found_all(:,:,3);
% timestamps_found_all_SNR_n9=timestamps_found_all(:,:,4);
% timestamps_found_all_SNR_n10=timestamps_found_all(:,:,5);

%% load locations
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Distribuzioni\1\ig_matrix1.mat')
loc_spikeSU=find(invgau_matrix.spikeTrain(87,:)); 
%% FIRST HALF
for i=1:length(list_snr)/2
    for j=1:length(list_parameter)
        for k=1:length(list_PLP)
            analysis_ptsd= PTSD_signal_analysis_single_unit((timestamps_found_all{j,k,i}),invgau_matrix,signal);
            eff(j,k)=analysis_ptsd.eff;
            TP(j,k)=analysis_ptsd.tp;
            FP(j,k)=analysis_ptsd.fp;
            TN(j,k)=analysis_ptsd.tn;
            FN(j,k)=analysis_ptsd.fn;
            Sensitivity(j,k)=analysis_ptsd.sensitivity;
            Specificity(j,k)=analysis_ptsd.specificity;
            FN_rate(j,k)=analysis_ptsd.FN_rate;
            FP_rate(j,k)=analysis_ptsd.FP_rate;
            FDR(j,k)=analysis_ptsd.false_discovery_rate;
            accuracy(j,k)=analysis_ptsd.accuracy;
            F1_score(j,k)=analysis_ptsd.F1_score;
            precision(j,k)=analysis_ptsd.precision;
            FOR(j,k)=analysis_ptsd.FOR;
            MCC(j,k)=analysis_ptsd.MCC;
            git{j,k,:}=analysis_ptsd.git;
            NPV(j,k)=analysis_ptsd.NPV;
            TS_TP{j,k,:}=analysis_ptsd.TS_tp;
            TS_TP_from_model{j,k,:}=analysis_ptsd.TS_tp_from_model;
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
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\MULTI UNIT V2\ANALYSIS_firstHalf.mat'],'TP_all','FP_all','EFF','list_parameter','list_snr','TN_all','FN_all','SPECIFICITY','SENSITIVITY','PRECISION','GIT_all','FOR_all','FN_rate_all','FP_rate_all','MCC_all','FDR_all','F1_SCORE','ACCURACY','NPV_all','TS_TP_all','TS_TP_FROM_MODEL_all')
%% SECOND HALF 
for i=1:length(list_snr)/2
    for j=1:length(list_parameter)
        for k=1:length(list_PLP)
            analysis_ptsd= PTSD_signal_analysis_single_unit((timestamps_found_all{j,k,i}),invgau_matrix,signal);
            eff2(j,k)=analysis_ptsd.eff;
            TP2(j,k)=analysis_ptsd.tp;
            FP2(j,k)=analysis_ptsd.fp;
            TN2(j,k)=analysis_ptsd.tn;
            FN2(j,k)=analysis_ptsd.fn;
            Sensitivity2(j,k)=analysis_ptsd.sensitivity;
            Specificity2(j,k)=analysis_ptsd.specificity;
            FN_rate2(j,k)=analysis_ptsd.FN_rate;
            FP_rate2(j,k)=analysis_ptsd.FP_rate;
            FDR2(j,k)=analysis_ptsd.false_discovery_rate;
            accuracy2(j,k)=analysis_ptsd.accuracy;
            F1_score2(j,k)=analysis_ptsd.F1_score;
            precision2(j,k)=analysis_ptsd.precision;
            FOR2(j,k)=analysis_ptsd.FOR;
            MCC2(j,k)=analysis_ptsd.MCC;
            git2{j,k,:}=analysis_ptsd.git;
            NPV2(j,k)=analysis_ptsd.NPV;
            TS_TP2{j,k,:}=analysis_ptsd.TS_tp;
            TS_TP_from_model2{j,k,:}=analysis_ptsd.TS_tp_from_model;
            clear analysis
        end
    end
    TP_all2(i,:,:)=TP2;
    FP_all2(i,:,:)=FP2;
    EFF2(i,:,:)=eff2;
    TN_all2(i,:,:)=TN2;
    FN_all2(i,:,:)=FN2;
    SENSITIVITY2(i,:,:)=Sensitivity2;
    SPECIFICITY2(i,:,:)=Specificity2;
    FN_rate_all2(i,:,:)=FN_rate2;
    FP_rate_all2(i,:,:)=FP_rate2;
    FDR_all2(i,:,:)=FDR2;
    ACCURACY2(i,:,:)=accuracy2;
    F1_SCORE2(i,:,:)=F1_score2;
    PRECISION2(i,:,:)=precision2;
    FOR_all2(i,:,:)=FOR2;
    MCC_all2(i,:,:)=MCC2;
    GIT_all2(i,:,:)=git2;
    NPV_all2(i,:,:)=NPV2;
    TS_TP_all2(i,:,:)=TS_TP2;
    TS_TP_FROM_MODEL_all2(i,:,:)=TS_TP_from_model2;
end
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\SINGLE UNIT V2\easy\PARAMETRO 1-20\ANALYSIS_secondHalf.mat'],'TP_all2','FP_all2','EFF2','list_parameter','list_snr','TN_all2','FN_all2','SPECIFICITY2','SENSITIVITY2','PRECISION2','GIT_all2','FOR_all2','FN_rate_all2','FP_rate_all2','MCC_all2','FDR_all2','F1_SCORE2','ACCURACY2','NPV_all2','TS_TP_all2','TS_TP_FROM_MODEL_all2')

%%
method='PTSD';
%% PLOTS FIRST HALF
high=list_snr(1);
mid=list_snr(5);
low=list_snr(10);
chosen_snr=[high, mid];
%% SENSITIVITY & FPR
index_name='Sensitivity';
index_name2='FPR';
title_figure1=[0.86 0.29];
figure(1)
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_PLP,(squeeze(SENSITIVITY((list_snr==chosen_snr(l)),:,:))),list_parameter,index_name,title_figure1(l),method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_PLP,(squeeze(FP_rate_all((list_snr==chosen_snr(l)),:,:))),list_parameter,index_name2,title_figure1(l),method)
end 
title_figure3='0.16';
ax3=subplot(3,2,5)
makeFig_MAXIMIZE(ax3,list_PLP,(squeeze(SENSITIVITY2(5,:,:))),list_parameter,index_name,title_figure3,method)
ax4=subplot(3,2,6)
makeFig_MINIMIZE(ax4,list_PLP,(squeeze(FP_rate_all2(5,:,:))),list_parameter,index_name2,title_figure3,method)
%% PRECISION & FALSE OMISSION RATE
index_name='Precision';
index_name2='FOR';
title_figure1=[0.86 0.29];
figure(1)
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_PLP,(squeeze(PRECISION((list_snr==chosen_snr(l)),:,:))),list_parameter,index_name,title_figure1(l),method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_PLP,(squeeze(FOR_all((list_snr==chosen_snr(l)),:,:))),list_parameter,index_name2,title_figure1(l),method)
end 
title_figure3='0.16';
ax3=subplot(3,2,5)
makeFig_MAXIMIZE(ax3,list_PLP,(squeeze(PRECISION2(5,:,:))),list_parameter,index_name,title_figure3,method)
ax4=subplot(3,2,6)
makeFig_MINIMIZE(ax4,list_PLP,(squeeze(FOR_all2(5,:,:))),list_parameter,index_name2,title_figure3,method)

%% SPECIFICITY & FALSE NEGATIVE RATE
index_name='Specificity';
index_name2='FNR';
title_figure1=[0.86 0.29];
figure(1)
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_PLP,(squeeze(SPECIFICITY((list_snr==chosen_snr(l)),:,:))),list_parameter,index_name,title_figure1(l),method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_PLP,(squeeze(FN_rate_all((list_snr==chosen_snr(l)),:,:))),list_parameter,index_name2,title_figure1(l),method)
end 
title_figure3='0.16';
ax3=subplot(3,2,5)
makeFig_MAXIMIZE(ax3,list_PLP,(squeeze(SPECIFICITY2(5,:,:))),list_parameter,index_name,title_figure3,method)
ax4=subplot(3,2,6)
makeFig_MINIMIZE(ax4,list_PLP,(squeeze(FN_rate_all2(5,:,:))),list_parameter,index_name2,title_figure3,method)

%% NEGATIVE PREDICTIVE VALUE & FALSE DISCOVERY RATE
FDR_ALL=FDR_all;
index_name='NPV';
index_name2='FDR';
title_figure1=[0.86 0.29];
figure(1)
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_PLP,(squeeze(NPV_all((list_snr==chosen_snr(l)),:,:))),list_parameter,index_name,title_figure1(l),method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_PLP,(squeeze(FDR_all((list_snr==chosen_snr(l)),:,:))),list_parameter,index_name2,title_figure1(l),method)
end 
title_figure3='0.16';
ax3=subplot(3,2,5)
makeFig_MAXIMIZE(ax3,list_PLP,(squeeze(NPV_all2(5,:,:))),list_parameter,index_name,title_figure3,method)
ax4=subplot(3,2,6)
makeFig_MINIMIZE(ax4,list_PLP,(squeeze(FDR_all2(5,:,:))),list_parameter,index_name2,title_figure3,method)

%% EFFICIENCY & ACCURACY 
index_name='Efficiency';
index_name2='Accuracy';
title_figure1=[0.86 0.29];
figure(1)
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_PLP,(squeeze(EFF((list_snr==chosen_snr(l)),:,:))),list_parameter,index_name,title_figure1(l),method)
    ax2=subplot(3,2,l*2)
    makeFig_MAXIMIZE(ax2,list_PLP,(squeeze(ACCURACY((list_snr==chosen_snr(l)),:,:))),list_parameter,index_name2,title_figure1(l),method)
end 
title_figure3='0.16';
ax3=subplot(3,2,5)
makeFig_MAXIMIZE(ax3,list_PLP,(squeeze(EFF2(5,:,:))),list_parameter,index_name,title_figure3,method)
ax4=subplot(3,2,6)
makeFig_MAXIMIZE(ax4,list_PLP,(squeeze(ACCURACY2(5,:,:))),list_parameter,index_name2,title_figure3,method)

%% F1 SCORE && MATTHEWS CORRELATION COEFFICIENT 
index_name='F1 Score';
index_name2='MCC';
title_figure1=[0.86 0.29];
figure(1)
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_PLP,(squeeze(F1_SCORE((list_snr==chosen_snr(l)),:,:))),list_parameter,index_name,title_figure1(l),method)
    ax2=subplot(3,2,l*2)
    makeFig_MCC(ax2,list_PLP,(squeeze(MCC_all((list_snr==chosen_snr(l)),:,:))),list_parameter,index_name2,title_figure1(l),method)
end 
title_figure3='0.16';
ax3=subplot(3,2,5)
makeFig_MAXIMIZE(ax3,list_PLP,(squeeze(F1_SCORE2(5,:,:))),list_parameter,index_name,title_figure3,method)
ax4=subplot(3,2,6)
makeFig_MCC(ax4,list_PLP,(squeeze(MCC_all2(5,:,:))),list_parameter,index_name2,title_figure3,method)


