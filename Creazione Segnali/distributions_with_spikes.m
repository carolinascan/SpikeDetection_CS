%% 
clc, clear all, close all
%% WAVEFORM LOADING 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ch6=load('Clustering_Ch6.mat');
Ch6=Ch6.Clustering_Ch6;
%%
ChR1319=load('Clustering_R13.mat');
ChR1319=ChR1319.Clustering_R13;
%%
ChR1308=load('Clustering_R1308.mat');
ChR1308=ChR1308.Clustering_R1308;
%% Channel 6
spike_ch6=Ch6.spikes;
cl0_ch6=Ch6.ZeroCluster;
cl1_ch6=Ch6.FirstCluster;
cl2_ch6=Ch6.SecondoCluster;
%% R13-19
spike_R1319=ChR1319.spikes;
cl1_R1319=ChR1319.FirstCluster;
%% R13-08
spike_R1308=ChR1308.spikes;
cl1_R1308=ChR1308.FirstCluster;
cl2_R1308=ChR1308.SecondCluster;
%% Choose the template 
%% Ch_6
Template0_ch6=spike_ch6(cl0_ch6,:);
Template1_ch6=spike_ch6(cl1_ch6,:);
Template2_ch6=spike_ch6(cl2_ch6,:);
%% R1319
Template1_R1319=spike_R1319(cl1_R1319,:);
%% R1308
Template1_R1308=spike_R1308(cl1_R1308,:);
Template2_R1308=spike_R1308(cl2_R1308,:);
%% EXPONENTIAL DISTRIBUTION
%% 
spikeT_EXPO=expo_matrix.spikeTrain;
[m,n]=size(spikeT_EXPO);
%%
TEMPLATES=NaN(100,max(sum(spikeT_EXPO,2)));
for i=1:100;
[signal_e,idx,template] = Signal_Generator(spikeT_EXPO(i,:),Template0_ch6);
Signal_EXPO(i,:)=signal_e;
TEMPLATES(i,1:length(template))=template;
end
struct_EXPO1_ch6.Templates=TEMPLATES;
struct_EXPO1_ch6.signal=Signal_EXPO;
save('Expo1_ch6_cl0.mat','struct_EXPO1_ch6');
%%
clear i TEMPLATES template struct_EXPO1_ch6 Signal_EXPO signal_e
%%
TEMPLATES=NaN(100,max(sum(spikeT_EXPO,2)));
for i=1:100;
[signal_e,idx,template] = Signal_Generator(spikeT_EXPO(i,:),Template1_R1308);
Signal_EXPO(i,:)=signal_e;
TEMPLATES(i,1:length(template))=template;
end 
struct_EXPO1_R1308.Templates=TEMPLATES;
struct_EXPO1_R1308.signal=Signal_EXPO;
save('Expo1_R1308_cl1.mat','struct_EXPO1_R1308');
%%
clear i TEMPLATES template struct_EXPO1_R1308 Signal_EXPO signal_e
%%
TEMPLATES=NaN(100,max(sum(spikeT_EXPO,2)));
for i=1:100;
[signal_e,idx,template] = Signal_Generator(spikeT_EXPO(i,:),Template2_R1308);
Signal_EXPO(i,:)=signal_e;
TEMPLATES(i,1:length(template))=template;
end 
struct_EXPO2_R1308.Templates=TEMPLATES;
struct_EXPO2_R1308.signal=Signal_EXPO;
save('Expo3_R1308_cl2.mat','struct_EXPO2_R1308');
%%
clear i TEMPLATES template struct_EXPO2_R1308 Signal_EXPO signal_e
%% 
% figure %1e6 from V to microV
% plot(time,Signal_EXPO(98,:)'.*1e6), title('signal'), xlabel('[s]'), ylabel('[microV]'), title('Signal from mean template')

%% GAMMA DISTRIBUTION
%%
spikeT_GAMMA=gamma_matrix.spikeTrain;
[m,n]=size(spikeT_GAMMA);
%%
TEMPLATES=NaN(100,max(sum(spikeT_GAMMA,2)));
for i=1:100;
[signal_g,idx,template] = Signal_Generator(spikeT_GAMMA(i,:),Template0_ch6);
Signal_GAMMA(i,:)=signal_g;
TEMPLATES(i,1:length(template))=template;
end
struct_GAMMA1_ch6.Templates=TEMPLATES;
struct_GAMMA1_ch6.signal=Signal_GAMMA;
save('Gamma1_ch6_cl0.mat','struct_GAMMA1_ch6');
%%
clear i TEMPLATES template struct_GAMMA1_ch6 Signal_GAMMA signal_g
%%
TEMPLATES=NaN(100,max(sum(spikeT_GAMMA,2)));
for i=1:100;
[signal_g,ids,template] = Signal_Generator(spikeT_GAMMA(i,:),Template1_R1308);
Signal_GAMMA(i,:)=signal_g;
TEMPLATES(i,1:length(template))=template;
end
struct_GAMMA1_R1308.Templates=TEMPLATES;
struct_GAMMA1_R1308.signal=Signal_GAMMA;
save('Gamma1_R1308_cl1.mat','struct_GAMMA1_R1308');
%%
clear i TEMPLATES template struct_GAMMA1_R1308 Signal_GAMMA signal_g
%%
TEMPLATES=NaN(100,max(sum(spikeT_GAMMA,2)));
for i=1:100;
[signal_g,idx,template] = Signal_Generator(spikeT_GAMMA(i,:),Template2_R1308);
Signal_GAMMA(i,:)=signal_g;
TEMPLATES(i,1:length(template))=template;
end
struct_GAMMA2_R1308.Templates=TEMPLATES;
struct_GAMMA2_R1308.signal=Signal_GAMMA;
save('Gamma2_R1308_cl2.mat','struct_GAMMA2_R1308');
%%
clear i TEMPLATES template struct_GAMMA2_R1308 Signal_GAMMA signal_g
%% INVERSE GAUSSIAN
%%
spikeT_IG=invgau_matrix.spikeTrain;
[m,n]=size(spikeT_IG);
%% 
TEMPLATES=NaN(100,max(sum(spikeT_IG,2)));
for i=1:100;
[signal_ig,idx,template] = Signal_Generator(spikeT_IG(i,:),Template0_ch6);
Signal_INVGAU(i,:)=signal_ig;
TEMPLATES(i,1:length(template))=template;
end
struct_IG1_ch6.Templates=TEMPLATES;
struct_IG1_ch6.signal=Signal_INVGAU;
save('IG1_ch6_cl0.mat','struct_IG1_ch6');
%%
clear i TEMPLATES template struct_IG1_ch6 Signal_INVGAU signal_ig
%%
TEMPLATES=NaN(100,max(sum(spikeT_IG,2)));
for i=1:100;
[signal_ig,idx,template] = Signal_Generator(spikeT_IG(i,:),Template1_R1308);
Signal_INVGAU(i,:)=signal_ig;
TEMPLATES(i,1:length(template))=template;
end
struct_IG1_R1308.Templates=TEMPLATES;
struct_IG1_R1308.signal=Signal_INVGAU;
save('IG1_R1308_cl1.mat','struct_IG1_R1308');
%%
clear i TEMPLATES template struct_IG1_R1308 Signal_INVGAU signal_ig
%%
TEMPLATES=NaN(100,max(sum(spikeT_IG,2)));
for i=1:100;
[signal_ig,idx,template] = Signal_Generator(spikeT_IG(i,:),Template2_R1308);
Signal_INVGAU(i,:)=signal_ig;
TEMPLATES(i,1:length(template))=template;
end
struct_IG3_R1308.Templates=TEMPLATES;
struct_IG3_R1308.signal=Signal_INVGAU;
save('IG3_R1308_cl2.mat','struct_IG3_R1308');
%%
clear i TEMPLATES template struct_IG3_ch6 Signal_INVGAU signal_ig