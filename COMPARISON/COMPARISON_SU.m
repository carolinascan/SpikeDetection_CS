clc, clear all, close all
%% HT
ANALISI_HT=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\HT\SINGLE UNIT V2\ANALYSIS.mat');
%% HTLM
ANALISI_HTLM= load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HTLM ANALISI\HTLM\SINGLE UNIT V2\ANALYSIS.mat');
%% ATLM
ANALISI_ATLM=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\ATLM ANALISI\ATLM\SINGLE UNIT V2\ANALYSIS.mat');
%% PTSD
ANALISI_PTSD_FIRST= load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\SINGLE UNIT V2\ANALYSIS_firstHalf.mat');
ANALISI_PTSD_SECOND=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\SINGLE UNIT V2\ANALYSIS_secondHalf.mat');
%% SWTTEO
ANALISI_SWTTEO=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SWTTEO ANALISI\SWTTEO\SINGLE UNIT V2\ANALYSIS.mat');
%% SNEO
ANALISI_SNEO=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SNEO ANALISI\SNEO\SINGLE UNIT V2\ANALYSIS.mat');
%% TIFCO
ANALISI_TIFCO=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\TIFCO\SINGLE UNIT V2\ANALYSIS.mat');
%% PTSD MODIFIED
ANALISI_PTSDMOD= load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD MODIFICATO ANALISI\PTSD MODIFICATO\PARAMETRO 1-20\SINGLE UNIT\ANALYSIS.mat');
%% SENSITIVITY
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
list_snr=SNR_param(:,1);
for i=1:5
    level_snr=i;
    snr_title=list_snr(level_snr); level_window=5;
    sensitivity_ht=ANALISI_HT.SENSITIVITY(level_snr,:);
    sensitivity_htlm=ANALISI_HTLM.SENSITIVITY(level_snr,:);
    sensitivity_atlm=ANALISI_ATLM.SENSITIVITY(level_snr,:,level_window);
    sensitivity_ptsd=ANALISI_PTSD_FIRST.SENSITIVITY(level_snr,:,level_window);
    sensitivity_ptsdMod=ANALISI_PTSDMOD.SENSITIVITY(level_snr,1:10,level_window);
    sensitivity_swtteo=ANALISI_SWTTEO.SENSITIVITY(level_snr,:);
    sensitivity_tifco=ANALISI_TIFCO.SENSITIVITY(level_snr,:);
    sensitivity_sneo=ANALISI_SNEO.SENSITIVITY(level_snr,:,level_window);
    SENS=[sensitivity_ht; sensitivity_htlm;sensitivity_atlm;sensitivity_ptsd;sensitivity_ptsdMod;sensitivity_swtteo;sensitivity_tifco;sensitivity_sneo ];
    SENSALL{i,:}=SENS;
    figure
    b=imagesc(SENS(:,:)),
    set(b,'AlphaData',~isnan(SENS))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['Sensitivity Level SNR ', num2str(snr_title,'%1.2f')])
end
for j=1:5
    level_snr=j;
    snr_title=list_snr(level_snr+5); level_window=5;
    sensitivity_ht=ANALISI_HT.SENSITIVITY(level_snr+5,:);
    sensitivity_htlm=ANALISI_HTLM.SENSITIVITY(level_snr+5,:);
    sensitivity_atlm=ANALISI_ATLM.SENSITIVITY(level_snr+5,:,level_window);
    sensitivity_ptsd=ANALISI_PTSD_SECOND.SENSITIVITY2(level_snr,:,level_window);
    sensitivity_swtteo=ANALISI_SWTTEO.SENSITIVITY(level_snr+5,:);
    sensitivity_tifco=ANALISI_TIFCO.SENSITIVITY(level_snr+5,:);
    sensitivity_sneo=ANALISI_SNEO.SENSITIVITY(level_snr+5,:,level_window);
    sensitivity_ptsdMod=ANALISI_PTSDMOD.SENSITIVITY(level_snr+5,1:10,level_window);
    SENS=[sensitivity_ht; sensitivity_htlm;sensitivity_atlm;sensitivity_ptsd;sensitivity_swtteo;sensitivity_tifco;sensitivity_sneo; sensitivity_ptsdMod];
    SENSALL2{j,:}=SENS;
    figure
    b=imagesc(SENS(:,:)), set(b,'AlphaData',~isnan(SENS))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','SWTTEO','TIFCO','SNEO','PTSDmod'})
    xlabel('Number of multCoeff used'), title(['Sensitivity Level SNR ',num2str(snr_title,'%1.2f')])
