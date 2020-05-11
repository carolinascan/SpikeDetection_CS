clc, clear all, close all
%%
param1=1;
param2=20;
parametro=linspace(param1,param2,30);
%% MULTI UNIT SNR 1
path_MU=('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\TIFCO\MULTI UNIT\')
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SINGLE UNIT DA ANALIZZARE\Gamma\g_SNR1.mat')
for i=1:length(parametro)
    load([path_MU '\Parametro ' num2str(parametro(i)) '\s1_roc.mat'])
    NCS(i,1)=roc.tp;
    FP(i,1)=roc.fp;
    NREF(i,1)=roc.NREF;
    eff(i,1)=roc.eff;
    [FP_rate(i,1),TP_rate(i,1)] = roc_parameters(NREF(i),FP(i),NCS(i),data)
    clear roc
end
XY=[FP_rate TP_rate];
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\coordinate roc tifco\XY_MU_snr1.mat'],'XY','eff')
clear FP_rate TP_rate XY NCS FP NREF eff

%% MULTI UNIT SNR 1.3
path_MU=('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\TIFCO\MULTI UNIT\')
for i=1:length(parametro)
    load([path_MU '\Parametro ' num2str(parametro(i)) '\s13_roc.mat'])
    NCS(i,1)=roc.tp;
    FP(i,1)=roc.fp;
    NREF(i,1)=roc.NREF;
    eff(i,1)=roc.eff;
    [FP_rate(i,1),TP_rate(i,1)] = roc_parameters(NREF(i),FP(i),NCS(i),data)
    clear roc
end
XY=[FP_rate TP_rate];
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\coordinate roc tifco\XY_MU_snr13.mat'],'XY','eff')
clear FP_rate TP_rate XY NCS FP NREF eff

%% MULTI UNIT SNR 1.15
path_MU=('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\TIFCO\MULTI UNIT\')
for i=1:length(parametro)
    load([path_MU '\Parametro ' num2str(parametro(i)) '\s115_roc.mat'])
    NCS(i,1)=roc.tp;
    FP(i,1)=roc.fp;
    NREF(i,1)=roc.NREF;
    eff(i,1)=roc.eff;
    [FP_rate(i,1),TP_rate(i,1)] = roc_parameters(NREF(i),FP(i),NCS(i),data)
    clear roc
end
XY=[FP_rate TP_rate];
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\coordinate roc tifco\XY_MU_snr115.mat'],'XY','eff')
clear FP_rate TP_rate XY NCS FP NREF eff

%% EXPO SNR 1
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SINGLE UNIT DA ANALIZZARE\Gamma\g_SNR1.mat')
path_expo='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\TIFCO\EXPO\'
for i=1:length(parametro)
    load([path_expo '\Parametro ' num2str(parametro(i)) '\expo1_roc.mat'])
    NCS(i,1)=roc.tp;
    FP(i,1)=roc.fp;
    NREF=roc.NREF;
    eff(i,1)=roc.eff;
    [FP_rate(i,1),TP_rate(i,1)] = roc_parameters(NREF,FP(i),NCS(i),data)
    clear roc
end
XY=[FP_rate TP_rate];
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\coordinate roc tifco\XY_expo_snr1.mat'],'XY','eff')
clear FP_rate TP_rate XY NCS FP NREF eff

%% EXPO SNR 1.3
for i=1:length(parametro)
    load([path_expo '\Parametro ' num2str(parametro(i)) '\expo13_roc.mat'])
    NCS(i,1)=roc.tp;
    FP(i,1)=roc.fp;
    NREF(i,1)=roc.NREF;
    eff(i,1)=roc.eff;
    [FP_rate(i,1),TP_rate(i,1)] = roc_parameters(NREF(i),FP(i),NCS(i),data)
    clear roc
end
XY=[FP_rate TP_rate];
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\coordinate roc tifco\XY_expo_snr13.mat'],'XY','eff')
clear FP_rate TP_rate XY NCS FP NREF eff

%% EXPO SNR 1.15
for i=1:length(parametro)
    load([path_expo '\Parametro ' num2str(parametro(i)) '\expo115_roc.mat'])
    NCS(i,1)=roc.tp;
    FP(i,1)=roc.fp;
    NREF(i,1)=roc.NREF;
    eff(i,1)=roc.eff;
    [FP_rate(i,1),TP_rate(i,1)] = roc_parameters(NREF(i),FP(i),NCS(i),data)
    clear roc
end
XY=[FP_rate TP_rate];
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\coordinate roc tifco\XY_expo_snr115.mat'],'XY','eff')
clear FP_rate TP_rate XY NCS FP NREF eff

%% GAMMA SNR 1
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SINGLE UNIT DA ANALIZZARE\Gamma\g_SNR1.mat')
path_gamma='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\SOGLIA SECCA\GAMMA\'
for i=1:length(parametro)
    load([path_gamma 'Parametro ' num2str(parametro(i)) '\gamma1_roc.mat'])
    NCS(i,1)=roc.tp;
    FP(i,1)=roc.fp;
    NREF(i,1)=roc.NREF;
    eff(i,1)=roc.eff;
    [FP_rate(i,1),TP_rate(i,1)] = roc_parameters(NREF(i),FP(i),NCS(i),data)
    clear roc
end
XY=[FP_rate TP_rate];
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\coordinate roc ht\XY_gamma_snr1.mat'],'XY','eff')
clear FP_rate TP_rate XY NCS FP NREF eff
%% GAMMA SNR 1.3
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SINGLE UNIT DA ANALIZZARE\Gamma\g_SNR1.mat')
path_gamma='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\SOGLIA SECCA\GAMMA\'
for i=1:length(parametro)
    load([path_gamma '\Parametro ' num2str(parametro(i)) '\gamma13_roc.mat'])
    NCS(i,1)=roc.tp;
    FP(i,1)=roc.fp;
    NREF(i,1)=roc.NREF;
    eff(i,1)=roc.eff;
    [FP_rate(i,1),TP_rate(i,1)] = roc_parameters(NREF(i),FP(i),NCS(i),data)
    clear roc
end
XY=[FP_rate TP_rate];
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\coordinate roc ht\XY_gamma_snr13.mat'],'XY','eff')
clear FP_rate TP_rate XY NCS FP NREF eff
%% GAMMA SNR 1.15
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SINGLE UNIT DA ANALIZZARE\Gamma\g_SNR1.mat')
path_gamma='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\SOGLIA SECCA\GAMMA\'
for i=1:length(parametro)
    load([path_gamma '\Parametro ' num2str(parametro(i)) '\gamma115_roc.mat'])
    NCS(i,1)=roc.tp;
    FP(i,1)=roc.fp;
    NREF(i,1)=roc.NREF;
    eff(i,1)=roc.eff;
    [FP_rate(i,1),TP_rate(i,1)] = roc_parameters(NREF(i),FP(i),NCS(i),data)
    clear roc
end
XY=[FP_rate TP_rate];
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\coordinate roc ht\XY_gamma_snr115.mat'],'XY','eff')
clear FP_rate TP_rate XY NCS FP NREF eff
%% IG SNR 1
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SINGLE UNIT DA ANALIZZARE\Gamma\g_SNR1.mat')
path_gamma='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\SOGLIA SECCA\INVGAU\'
for i=1:length(parametro)
    load([path_gamma '\Parametro ' num2str(parametro(i)) '\ig1_roc.mat'])
    NCS(i,1)=roc.tp;
    FP(i,1)=roc.fp;
    NREF(i,1)=roc.NREF;
    eff(i,1)=roc.eff;
    [FP_rate(i,1),TP_rate(i,1)] = roc_parameters(NREF(i),FP(i),NCS(i),data)
    clear roc
end
XY=[FP_rate TP_rate];
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\coordinate roc ht\XY_ig_snr1.mat'],'XY','eff')
clear FP_rate TP_rate XY NCS FP NREF eff
%% IG SNR 1.3
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SINGLE UNIT DA ANALIZZARE\Gamma\g_SNR1.mat')
path_ig='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\SOGLIA SECCA\INVGAU\'
for i=1:length(parametro)
    load([path_ig '\Parametro ' num2str(parametro(i)) '\ig13_roc.mat'])
    NCS(i,1)=roc.tp;
    FP(i,1)=roc.fp;
    NREF(i,1)=roc.NREF;
    eff(i,1)=roc.eff;
    [FP_rate(i,1),TP_rate(i,1)] = roc_parameters(NREF(i),FP(i),NCS(i),data)
    clear roc
end
XY=[FP_rate TP_rate];
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\coordinate roc ht\XY_ig_snr13.mat'],'XY','eff')
clear FP_rate TP_rate XY NCS FP NREF eff
%% IG SNR 1.15
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SINGLE UNIT DA ANALIZZARE\Gamma\g_SNR1.mat')
path_ig='C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\SOGLIA SECCA\INVGAU\'
for i=1:length(parametro)
    load([path_ig '\Parametro ' num2str(parametro(i)) '\ig115_roc.mat'])
    NCS(i,1)=roc.tp;
    FP(i,1)=roc.fp;
    NREF(i,1)=roc.NREF;
    eff(i,1)=roc.eff;
    [FP_rate(i,1),TP_rate(i,1)] = roc_parameters(NREF(i),FP(i),NCS(i),data)
    clear roc
end
XY=[FP_rate TP_rate];
save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\coordinate roc ht\XY_ig_snr115.mat'],'XY','eff')
clear FP_rate TP_rate XY NCS FP NREF eff
