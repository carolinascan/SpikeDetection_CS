clc, clear all, close all
%% 
fc=24414;
%% WD_Ch6_Nbasal
% load ('WD_Ch6_NbasalP1.mat') %ms
spiketime_s=XY_SelectedSpikes(:,1)./1000; %s
spikes_camp=spiketime_s.*fc;
voltage=XY_SelectedSpikes(:,2).*1e6; %microV
matrix=[spikes_camp voltage]; %samples,microV
[XYcorrected] = match_spikes_fromVI(matrix,data.*1e6); %samples 
ts=XYcorrected(:,1);
v=XYcorrected(:,2);
spikes_camp_corrected=ts((~isnan(ts)));
voltage_microV=v((~isnan(v)));
spiketime_s_corrected=spikes_camp_corrected./24414; 
[spikes,inspection_length_s,mfr]= gSpikes(data.*1e6,spikes_camp_corrected,voltage_microV, spiketime_s_corrected);
%% Alberto_VI R13-19 B1_01_nbasal_0001_02
[XYcorrected_2] = match_spikes_fromVI(XY_SelectedSpikes,data);
ts=XYcorrected_2(:,1);
v=XYcorrected_2(:,2);
spikes_camp_corrected=ts((~isnan(ts)));
voltage_microV=v((~isnan(v)));
spiketime_s=spikes_camp_corrected./24414;
[spikes,inspection_length_s,mfr]= gSpikes(data,spikes_camp_corrected,voltage_microV, spiketime_s);
%% R13-19
[R13_allSpikes,R13_class0,R13_class1,R13_class2,R13_class3,R13_class4,R13_class5]=DoClustering(spiketime_s',inspection_length_s,spikes); 
Clustering_R13.spikes=R13_allSpikes;
Clustering_R13.ZeroCluster=R13_class0;
Clustering_R13.FirstCluster=R13_class1;
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_CS\Figures\Waveforms\Clustering_R13.mat','Clustering_R13');
%%
figure, plot(R13_allSpikes(R13_class1,:)'), title('R13 class 1'), xlabel('Samples'), ylabel('Voltage [microV]')
M_R1319=mean(R13_allSpikes(R13_class1,:))';
figure, plot(M_R1319) , title('R13 Mean waveforms')

%% WD_Ch6_NbasalP1
[ch6_allSpikes,ch6_class0,ch6_class1,ch6_class2,ch6_class3,ch6_class4,ch6_class5]=DoClustering(spiketime_s',inspection_length_s,spikes); 
%%
Clustering_Ch6.spikes=ch6_allSpikes;
Clustering_Ch6.ZeroCluster=ch6_class0;
Clustering_Ch6.FirstCluster=ch6_class1;
Clustering_Ch6.SecondoCluster=ch6_class2;
save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_CS\Figures\Waveforms\Clustering_Ch6.mat','Clustering_Ch6');

%% R13-08 
[XYcorrected_2] = match_spikes_fromVI(XY_SelectedSpikes,data)
ts=XYcorrected_2(:,1);
v=XYcorrected_2(:,2);
spikes_camp_corrected=ts((~isnan(ts)));
voltage_microV=v((~isnan(v)));
spiketime_s=spikes_camp_corrected./24414;
[spikes,inspection_length_s,mfr]= gSpikes(data,spikes_camp_corrected,voltage_microV, spiketime_s);
%%
[R1308_allSpikes,R1308_class0,R1308_class1,R1308_class2,R1308_class3,R1308_class4,R1308_class5]=DoClustering(spiketime_s',inspection_length_s,spikes); 
%%
Clustering_R1308.spikes=R1308_allSpikes;
Clustering_R1308.ZeroCluster=R1308_class0;
Clustering_R1308.FirstCluster=R1308_class1;
Clustering_R1308.SecondCluster=R1308_class2;
% save('C:\Users\Carolina\Documents\GitHub\SpikeDetection_CS\Figures\Waveforms\Clustering_R1308.mat','Clustering_R1308');
%%
figure, plot(R1308_allSpikes(R1308_class1,:)'), title('R1308 class 1'), xlabel('Samples'), ylabel('Voltage [microV]')
figure, plot(R1308_allSpikes(R1308_class2,:)'), title('R1308 class 2'), xlabel('Samples'), ylabel('Voltage [microV]')
M_1308_1=mean(R1308_allSpikes(R1308_class1,:))';
M_1308_2=mean(R1308_allSpikes(R1308_class2,:))';
figure, plot(M_1308_1), hold on, plot(M_1308_2) , legend('1','2'), title('R1308 Mean waveforms')

% figure, plot(R1308_allSpikes(R1308_class0,:)'), title('class 0')


%% figure 
% figure, plot(mean(ch6_allSpikes(ch6_class2,:))'),hold on, plot(mean(ch6_allSpikes(ch6_class1,:))'), plot(mean(ch6_allSpikes(ch6_class2,:))'), plot(mean(ch6_allSpikes(ch6_class0,:))')
figure, plot(ch6_allSpikes(ch6_class1,:)'), title('Ch6 class 1'), xlabel('Samples'), ylabel('Voltage [microV]')
figure, plot(ch6_allSpikes(ch6_class2,:)'), title('Ch6 class 2'), xlabel('Samples'), ylabel('Voltage [microV]')
figure, plot(ch6_allSpikes(ch6_class0,:)'), title('Ch6 class 0'), xlabel('Samples'), ylabel('Voltage [microV]')

M_CH6_1=mean(ch6_allSpikes(ch6_class1,:))'
M_CH6_2=mean(ch6_allSpikes(ch6_class2,:))'
M_CH6_0=mean(ch6_allSpikes(ch6_class0,:))'
figure, plot(M_CH6_1), hold on, plot(M_CH6_2), plot(M_CH6_0), legend('1','2','0'), title('Ch6 Mean waveforms')

%% CHECK ISI DISTRIBUTION
%% Recording R13
[isi_R13_cl0_s,isi_R13_cl1_s,isi_R13_cl2_s]=check_isi_distribution(R13_class0,R13_class1,1);
figure, histogram(isi_R13_cl1_s,'Normalization','probability')
% edges=[1:(1/1000)*24414:length(data)];
%% Recording Ch6
[isi_ch6_cl0_s,isi_ch6_cl1_s,isi_ch6_cl2_s]=check_isi_distribution(ch6_class0,ch6_class1,ch6_class2);
figure
subplot 131,histogram(isi_ch6_cl0_s,'Normalization','probability'), title('distribuzione ch6 cl0')
subplot 132,histogram(isi_ch6_cl1_s,'Normalization','probability'), title('distribuzione ch6 cl1')
subplot 133, histogram(isi_ch6_cl2_s,'Normalization','probability'), title('distribuzione ch6 cl2')
% %% channel 10
% [isi_ch10_cl0,isi_ch10_cl1_s,isi_ch10_cl2_s]=check_isi_distribution(1,ch10_class1,1);
% figure
% histogram(isi_ch10_cl1_s,'Normalization','probability'), title('distribuzione ch1 cl1')
%% ALL mean waveforms
figure 
plot(M_CH6_1), hold on, plot(M_CH6_2), plot(M_CH6_0)
plot(M_1308_1), plot(M_1308_2)
plot(M_R1319)
legend('CH6-1','CH6-2','CH6-0','R1308-1','R1308-2','R1319')