end
%% EFFICIENCY
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
list_snr=SNR_param(:,1);
for i=1:5
    level_snr=i;
    snr_title=list_snr(level_snr);
    level_window=5;
    efficiency_ht=ANALISI_HT.EFF(level_snr,:);
    efficiency_htlm=ANALISI_HTLM.EFF(level_snr,:);
    efficiency_atlm=ANALISI_ATLM.EFF(level_snr,:,level_window);
    efficiency_ptsd=ANALISI_PTSD_FIRST.EFF(level_snr,:,level_window);
    efficiency_ptsdMod=ANALISI_PTSDMOD.EFF(level_snr,1:10,level_window);
    efficiency_swtteo=ANALISI_SWTTEO.EFF(level_snr,:);
    efficiency_tifco=ANALISI_TIFCO.EFF(level_snr,:);
    efficiency_sneo=ANALISI_SNEO.EFF(level_snr,:,level_window);
    EFF=[efficiency_ht; efficiency_htlm;efficiency_atlm;efficiency_ptsd;efficiency_ptsdMod;efficiency_swtteo;efficiency_tifco;efficiency_sneo];
    EFFALL{i,:}=EFF
    figure
    b=imagesc(EFF(:,:)),
    set(b,'AlphaData',~isnan(EFF))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['Efficiency Level SNR ', num2str(snr_title,'%1.2f')])
    colorbar
end
for j=1:5
    level_snr=j;
    snr_title=list_snr(level_snr+5);
    level_window=5;
    efficiency_ht=ANALISI_HT.EFF(level_snr+5,:);
    efficiency_htlm=ANALISI_HTLM.EFF(level_snr+5,:);
    efficiency_atlm=ANALISI_ATLM.EFF(level_snr+5,:,level_window);
    efficiency_ptsd=ANALISI_PTSD_SECOND.EFF2(level_snr,:,level_window);
    efficiency_ptsdMod=ANALISI_PTSDMOD.EFF(level_snr+5,1:10,level_window);
    efficiency_swtteo=ANALISI_SWTTEO.EFF(level_snr+5,:);
    efficiency_tifco=ANALISI_TIFCO.EFF(level_snr+5,:);
    efficiency_sneo=ANALISI_SNEO.EFF(level_snr+5,:,level_window);
    EFF=[efficiency_ht; efficiency_htlm;efficiency_atlm;efficiency_ptsd;efficiency_ptsdMod;efficiency_swtteo;efficiency_tifco;efficiency_sneo];
    EFFALL2{j,:}=EFF
    figure
    b=imagesc(EFF(:,:)),
    set(b,'AlphaData',~isnan(EFF))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['Efficiency Level SNR ', num2str(snr_title,'%1.2f')])
    colorbar
end
%% ACCURACY
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
list_snr=SNR_param(:,1);
level_window=5;
for i=1:5
    level_snr=i;
    snr_title=list_snr(level_snr);
    accuracy_ht=ANALISI_HT.ACCURACY(level_snr,:);
    accuracy_htlm=ANALISI_HTLM.ACCURACY(level_snr,:);
    accuracy_atlm=ANALISI_ATLM.ACCURACY(level_snr,:,level_window);
    accuracy_ptsd=ANALISI_PTSD_FIRST.ACCURACY(level_snr,:,level_window);
    accuracy_ptsdMod=ANALISI_PTSDMOD.ACCURACY(level_snr,1:10,level_window);
    accuracy_swtteo=ANALISI_SWTTEO.ACCURACY(level_snr,:);
    accuracy_tifco=ANALISI_TIFCO.ACCURACY(level_snr,:);
    accuracy_sneo=ANALISI_SNEO.ACCURACY(level_snr,:,level_window);
    ACC=[accuracy_ht; accuracy_htlm;accuracy_atlm;accuracy_ptsd;accuracy_ptsdMod;accuracy_swtteo;accuracy_tifco;accuracy_sneo];
    ACCALL{i,:}=ACC;
    figure
    b=imagesc(ACC(:,:)),
    set(b,'AlphaData',~isnan(ACC))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['Accuracy Level SNR ', num2str(snr_title,'%1.2f')])
end
level_window=5;
for j=1:5
    level_snr=j;
    snr_title=list_snr(level_snr+5);
    accuracy_ht=ANALISI_HT.ACCURACY(level_snr+5,:);
    accuracy_htlm=ANALISI_HTLM.ACCURACY(level_snr+5,:);
    accuracy_atlm=ANALISI_ATLM.ACCURACY(level_snr+5,:,level_window);
    accuracy_ptsd=ANALISI_PTSD_SECOND.ACCURACY2(level_snr,:,level_window);
    accuracy_ptsdMod=ANALISI_PTSDMOD.ACCURACY(level_snr+5,1:10,level_window);
    accuracy_swtteo=ANALISI_SWTTEO.ACCURACY(level_snr+5,:);
    accuracy_tifco=ANALISI_TIFCO.ACCURACY(level_snr+5,:);
    accuracy_sneo=ANALISI_SNEO.ACCURACY(level_snr+5,:,level_window);
    ACC=[accuracy_ht; accuracy_htlm;accuracy_atlm;accuracy_ptsd;accuracy_ptsdMod;accuracy_swtteo;accuracy_tifco;accuracy_sneo];
    ACCALL2{j,:}=ACC;
    figure
    b=imagesc(ACC(:,:)), set(b,'AlphaData',~isnan(ACC))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['Accuracy Level SNR ',num2str(snr_title,'%1.2f')])
