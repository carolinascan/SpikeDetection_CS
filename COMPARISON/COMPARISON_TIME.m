clc, clear all, close all
%% HT
TIME_HT=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\HT\SINGLE UNIT V2\timestamps_all_andtime.mat');
figure
imagesc(TIME_HT.elapsed_time(:,:)), colorbar
xlabel('MultCoeff'), ylabel('SNR'), title('Time [s]')
yticklabels({'0.82' '0.57' '0.43' '0.35' '0.29' '0.25' '0.22' '0.20' '0.18' '0.16'})

%% HTLM
TIME_HTLM= load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HTLM ANALISI\HTLM\SINGLE UNIT V2\timestamps_all_andtime.mat');
figure
imagesc(TIME_HTLM.elapsed_time(:,:)), colorbar
xlabel('MultCoeff'), ylabel('SNR'), title('Time [s]')
yticklabels({'0.82' '0.57' '0.43' '0.35' '0.29' '0.25' '0.22' '0.20' '0.18' '0.16'})
%% ATLM
TIME_ATLM=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\ATLM ANALISI\ATLM\SINGLE UNIT V2\timestamps_found_all.mat');
mid=TIME_ATLM.elapsed_time;
mid_5=mid(:,1,:);
figure
imagesc(mid_5(:,:)), colorbar
xlabel('MultCoeff'), ylabel('SNR'), title('Time [s]')
yticklabels({'0.82' '0.57' '0.43' '0.35' '0.29' '0.25' '0.22' '0.20' '0.18' '0.16'})

%% PTSD
TIME_PTSD_FIRST= load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\SINGLE UNIT V2\timestamps_firstHalf_all_andtime.mat');
TIME_PTSD_SECOND=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\SINGLE UNIT V2\timestamps_secondoHalf_all_andtime.mat');
%%
mid1=TIME_PTSD_FIRST.elapsed_time;
mid2=TIME_PTSD_SECOND.elapsed_time;

%%
mid_p=mid1(:,5,:);
mid_p2=mid2(:,5,:);
figure
subplot 121
imagesc(mid_p(:,:)); colorbar 
ylabel('MultCoeff'), xlabel('SNR'), title('Time [s]')
xticklabels({'0.82' '0.57' '0.43' '0.35' '0.29'})
yticklabels({'3' '4.4' '5.8' '7.3' '8.7' '10.2' '11.6' '13.1' '14.5' '16'})
subplot 122
imagesc(mid_p2(:,:)); colorbar
ylabel('MultCoeff'), xlabel('SNR'), title('Time [s]')
xticklabels({'0.25' '0.22' '0.20' '0.18' '0.16'})
yticklabels({'3' '4.4' '5.8' '7.3' '8.7' '10.2' '11.6' '13.1' '14.5' '16'})

%% SWTTEO
TIME_SWTTEO=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SWTTEO ANALISI\SWTTEO\SINGLE UNIT V2\timestamps_all_andtime.mat');
figure
imagesc(TIME_SWTTEO.elapsed_time(:,:)), colorbar
xlabel('MultCoeff'), ylabel('SNR'), title('Time [s]')
yticklabels({'0.82' '0.57' '0.43' '0.35' '0.29' '0.25' '0.22' '0.20' '0.18' '0.16'})
%% SNEO
TIME_SNEO=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SNEO ANALISI\SNEO\SINGLE UNIT V2\timestamps_found_all.mat');
mid=TIME_SNEO.elapsed_time;
mid_5=mid(:,1,:);
figure
imagesc(mid_5(:,:)), colorbar
xlabel('MultCoeff'), ylabel('SNR'), title('Time [s]')
yticklabels({'0.82' '0.57' '0.43' '0.35' '0.29' '0.25' '0.22' '0.20' '0.18' '0.16'})
%% TIFCO
TIME_TIFCO=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\TIFCO\SINGLE UNIT V2\timestamps_all_andtime.mat');
figure
imagesc(TIME_TIFCO.elapsed_time(:,:)), colorbar
xlabel('MultCoeff'), ylabel('SNR'), title('Time [s]')
yticklabels({'0.82' '0.57' '0.43' '0.35' '0.29' '0.25' '0.22' '0.20' '0.18' '0.16'})
%% PTSD MODIFIED
TIME_PTSDMOD= load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD MODIFICATO ANALISI\PTSD MODIFICATO\SINGLE UNIT\timestamps_found_all_andtime.mat');
mid=TIME_PTSDMOD.elapsed_time;
mid_5=mid(:,1,:);
figure
imagesc(mid_5(:,:)), colorbar
xlabel('MultCoeff'), ylabel('SNR'), title('Time [s]')
yticklabels({'0.82' '0.57' '0.43' '0.35' '0.29' '0.25' '0.22' '0.20' '0.18' '0.16'})


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MULTI UNIT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HT
TIME_HT=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\HT\MULTI UNIT V2\timestamps_all_andtime.mat');
figure
imagesc(TIME_HT.elapsed_time(:,:)), colorbar
xlabel('MultCoeff'), ylabel('SNR'), title('Time')
yticklabels({'0.82' '0.57' '0.43' '0.35' '0.29' '0.25' '0.22' '0.20' '0.18' '0.16'})
%% HTLM
TIME_HTLM= load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HTLM ANALISI\HTLM\MULTI UNIT V2\timestamps_all_andtime.mat');
figure
imagesc(TIME_HTLM.elapsed_time(:,:)), colorbar
xlabel('MultCoeff'), ylabel('SNR'), title('Time [s]')
yticklabels({'0.82' '0.57' '0.43' '0.35' '0.29' '0.25' '0.22' '0.20' '0.18' '0.16'})
%% ATLM
TIME_ATLM=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\ATLM ANALISI\ATLM\MULTI UNIT V2\timestamps_found_all.mat');
mid=TIME_ATLM.elapsed_time;
mid_5=mid(:,1,:);
figure
imagesc(mid_5(:,:)), colorbar
xlabel('MultCoeff'), ylabel('SNR'), title('Time [s]')
yticklabels({'0.82' '0.57' '0.43' '0.35' '0.29' '0.25' '0.22' '0.20' '0.18' '0.16'})

