clc, clear all, close all

%%
param1=1;
param2=10;
plp1=0.5;
plp2=2.5;
list_parameter=linspace(param1,param2,10);
list_PLP=linspace(plp1,plp2,5).*1e-3;
% peakDuration=floor(PLP*24414);
refrTime=24;
alignmentFlag=1;
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
list_snr=SNR_param(:,1);
%%
%% run ptsd_for_runnin_parameters for all parameters
timestamps_found_all=cell(length(list_parameter),length(list_PLP),length(list_snr));
list_rumori=1:10;
path_to_signal='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\SIGNAL V2\'
for i=1:length(list_snr)
    load([path_to_signal 'snr_' num2str(list_snr(i)) '.mat']);
    for j=1:length(list_parameter)
        disp(['snr ' num2str(i) ' ,param: ' num2str(j)])
        noise_filt=load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\N' num2str(list_rumori(i)) '\N' num2str(list_rumori(i)) '_FilteredData\N' num2str(list_rumori(i)) '_Mat_Files\' num2str(list_rumori(i)) '\noise.mat']);
        thresh_vector=std(noise_filt.data)*list_parameter(j);
        for k=1:length(list_PLP)
            peakDuration=floor(list_PLP(k)*24414);
            tic;
            [spkValues,timestamps_found] =  SpikeDetection_PTSD_core_matlab_modified_v2(signal,-thresh_vector, peakDuration, refrTime, alignmentFlag);
            timestamps_found_all{j,k,i}=timestamps_found;
            elapsed_time(j,k,i)=toc;
        end
        TV(j,i)=-thresh_vector;
    end
end
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD MODIFICATO ANALISI\PTSD MODIFICATO\MULTI UNIT\timestamps_found_all_andtime.mat'],'timestamps_found_all','elapsed_time','-v7.3')
%% load locations MU
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Multi-unit\Distribuzione 1\S1\loc_spike_s1.mat')
%% load location SU
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Distribuzioni\1\ig_matrix1.mat')
loc_spikeSU=find(invgau_matrix.spikeTrain(87,:)); 

%% load saved timestamps SNR 
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\SIGNAL V2\snr_0.5711.mat')
for i=1:length(list_snr)
    for j=1:length(list_parameter)
        for k=1:length(list_PLP)
            now=timestamps_found_all{j,k,i};
            ts=find(now);
            TS=now(1:length(ts));
            analysis_ptsdMod= signal_analysis_multi_unit(TS,loc_spike_s1,signal);
            eff(j,k)=analysis_ptsdMod.eff;
            TP(j,k)=analysis_ptsdMod.tp;
            FP(j,k)=analysis_ptsdMod.fp;
            TN(j,k)=analysis_ptsdMod.tn;
            FN(j,k)=analysis_ptsdMod.fn;
            Sensitivity(j,k)=analysis_ptsdMod.sensitivity;
            Specificity(j,k)=analysis_ptsdMod.specificity;
            FN_rate(j,k)=analysis_ptsdMod.FN_rate;
            FP_rate(j,k)=analysis_ptsdMod.FP_rate;
            FDR(j,k)=analysis_ptsdMod.false_discovery_rate;
            accuracy(j,k)=analysis_ptsdMod.accuracy;
            F1_score(j,k)=analysis_ptsdMod.F1_score;
            precision(j,k)=analysis_ptsdMod.precision;
            FOR(j,k)=analysis_ptsdMod.FOR;
            MCC(j,k)=analysis_ptsdMod.MCC;
            git{j,k,:}=analysis_ptsdMod.git;
            NPV(j,k)=analysis_ptsdMod.NPV;
            TS_TP{j,k,:}=analysis_ptsdMod.TS_tp;
            TS_TP_from_model{j,k,:}=analysis_ptsdMod.TS_tp_from_model;
            clear analysis_ptsd now TS ts
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

save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD MODIFICATO ANALISI\PTSD MODIFICATO\MULTI UNIT\ANALYSIS.mat'],'TP_all','FP_all','EFF','list_parameter','list_snr','TN_all','FN_all','SPECIFICITY','SENSITIVITY','PRECISION','GIT_all','FOR_all','FN_rate_all','FP_rate_all','MCC_all','FDR_all','F1_SCORE','ACCURACY','NPV_all','TS_TP_all','TS_TP_FROM_MODEL_all','-v7.3')

%% PLOTS 
method='PTSD';
%% EFFICIENCY 
title='Efficiency'
for l=1:length(list_snr)
    ax=subplot(5,2,l)
    makeFig_MAXIMIZE(ax,list_PLP.*1e3,(squeeze(EFF(l,:,:))),list_parameter,list_snr(l),title, method);
    
end 
%% ACCURACY  
title='Accuracy';
figure(1)
for l=1:length(list_snr)
    ax=subplot(5,2,l)
    makeFig_MAXIMIZE(ax,list_PLP.*1e3,(squeeze(ACCURACY(l,:,:))),list_parameter,list_snr(l),title, method);
end 

%% PRECISION  
title='Precision';
figure(1)
for l=1:length(list_snr)
    ax=subplot(5,2,l)
    makeFig_MAXIMIZE(ax,list_PLP.*1e3,(squeeze(PRECISION(l,:,:))),list_parameter,list_snr(l),title, method);