end
%% FPR
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
list_snr=SNR_param(:,1);
level_window=5;
for i=1:5
    level_snr=i;
    snr_title=list_snr(level_snr);
    fpr_ht=ANALISI_HT.FP_rate_all(level_snr,:);
    fpr_htlm=ANALISI_HTLM.FP_rate_all(level_snr,:);
    fpr_atlm=ANALISI_ATLM.FP_rate_all(level_snr,:,level_window);
    fpr_ptsd=ANALISI_PTSD_FIRST.FP_rate_all(level_snr,:,level_window);
    fpr_ptsdMod=ANALISI_PTSDMOD.FP_rate_all(level_snr,1:10,level_window);
    fpr_swtteo=ANALISI_SWTTEO.FP_rate_all(level_snr,:);
    fpr_tifco=ANALISI_TIFCO.FP_rate_all(level_snr,:);
    fpr_sneo=ANALISI_SNEO.FP_rate_all(level_snr,:,level_window);
    FPR=[fpr_ht; fpr_htlm;fpr_atlm;fpr_ptsd;fpr_ptsdMod;fpr_swtteo;fpr_tifco;fpr_sneo];
    FPRALL{i,:}=FPR;
    figure
    b=imagesc(FPR(:,:)),
    set(b,'AlphaData',~isnan(FPR))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['FPR Level SNR ', num2str(snr_title,'%1.2f')])
end
level_window=5;
for j=1:5
    level_snr=j;
    snr_title=list_snr(level_snr+5);
    fpr_ht=ANALISI_HT.FP_rate_all(level_snr+5,:);
    fpr_htlm=ANALISI_HTLM.FP_rate_all(level_snr+5,:);
    fpr_atlm=ANALISI_ATLM.FP_rate_all(level_snr+5,:,level_window);
    fpr_ptsd=ANALISI_PTSD_SECOND.FP_rate_all2(level_snr,:,level_window);
    fpr_ptsdMod=ANALISI_PTSDMOD.FP_rate_all(level_snr+5,1:10,level_window);
    fpr_swtteo=ANALISI_SWTTEO.FP_rate_all(level_snr+5,:);
    fpr_tifco=ANALISI_TIFCO.FP_rate_all(level_snr+5,:);
    fpr_sneo=ANALISI_SNEO.FP_rate_all(level_snr+5,:,level_window);
    FPR=[fpr_ht; fpr_htlm;fpr_atlm;fpr_ptsd;fpr_ptsdMod;fpr_swtteo;fpr_tifco;fpr_sneo];
    FPRALL2{j,:}=FPR;
    figure
    b=imagesc(FPR(:,:)), set(b,'AlphaData',~isnan(FPR))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['FPR Level SNR ',num2str(snr_title,'%1.2f')])
end
%% PRECISION
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
list_snr=SNR_param(:,1);
level_window=5;
for i=1:5
    level_snr=i;
    snr_title=list_snr(level_snr);
    precision_ht=ANALISI_HT.PRECISION(level_snr,:);
    precision_htlm=ANALISI_HTLM.PRECISION(level_snr,:);
    precision_atlm=ANALISI_ATLM.PRECISION(level_snr,:,level_window);
    precision_ptsd=ANALISI_PTSD_FIRST.PRECISION(level_snr,:,level_window);
    precision_ptsdMod=ANALISI_PTSDMOD.PRECISION(level_snr,1:10,level_window);
    precision_swtteo=ANALISI_SWTTEO.PRECISION(level_snr,:);
    precision_tifco=ANALISI_TIFCO.PRECISION(level_snr,:);
    precision_sneo=ANALISI_SNEO.PRECISION(level_snr,:,level_window);
    PREC=[precision_ht; precision_htlm;precision_atlm;precision_ptsd;precision_ptsdMod;precision_swtteo;precision_tifco;precision_sneo];
    PRECALL{i,:}=PREC;
    figure
    b=imagesc(PREC(:,:)),
    set(b,'AlphaData',~isnan(PREC))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['Precision Level SNR ', num2str(snr_title,'%1.2f')])
end
for j=1:5
    level_snr=j;
    snr_title=list_snr(level_snr+5); level_window=5;
    precision_ht=ANALISI_HT.PRECISION(level_snr+5,:);
    precision_htlm=ANALISI_HTLM.PRECISION(level_snr+5,:);
    precision_atlm=ANALISI_ATLM.PRECISION(level_snr+5,:,level_window);
    precision_ptsd=ANALISI_PTSD_SECOND.PRECISION2(level_snr,:,level_window);
    precision_ptsdMod=ANALISI_PTSDMOD.PRECISION(level_snr+5,1:10,level_window);
    precision_swtteo=ANALISI_SWTTEO.PRECISION(level_snr+5,:);
    precision_tifco=ANALISI_TIFCO.PRECISION(level_snr+5,:);
    precision_sneo=ANALISI_SNEO.PRECISION(level_snr+5,:,level_window);
    PREC=[precision_ht; precision_htlm;precision_atlm;precision_ptsd;precision_ptsdMod;precision_swtteo;precision_tifco;precision_sneo];
    PRECALL2{j,:}=PREC;
    figure
    b=imagesc(PREC(:,:)), set(b,'AlphaData',~isnan(PREC))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['Precision Level SNR ',num2str(snr_title,'%1.2f')])
