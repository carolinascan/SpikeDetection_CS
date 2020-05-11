clc, clear all, close all
%% PTSD SNR 1.3
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\MULTI UNIT\roc_snr13.mat');
level_snr=13;
%% PTSD SNR 1.15
 load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\MULTI UNIT\roc_snr115.mat');
 level_snr=115;
%% PTSD SNR 1
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\param_PLP_snr\roc_snr1.mat');
level_snr=1;
%%
method='PTSD';
for i=1:length(parameter)
    for j=1:length(list_PLP)
        eff(j,1)=roc{i,j}.eff;
    end
    EFF(i,:)=eff;
end
make_figure_eff(list_PLP,parameter,EFF,level_snr,method)

%% HADT SNR 1
level_snr=1;
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HADT ANALISI\SOGLIA SECCA VARIABILE\param_RP_snr\MULTI UNIT\roc_snr1.mat')
%% HT VARIABILE SNR 1.15
level_snr=115;
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HADT ANALISI\SOGLIA SECCA VARIABILE\param_RP_snr\MULTI UNIT\roc_snr115.mat')
%% HT VARIABILE SNR 1.3
level_snr=13;
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HADT ANALISI\SOGLIA SECCA VARIABILE\param_RP_snr\MULTI UNIT\roc_snr13.mat')
%%
method='HVT';
for i=1:length(parameter)
    for j=1:length(list_RP)
        eff(j,1)=roc{i,j}.eff;
    end
    EFF(i,:)=eff;
end
make_figure_eff(list_RP,parameter,EFF,level_snr,method)
%% TP/FP FIGURE FOR TIFCO AND SWTTEO
%% SWTTEO 
param1=110;
param2=1e4;   
parameter=linspace(param1,param2,20);
list_snr=[1 13 115];
%%
%% MULTI UNIT SNR 1
path_MU=('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SWTTEO ANALISI\SWTTEO\MULTI UNIT\')
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SINGLE UNIT DA ANALIZZARE\Gamma\g_SNR1.mat')
for i=1:length(parameter)
    load([path_MU '\Parametro ' num2str(parameter(i)) '\s1_1_roc.mat'])
    NCS_snr1(i,1)=roc.tp;
    FP_snr1(i,1)=roc.fp;
    NREF=roc.NREF;
    clear roc
end
% figure, plot(parameter,FP_snr1,'r',parameter,NCS_snr1,'g',parameter, NREF*ones(length(parameter)),'k'), legend('FP','TP','NREF'), title(['NREF = ',num2str(NREF,'%1d') ' Method SWTTEO' ]), xlabel('parameter'), ylabel('N° of spikes')
% clear FP_rate TP_rate XY NCS FP NREF eff

%% MULTI UNIT SNR 1.3
path_MU=('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SWTTEO ANALISI\SWTTEO\MULTI UNIT\')
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SINGLE UNIT DA ANALIZZARE\Gamma\g_SNR1.mat')
for i=1:length(parameter)
    load([path_MU '\Parametro ' num2str(parameter(i)) '\s1_13_roc.mat'])
    NCS_snr13(i,1)=roc.tp;
    FP_snr13(i,1)=roc.fp;
    NREF=roc.NREF;
    clear roc
end
%% MULTI UNIT SNR 1.15
path_MU=('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SWTTEO ANALISI\SWTTEO\MULTI UNIT\')
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\SINGLE UNIT DA ANALIZZARE\Gamma\g_SNR1.mat')
for i=1:length(parameter)
    load([path_MU '\Parametro ' num2str(parameter(i)) '\s1_115_roc.mat'])
    NCS_snr115(i,1)=roc.tp;
    FP_snr115(i,1)=roc.fp;
    NREF=roc.NREF;
    clear roc
end
%%
figure
subplot 121, plot(parameter,NCS_snr1), hold on , plot(parameter,NCS_snr115), plot(parameter,NCS_snr13), plot(parameter, NREF*ones(length(parameter)),'k'), legend('SNR 1','SNR 1.15', 'SNR 1.3'), xlabel('Parameter'), ylabel('N° of spikes'), title(['N° of TP, NREF = ' , num2str(NREF,'%1d')])
subplot 122, plot(parameter,FP_snr1), hold on , plot(parameter,FP_snr115), plot(parameter,FP_snr13), legend('SNR 1','SNR 1.15', 'SNR 1.3'), xlabel('Parameter'), ylabel('N° of spikes'), title('N° of FP ')