%% PTSD
TIME_PTSD_FIRST= load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\MULTI UNIT V2\timestamps_firstHalf_all_andtime.mat');
TIME_PTSD_SECOND=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\MULTI UNIT V2\timestamps_secondoHalf_all_andtime.mat');
mid1=TIME_PTSD_FIRST.elapsed_time;
mid2=TIME_PTSD_SECOND.elapsed_time;
MID=[mid1 mid2];
%%
%%
mid1=TIME_PTSD_FIRST.elapsed_time;
mid2=TIME_PTSD_SECOND.elapsed_time;

%%
mid_p=mid1(:,5,:);
mid_p2=mid2(:,5,:);
figure
subplot 121
imagesc(mid_p(:,:)); colorbar 
ylabel('MultCoeff'), xlabel('SNR'), title('Time [s]')
xticklabels({'0.82' '0.57' '0.43' '0.35' '0.29'})
yticklabels({'3' '4.4' '5.8' '7.3' '8.7' '10.2' '11.6' '13.1' '14.5' '16'})
subplot 122
imagesc(mid_p2(:,:)); colorbar
ylabel('MultCoeff'), xlabel('SNR'), title('Time [s]')
xticklabels({'0.25' '0.22' '0.20' '0.18' '0.16'})
yticklabels({'3' '4.4' '5.8' '7.3' '8.7' '10.2' '11.6' '13.1' '14.5' '16'})

%% SWTTEO
TIME_SWTTEO=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SWTTEO ANALISI\SWTTEO\MULTI UNIT V2\timestamps_all_andtime.mat');
figure
imagesc(TIME_SWTTEO.elapsed_time(:,:)), colorbar
xlabel('MultCoeff'), ylabel('SNR'), title('Time [s]')
yticklabels({'0.82' '0.57' '0.43' '0.35' '0.29' '0.25' '0.22' '0.20' '0.18' '0.16'})
%% SNEO
TIME_SNEO=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SNEO ANALISI\SNEO\MULTI UNIT V2\timestamps_found_all.mat');
mid=TIME_SNEO.elapsed_time;
mid_5=mid(:,1,:);
figure
imagesc(mid_5(:,:)), colorbar
xlabel('MultCoeff'), ylabel('SNR'), title('Time [s]')
yticklabels({'0.82' '0.57' '0.43' '0.35' '0.29' '0.25' '0.22' '0.20' '0.18' '0.16'})
%% TIFCO
TIME_TIFCO=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\TIFCO\MULTI UNIT V2\timestamps_all_andtime.mat');
figure
imagesc(TIME_TIFCO.elapsed_time(:,:)), colorbar
xlabel('MultCoeff'), ylabel('SNR'), title('Time [s]')
yticklabels({'0.82' '0.57' '0.43' '0.35' '0.29' '0.25' '0.22' '0.20' '0.18' '0.16'})
%% PTSD MODIFIED
TIME_PTSDMOD= load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD MODIFICATO ANALISI\PTSD MODIFICATO\MULTI UNIT\timestamps_found_all_andtime.mat');
% mid=TIME_PTSDMOD.elapsed_time;
mid_5=TIME_PTSDMOD.elapsed_time(:,1,:);
figure
imagesc(mid_5(:,:)), colorbar
xlabel('MultCoeff'), ylabel('SNR'), title('Time [s]')
yticklabels({'0.82' '0.57' '0.43' '0.35' '0.29' '0.25' '0.22' '0.20' '0.18' '0.16'})