end
%% SPECIFICITY
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
list_snr=SNR_param(:,1);
level_window=5;
for i=1:5
    level_snr=i;
    snr_title=list_snr(level_snr);
    specificity_ht=ANALISI_HT.SPECIFICITY(level_snr,:);
    specificity_htlm=ANALISI_HTLM.SPECIFICITY(level_snr,:);
    specificity_atlm=ANALISI_ATLM.SPECIFICITY(level_snr,:,level_window);
    specificity_ptsd=ANALISI_PTSD_FIRST.SPECIFICITY(level_snr,:,level_window);
    specificity_ptsdMod=ANALISI_PTSDMOD.SPECIFICITY(level_snr,1:10,level_window);
    specificity_swtteo=ANALISI_SWTTEO.SPECIFICITY(level_snr,:);
    specificity_tifco=ANALISI_TIFCO.SPECIFICITY(level_snr,:);
    specificity_sneo=ANALISI_SNEO.SPECIFICITY(level_snr,:,level_window);
    SPEC=[specificity_ht; specificity_htlm;specificity_atlm;specificity_ptsd;specificity_ptsdMod;specificity_swtteo;specificity_tifco;specificity_sneo];
    SPECALL{i,:}=SPEC;
    figure
    b=imagesc(SPEC(:,:)),
    set(b,'AlphaData',~isnan(SPEC))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['Specificity Level SNR ', num2str(snr_title,'%1.2f')])
end
for j=1:5
    level_snr=j;
    snr_title=list_snr(level_snr+5); level_window=5;
    specificity_ht=ANALISI_HT.SPECIFICITY(level_snr+5,:);
    specificity_htlm=ANALISI_HTLM.SPECIFICITY(level_snr+5,:);
    specificity_atlm=ANALISI_ATLM.SPECIFICITY(level_snr+5,:,level_window);
    specificity_ptsd=ANALISI_PTSD_SECOND.SPECIFICITY2(level_snr,:,level_window);
    specificity_ptsd=ANALISI_PTSDMOD.SPECIFICITY(level_snr+5,1:10,level_window);
    specificity_swtteo=ANALISI_SWTTEO.SPECIFICITY(level_snr+5,:);
    specificity_tifco=ANALISI_TIFCO.SPECIFICITY(level_snr+5,:);
    specificity_sneo=ANALISI_SNEO.SPECIFICITY(level_snr+5,:,level_window);
    SPEC=[specificity_ht; specificity_htlm;specificity_atlm;specificity_ptsd;specificity_ptsdMod;specificity_swtteo;specificity_tifco;specificity_sneo];
    SPECALL2{j,:}=SPEC;
    figure
    b=imagesc(SPEC(:,:)), set(b,'AlphaData',~isnan(SPEC))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['Specificity Level SNR ',num2str(snr_title,'%1.2f')])
end
%% F1 SCORE
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
list_snr=SNR_param(:,1);
level_window=5;
for i=1:5
    level_snr=i;
    snr_title=list_snr(level_snr);
    f1score_ht=ANALISI_HT.F1_SCORE(level_snr,:);
    f1score_htlm=ANALISI_HTLM.F1_SCORE(level_snr,:);
    f1score_atlm=ANALISI_ATLM.F1_SCORE(level_snr,:,level_window);
    f1score_ptsd=ANALISI_PTSD_FIRST.F1_SCORE(level_snr,:,level_window);
    f1score_ptsdMod=ANALISI_PTSDMOD.F1_SCORE(level_snr,1:10,level_window);
    f1score_swtteo=ANALISI_SWTTEO.F1_SCORE(level_snr,:);
    f1score_tifco=ANALISI_TIFCO.F1_SCORE(level_snr,:);
    f1score_sneo=ANALISI_SNEO.F1_SCORE(level_snr,:,level_window);
    F1S=[f1score_ht; f1score_htlm;f1score_atlm;f1score_ptsd;f1score_ptsdMod;f1score_swtteo;f1score_tifco;f1score_sneo];
    F1SALL{i,:}=F1S;
    figure
    b=imagesc(F1S(:,:)),
    set(b,'AlphaData',~isnan(F1S))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['F1 Score Level SNR ', num2str(snr_title,'%1.2f')])
end
level_window=5;
for j=1:5
    level_snr=j;
    snr_title=list_snr(level_snr+5);
    f1score_ht=ANALISI_HT.F1_SCORE(level_snr+5,:);
    f1score_htlm=ANALISI_HTLM.F1_SCORE(level_snr+5,:);
    f1score_atlm=ANALISI_ATLM.F1_SCORE(level_snr+5,:,level_window);
    f1score_ptsd=ANALISI_PTSD_SECOND.F1_SCORE2(level_snr,:,level_window);
    f1score_ptsdMod=ANALISI_PTSDMOD.F1_SCORE(level_snr+5,1:10,level_window);
    f1score_swtteo=ANALISI_SWTTEO.F1_SCORE(level_snr+5,:);
    f1score_tifco=ANALISI_TIFCO.F1_SCORE(level_snr+5,:);
    f1score_sneo=ANALISI_SNEO.F1_SCORE(level_snr+5,:,level_window);
    F1S=[f1score_ht; f1score_htlm;f1score_atlm;f1score_ptsd;f1score_ptsdMod;f1score_swtteo;f1score_tifco;f1score_sneo];
    F1SALL2{j,:}=F1S;
    figure
    b=imagesc(F1S(:,:)), set(b,'AlphaData',~isnan(F1S))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['F1 Score Level SNR ',num2str(snr_title,'%1.2f')])