end 
%% SENSITIVITY

figure(1)
for l=1:length(list_snr)
    title=list_snr(l);
    ax=subplot(5,2,l)
    makeFig_MAXIMIZE(ax,list_PLP.*1e3,(squeeze(SENSITIVITY(l,:,:))),list_parameter,list_snr(l),title, method);
end 
%% SPECIFICITY
title='Specificity';
figure(1)
for l=1:length(list_snr)
    ax=subplot(5,2,l)
    makeFig_MAXIMIZE(ax,list_PLP.*1e3,(squeeze(SPECIFICITY(l,:,:))),list_parameter,list_snr(l),title, method);
end 
%% FPR
title='FPR';
figure(1)
for l=1:length(list_snr)
    ax=subplot(5,2,l)
    makeFig_MINIMIZE(ax,list_PLP.*1e3,(squeeze(FP_rate_all(l,:,:))),list_parameter,list_snr(l),title, method);
end 
%% FNR
title='FNR';
figure(1)
for l=1:length(list_snr)
    ax=subplot(5,2,l)
    makeFig_MINIMIZE(ax,list_PLP.*1e3,(squeeze(FN_rate_all(l,:,:))),list_parameter,list_snr(l),title, method);
end 
%% MCC
title='MCC';
figure(1)
for l=1:length(list_snr)
    ax=subplot(5,2,l)
    makeFig_MCC(ax,list_PLP.*1e3,(squeeze(MCC_all(l,:,:))),list_parameter,list_snr(l),title, method);
end 
%% FDR
title='FDR';
figure(1)
for l=1:length(list_snr)
    ax=subplot(5,2,l)
    makeFig_MINIMIZE(ax,list_PLP.*1e3,(squeeze(FDR_all(l,:,:))),list_parameter,list_snr(l),title, method);
end 
%% NPV
title='NPV';
figure(1)
for l=1:length(list_snr)
    ax=subplot(5,2,l)
    makeFig_MAXIMIZE(ax,list_PLP.*1e3,(squeeze(NPV_all(l,:,:))),list_parameter,list_snr(l),title, method);
end 
%% FOR
title='FOR';
figure(1)
for l=1:length(list_snr)
    ax=subplot(5,2,l)
    makeFig_MINIMIZE(ax,list_PLP.*1e3,(squeeze(FOR_all(l,:,:))),list_parameter,list_snr(l),title, method);
end 
%% F1 SCORE
title='F1 Score';
figure(1)
for l=1:length(list_snr)
    ax=subplot(5,2,l)
    makeFig_MAXIMIZE(ax,list_PLP.*1e3,(squeeze(F1_SCORE(l,:,:))),list_parameter,list_snr(l),title, method);
end 
%%

%%
method='PTSD';
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
    makeFig_MAXIMIZE(ax,list_PLP.*1e3,(squeeze(SENSITIVITY((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_PLP.*1e3,(squeeze(FP_rate_all((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure2,method)
end 
%% PRECISION & FALSE OMISSION RATE
title_figure1='Precision'
title_figure2='FOR'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_PLP.*1e3,(squeeze(PRECISION((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_PLP.*1e3,(squeeze(FOR_all((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure2,method)
end 

%% SPECIFICITY & FALSE NEGATIVE RATE
title_figure1='Specificity'
title_figure2='FNR'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_PLP.*1e3,(squeeze(SPECIFICITY((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_PLP.*1e3,(squeeze(FN_rate_all((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure2,method)
end 
%% NEGATIVE PREDICTIVE VALUE & FALSE DISCOVERY RATE
FDR_ALL=FDR_all;
title_figure1='NPV'
title_figure2='FDR'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_PLP.*1e3,(squeeze(NPV_all((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MINIMIZE(ax2,list_PLP.*1e3,(squeeze(FDR_ALL((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure2,method)
end 

%% EFFICIENCY & ACCURACY 
title_figure1='Efficiency'
title_figure2='Accuracy'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_PLP.*1e3,(squeeze(EFF((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MAXIMIZE(ax2,list_PLP.*1e3,(squeeze(ACCURACY((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure2,method)
end 

%% F1 SCORE && MATTHEWS CORRELATION COEFFICIENT 
title_figure1='F1Score'
title_figure2='MCC'
for l=1:length(chosen_snr)
    ax=subplot(3,2,l*2-1)
    makeFig_MAXIMIZE(ax,list_PLP.*1e3,(squeeze(F1_SCORE((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure1,method)
    ax2=subplot(3,2,l*2)
    makeFig_MCC(ax2,list_PLP.*1e3,(squeeze(MCC_all((list_snr==chosen_snr(l)),:,:))),list_parameter,list_snr(l),title_figure2,method)
end 

%% GRAFICO ALTERNATIVO EFFICIENCY 
%% EFFICIENCY 
for l=1:length(list_PLP)
    figure(l)
    EFFL=EFF(:,:,l);
   imagesc(squeeze(EFFL(:,:)))
   xlabel('MultCoeff'), ylabel('Level SNR') 
   caxis([0 1]), colorbar
%    title(['Efficiency, PLP = ' num2str(list_PLP(l),'%1.2f')])

end  