end

%% MCC
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
list_snr=SNR_param(:,1);
level_window=5;
for i=1:5
    level_snr=i;
    snr_title=list_snr(level_snr);
    mcc_ht=ANALISI_HT.MCC_all(level_snr,:);
    mcc_htlm=ANALISI_HTLM.MCC_all(level_snr,:);
    mcc_atlm=ANALISI_ATLM.MCC_all(level_snr,:,level_window);
    mcc_ptsd=ANALISI_PTSD_FIRST.MCC_all(level_snr,:,level_window);
    mcc_ptsdMod=ANALISI_PTSDMOD.MCC_all(level_snr,1:10,level_window);
    mcc_swtteo=ANALISI_SWTTEO.MCC_all(level_snr,:);
    mcc_tifco=ANALISI_TIFCO.MCC_all(level_snr,:);
    mcc_sneo=ANALISI_SNEO.MCC_all(level_snr,:,level_window);
    MCC=[mcc_ht; mcc_htlm;mcc_atlm;mcc_ptsd;mcc_ptsdMod;mcc_swtteo;mcc_tifco;mcc_sneo];
    MCCALL{i,:}=MCC;
    figure
    b=imagesc(MCC(:,:)),
    set(b,'AlphaData',~isnan(MCC))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['MCC Level SNR ', num2str(snr_title,'%1.2f')])
end
level_window=5;
for j=1:5
    level_snr=j;
    snr_title=list_snr(level_snr+5);
    mcc_ht=ANALISI_HT.MCC_all(level_snr+5,:);
    mcc_htlm=ANALISI_HTLM.MCC_all(level_snr+5,:);
    mcc_atlm=ANALISI_ATLM.MCC_all(level_snr+5,:,level_window);
    mcc_ptsd=ANALISI_PTSD_SECOND.MCC_all2(level_snr,:,level_window);
    mcc_ptsdMod=ANALISI_PTSDMOD.MCC_all(level_snr+5,1:10,level_window);
    mcc_swtteo=ANALISI_SWTTEO.MCC_all(level_snr+5,:);
    mcc_tifco=ANALISI_TIFCO.MCC_all(level_snr+5,:);
    mcc_sneo=ANALISI_SNEO.MCC_all(level_snr+5,:,level_window);
    MCC=[mcc_ht; mcc_htlm;mcc_atlm;mcc_ptsd;mcc_ptsdMod;mcc_swtteo;mcc_tifco;mcc_sneo];
    MCCALL2{j,:}=MCC;
    figure
    b=imagesc(MCC(:,:)), set(b,'AlphaData',~isnan(MCC))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['MCC Score Level SNR ',num2str(snr_title,'%1.2f')])
end
%% FNR
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
list_snr=SNR_param(:,1);
level_window=5;
for i=1:5
    level_snr=i;
    snr_title=list_snr(level_snr);
    fnr_ht=ANALISI_HT.FN_rate_all(level_snr,:);
    fnr_htlm=ANALISI_HTLM.FN_rate_all(level_snr,:);
    fnr_atlm=ANALISI_ATLM.FN_rate_all(level_snr,:,level_window);
    fnr_ptsd=ANALISI_PTSD_FIRST.FN_rate_all(level_snr,:,level_window);
    fnr_ptsdMod=ANALISI_PTSDMOD.FN_rate_all(level_snr,1:10,level_window);
    fnr_swtteo=ANALISI_SWTTEO.FN_rate_all(level_snr,:);
    fnr_tifco=ANALISI_TIFCO.FN_rate_all(level_snr,:);
    fnr_sneo=ANALISI_SNEO.FN_rate_all(level_snr,:,level_window);
    FNR=[fnr_ht; fnr_htlm;fnr_atlm;fnr_ptsd;fnr_ptsdMod;fnr_swtteo;fnr_tifco;fnr_sneo];
    FNRALL{i,:}=FNR;
    figure
    b=imagesc(FNR(:,:)),
    set(b,'AlphaData',~isnan(FNR))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['FNR Score Level SNR ', num2str(snr_title,'%1.2f')])
end
level_window=5;
for j=1:5
    level_snr=j;
    snr_title=list_snr(level_snr+5);
    fnr_ht=ANALISI_HT.FN_rate_all(level_snr+5,:);
    fnr_htlm=ANALISI_HTLM.FN_rate_all(level_snr+5,:);
    fnr_atlm=ANALISI_ATLM.FN_rate_all(level_snr+5,:,level_window);
    fnr_ptsd=ANALISI_PTSD_SECOND.FN_rate_all2(level_snr,:,level_window);
    fnr_ptsdMod=ANALISI_PTSDMOD.FN_rate_all(level_snr+5,1:10,level_window);
    fnr_swtteo=ANALISI_SWTTEO.FN_rate_all(level_snr+5,:);
    fnr_tifco=ANALISI_TIFCO.FN_rate_all(level_snr+5,:);
    fnr_sneo=ANALISI_SNEO.FN_rate_all(level_snr+5,:,level_window);
    FNR=[fnr_ht; fnr_htlm;fnr_atlm;fnr_ptsd;fnr_ptsdMod;fnr_swtteo;fnr_tifco;fnr_sneo];
    FNRALL2{j,:}=FNR;
    figure
    b=imagesc(FNR(:,:)), set(b,'AlphaData',~isnan(FNR))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['FNR Score Level SNR ',num2str(snr_title,'%1.2f')])
end
%% NPV
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
list_snr=SNR_param(:,1);
level_window=5;
for i=1:5
    level_snr=i;
    snr_title=list_snr(level_snr);
    npv_ht=ANALISI_HT.NPV_all(level_snr,:);
    npv_htlm=ANALISI_HTLM.NPV_all(level_snr,:);
    npv_atlm=ANALISI_ATLM.NPV_all(level_snr,:,level_window);
    npv_ptsd=ANALISI_PTSD_FIRST.NPV_all(level_snr,:,level_window);
    npv_ptsdMod=ANALISI_PTSDMOD.NPV_all(level_snr,1:10,level_window);
    npv_swtteo=ANALISI_SWTTEO.NPV_all(level_snr,:);
    npv_tifco=ANALISI_TIFCO.NPV_all(level_snr,:);
    npv_sneo=ANALISI_SNEO.NPV_all(level_snr,:,level_window);
    NPV=[npv_ht; npv_htlm;npv_atlm;npv_ptsd;npv_ptsdMod;npv_swtteo;npv_tifco;npv_sneo];
    NPVALL{i,:}=NPV;
    figure
    b=imagesc(NPV(:,:)),
    set(b,'AlphaData',~isnan(NPV))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['NPV Score Level SNR ', num2str(snr_title,'%1.2f')])
end
level_window=5;
for j=1:5
    level_snr=j;
    snr_title=list_snr(level_snr+5);
    npv_ht=ANALISI_HT.NPV_all(level_snr+5,:);
    npv_htlm=ANALISI_HTLM.NPV_all(level_snr+5,:);
    npv_atlm=ANALISI_ATLM.NPV_all(level_snr+5,:,level_window);
    npv_ptsd=ANALISI_PTSD_SECOND.NPV_all2(level_snr,:,level_window);
    npv_ptsdMod=ANALISI_PTSDMOD.NPV_all(level_snr+5,1:10,level_window);
    npv_swtteo=ANALISI_SWTTEO.NPV_all(level_snr+5,:);
    npv_tifco=ANALISI_TIFCO.NPV_all(level_snr+5,:);
    npv_sneo=ANALISI_SNEO.NPV_all(level_snr+5,:,level_window);
    NPV=[npv_ht; npv_htlm;npv_atlm;npv_ptsd;npv_ptsdMod;npv_swtteo;npv_tifco;npv_sneo];
    NPVALL2{j,:}=NPV;
    figure
    b=imagesc(NPV(:,:)), set(b,'AlphaData',~isnan(NPV))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['NPV Score Level SNR ',num2str(snr_title,'%1.2f')])
end
%%
%% FDR
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
list_snr=SNR_param(:,1);
level_window=5;
for i=1:5
    level_snr=i;
    snr_title=list_snr(level_snr);
    fdr_ht=ANALISI_HT.FDR_all(level_snr,:);
    fdr_htlm=ANALISI_HTLM.FDR_all(level_snr,:);
    fdr_atlm=ANALISI_ATLM.FDR_all(level_snr,:,level_window);
    fdr_ptsd=ANALISI_PTSD_FIRST.FDR_all(level_snr,:,level_window);
    fdr_ptsdMod=ANALISI_PTSDMOD.FDR_all(level_snr,1:10,level_window);
    fdr_swtteo=ANALISI_SWTTEO.FDR_all(level_snr,:);
    fdr_tifco=ANALISI_TIFCO.FDR_all(level_snr,:);
    fdr_sneo=ANALISI_SNEO.FDR_all(level_snr,:,level_window);
    FDR=[fdr_ht; fdr_htlm;fdr_atlm;fdr_ptsd;fdr_ptsdMod;fdr_swtteo;fdr_tifco;fdr_sneo];
    FDRALL{i,:}=FDR;
    figure
    b=imagesc(FDR(:,:)),
    set(b,'AlphaData',~isnan(FDR))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['FDR Score Level SNR ', num2str(snr_title,'%1.2f')])
end
level_window=5;
for j=1:5
    level_snr=j;
    snr_title=list_snr(level_snr+5);
    fdr_ht=ANALISI_HT.FDR_all(level_snr+5,:);
    fdr_htlm=ANALISI_HTLM.FDR_all(level_snr+5,:);
    fdr_atlm=ANALISI_ATLM.FDR_all(level_snr+5,:,level_window);
    fdr_ptsd=ANALISI_PTSD_SECOND.FDR_all2(level_snr,:,level_window);
    fdr_ptsdMod=ANALISI_PTSDMOD.FDR_all(level_snr+5,1:10,level_window);
    fdr_swtteo=ANALISI_SWTTEO.FDR_all(level_snr+5,:);
    fdr_tifco=ANALISI_TIFCO.FDR_all(level_snr+5,:);
    fdr_sneo=ANALISI_SNEO.FDR_all(level_snr+5,:,level_window);
    FDR=[fdr_ht; fdr_htlm;fdr_atlm;fdr_ptsd;fdr_ptsdMod;fdr_swtteo;fdr_tifco;fdr_sneo];
    FDRALL2{j,:}=FDR;
    figure
    b=imagesc(FDR(:,:)), set(b,'AlphaData',~isnan(FDR))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['FDR Score Level SNR ',num2str(snr_title,'%1.2f')])
end
%% FOR
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
list_snr=SNR_param(:,1);
level_window=5;
for i=1:5
    level_snr=i;
    snr_title=list_snr(level_snr);
    for_ht=ANALISI_HT.FDR_all(level_snr,:);
    for_htlm=ANALISI_HTLM.FDR_all(level_snr,:);
    for_atlm=ANALISI_ATLM.FDR_all(level_snr,:,level_window);
    for_ptsd=ANALISI_PTSD_FIRST.FDR_all(level_snr,:,level_window);
    for_ptsdMod=ANALISI_PTSDMOD.FDR_all(level_snr,1:10,level_window);
    for_swtteo=ANALISI_SWTTEO.FDR_all(level_snr,:);
    for_tifco=ANALISI_TIFCO.FDR_all(level_snr,:);
    for_sneo=ANALISI_SNEO.FDR_all(level_snr,:,level_window);
    FOR=[for_ht; for_htlm;for_atlm;for_ptsd;for_ptsdMod;for_swtteo;for_tifco;for_sneo];
    FORALL{i,:}=FOR;
    figure
    b=imagesc(FOR(:,:)),
    set(b,'AlphaData',~isnan(FOR))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['FOR Score Level SNR ', num2str(snr_title,'%1.2f')])
end
level_window=5;
for j=1:5
    level_snr=j;
    snr_title=list_snr(level_snr+5);
    for_ht=ANALISI_HT.FDR_all(level_snr+5,:);
    for_htlm=ANALISI_HTLM.FDR_all(level_snr+5,:);
    for_atlm=ANALISI_ATLM.FDR_all(level_snr+5,:,level_window);
    for_ptsd=ANALISI_PTSD_SECOND.FDR_all2(level_snr,:,level_window);
    for_ptsdMod=ANALISI_PTSDMOD.FDR_all(level_snr+5,1:10,level_window);
    for_swtteo=ANALISI_SWTTEO.FDR_all(level_snr+5,:);
    for_tifco=ANALISI_TIFCO.FDR_all(level_snr+5,:);
    for_sneo=ANALISI_SNEO.FDR_all(level_snr+5,:,level_window);
    FOR=[for_ht; for_htlm;for_atlm;for_ptsd;for_ptsdMod;for_swtteo;for_tifco;for_sneo];
    FORALL2{j,:}=FOR;
    figure
    b=imagesc(FOR(:,:)), set(b,'AlphaData',~isnan(FOR))
    caxis([0 1]), colorbar,
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['FOR Score Level SNR ',num2str(snr_title,'%1.2f')])
end

%% QUANTI NE TROVA
%% HT
x=1:10
y=395.*ones(length(x));
for i=1:10
    NumDetected_HT=ANALISI_HT.FP_all(i,:)+ANALISI_HT.TP_all(i,:)
    figure(1)
    plot(NumDetected_HT), hold on, plot(x,y,'g'), title('Number of spikes found')
end
%% HTLM
x=1:10
y=395.*ones(length(x));
for i=1:10
    NumDetected_HTLM=ANALISI_HTLM.FP_all(i,:)+ANALISI_HTLM.TP_all(i,:)
    figure(1)
    plot(NumDetected_HTLM), hold on, plot(x,y,'g'), title('Number of spikes found')
end
%% ATLM
x=1:10
y=395.*ones(length(x));
for i=1:10
    NumDetected_ATLM=ANALISI_ATLM.FP_all(i,:,5)+ANALISI_ATLM.TP_all(i,:,5);
    figure(1)
    plot(NumDetected_ATLM), hold on, plot(x,y,'g'), title('Number of spikes found')
end
%% PTSD
x=1:10
y=395.*ones(length(x));

for i=1:5
    NumDetected_PTSD1=ANALISI_PTSD_FIRST.FP_all(i,:,5)+ANALISI_PTSD_FIRST.TP_all(i,:,5);
    NumDetected_PTSD2=ANALISI_PTSD_SECOND.FP_all2(i,:,5)+ANALISI_PTSD_SECOND.TP_all2(i,:,5);
    ND=[NumDetected_PTSD1' NumDetected_PTSD2']
    figure(1)
    plot(ND), hold on, plot(x,y,'g'), title('Number of spikes found')
end

%% PTSD MOD
x=1:10
y=395.*ones(length(x));
for i=1:10
    NumDetected_PTSDMOD=ANALISI_PTSDMOD.FP_all(i,1:10,5)+ANALISI_PTSDMOD.TP_all(i,1:10,5);
    figure(1)
    plot(NumDetected_PTSDMOD), hold on , title('Number of spikes found')
end
hold on, plot(x,y,'g')
%% TIFCO
x=1:10
y=395.*ones(length(x));
for i=1:10
    NumDetected_TIFCO=ANALISI_TIFCO.FP_all(i,:)+ANALISI_TIFCO.TP_all(i,:)
    figure(1)
    plot(NumDetected_TIFCO), hold on, plot(x,y,'g'), title('Number of spikes found')
end
%% SWTTEO
x=1:10
y=395.*ones(length(x));
for i=1:10
    NumDetected_SWTTEO=ANALISI_SWTTEO.FP_all(i,:)+ANALISI_SWTTEO.TP_all(i,:)
    figure(1)
    plot(NumDetected_SWTTEO), hold on, plot(x,y,'g'), title('Number of spikes found')
end
%% SNEO
x=1:10
y=395.*ones(length(x));
for i=1:10
    NumDetected_SNEO=ANALISI_SNEO.FP_all(i,:,5)+ANALISI_SNEO.TP_all(i,:,5g)
    figure(1)
    plot(NumDetected_SNEO), hold on, plot(x,y,'g'), title('Number of spikes found')
end
%% CHI VINCE?

for i=1:5
    NPVALLI=NPVALL{i,:};
    NPVALLI(isnan(NPVALLI))=0;
    FDRALLI=FDRALL{i,:};
    FDRALLI(isnan(FDRALLI))=0;
    FORALLI=FORALL{i,:};
    FORALLI(isnan(FORALLI))=0;
    PALLI=PRECALL{i,:};
    PALLI(isnan(PALLI))=0;
    MALLI=MCCALL{i,:};
    MALLI(isnan(MALLI))=0;
    SENSALLI=SENSALL{i,:};
    SENSALLI(isnan(SENSALLI))=0;
    EFFALLI=EFFALL{i,:};
    EFFALLI(isnan(EFFALLI))=0;
    ACCALLI=ACCALL{i,:};
    ACCALLI(isnan(ACCALLI))=0;
    FPRALLI=FPRALL{i,:};
    FPRALLI(isnan(FPRALLI))=0;
    SPECALLI=SPECALL{i,:};
    SPECALLI(isnan(SPECALLI))=0;
    F1SALLI=F1SALL{i,:};
    F1SALLI(isnan(F1SALLI))=0;
    FNRALLI=FNRALL{i,:};
    FNRALLI(isnan(FNRALLI))=0;
    RESULTS=SENSALLI+EFFALLI+ACCALLI+PALLI+MALLI+(ones(size(FPRALLI))-FPRALLI)+SPECALLI+F1SALLI+(ones(size(FNRALLI))-FNRALLI)+NPVALLI+(ones(size(FDRALLI))-FDRALLI)+(ones(size(FORALLI))-FORALLI);
    figure(i)
    imagesc(RESULTS(:,:))
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['FINALE SCORE, SNR ',num2str(list_snr(i),'%1.2f')])
    colorbar
end
%%
for i=1:5
    NPVALLI2=NPVALL2{i,:};
    NPVALLI2(isnan(NPVALLI2))=0;
    FDRALLI2=FDRALL2{i,:};
    FDRALLI2(isnan(FDRALLI2))=0;
    FORALLI2=FORALL2{i,:};
    FORALLI2(isnan(FORALLI2))=0;
    PALLI2=PRECALL2{i,:};
    PALLI2(isnan(PALLI2))=0;
    MALLI2=MCCALL2{i,:};
    MALLI2(isnan(MALLI2))=0;
    SENSALLI2=SENSALL2{i,:};
    SENSALLI2(isnan(SENSALLI2))=0;
    EFFALLI2=EFFALL2{i,:};
    EFFALLI2(isnan(EFFALLI2))=0;
    ACCALLI2=ACCALL2{i,:};
    ACCALLI2(isnan(ACCALLI2))=0;
    FPRALLI2=FPRALL2{i,:};
    FPRALLI2(isnan(FPRALLI2))=0;
    SPECALLI2=SPECALL2{i,:};
    SPECALLI2(isnan(SPECALLI2))=0;
    F1SALLI2=F1SALL2{i,:};
    F1SALLI2(isnan(F1SALLI2))=0;
    FNRALLI2=FDRALL2{i,:};
    FNRALLI2(isnan(FNRALLI2))=0;
    RESULTS=SENSALLI2+EFFALLI2+ACCALLI2+PALLI2+MALLI2+(ones(size(FPRALLI2))-FPRALLI2)+SPECALLI2+F1SALLI2+(ones(size(FNRALLI2))-FNRALLI2)+NPVALLI2+(ones(size(FDRALLI2))-FDRALLI2)+(ones(size(FORALLI2))-FORALLI2);
    figure(i)
    imagesc(RESULTS(:,:))
    yticklabels({'HT','HTLM','ATLM','PTSD','PTSDmod','SWTTEO','TIFCO','SNEO'})
    xlabel('Number of multCoeff used'), title(['FINAL SCORE, Level SNR ',num2str(list_snr(i+5),'%1.2f')])
    colorbar
end

