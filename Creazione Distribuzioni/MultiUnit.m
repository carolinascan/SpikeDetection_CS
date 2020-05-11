%% MULTI-UNIT GENERATION 
clc, clear all, close all
%% 
%% CHANNEL 6
expo_ch6_cl0=load('Expo_ch6_cl0.mat');
expo_ch6_cl1=load('Expo_ch6_cl1.mat');
expo_ch6_cl2=load('Expo_ch6_cl2.mat');

gamma_ch6_cl0=load('Gamma_ch6_cl0.mat');
gamma_ch6_cl1=load('Gamma_ch6_cl1.mat');
gamma_ch6_cl2=load('Gamma_ch6_cl2.mat');

ig_ch6_cl0=load('IG_ch6_cl0.mat');
ig_ch6_cl1=load('IG_ch6_cl1.mat');
ig_ch6_cl2=load('IG_ch6_cl2.mat');

%%
clear expo_ch1_cl1 expo_ch1_cl2  expo_ch5_cl1 expo_ch5_cl2  expo_ch6_cl1 expo_ch6_cl2  expo_ch6_cl0 expo_ch10_cl1
clear gamma_ch1_cl1 gamma_ch1_cl2 gamma_ch5_cl1 gamma_ch5_cl2 gamma_ch6_cl0 gamma_ch6_cl1 gamma_ch6_cl2 gamma_ch10_cl1
clear ig_ch1_cl1 ig_ch1_cl2 ig_ch5_cl1 ig_ch5_cl2 ig_ch6_cl0 ig_ch6_cl1 ig_ch6_cl2 ig_ch10_cl1 
%% 
% channel 1
% e_ch1_cl1=expo_ch1_cl1.Signal_EXPO1;
% e_ch1_cl2=expo_ch1_cl2.Signal_EXPO2;
% g_ch1_cl1=gamma_ch1_cl1.Signal_GAMMA1;
% g_ch1_cl2=gamma_ch1_cl2.Signal_GAMMA2;
% % i_ch1_cl1=ig_ch1_cl1.Signal_INVGAU;
% % i_ch1_cl2=ig_ch1_cl2.Signal_INVGAU;

%% % channel 6
e_ch6_cl0=expo_ch6_cl0.struct_EXPO1.signal;
e_ch6_cl1=expo_ch6_cl1.struct_EXPO2.signal;
e_ch6_cl2=expo_ch6_cl2.struct_EXPO3.signal;
g_ch6_cl0=gamma_ch6_cl0.struct_GAMMA1.signal;
g_ch6_cl1=gamma_ch6_cl1.struct_GAMMA2.signal;
g_ch6_cl2=gamma_ch6_cl2.struct_GAMMA3.signal;
i_ch6_cl0=ig_ch6_cl0.struct_IG1.signal;
i_ch6_cl1=ig_ch6_cl1.struct_IG2.signal;
i_ch6_cl2=ig_ch6_cl2.struct_IG3.signal;

%%
clear e_ch1_cl1  e_ch1_cl2  e_ch5_cl1  e_ch5_cl2  e_ch6_cl0  e_ch6_cl1  e_ch6_cl2  e_ch10_cl1 
%%
clear g_ch1_cl1 g_ch1_cl2 g_ch5_cl1 g_ch5_cl2 g_ch6_cl0 g_ch6_cl1 g_ch6_cl2 g_ch10_cl1
%% 
clear i_ch1_cl1 i_ch1_cl2  i_ch5_cl1  i_ch5_cl2 i_ch6_cl0 i_ch6_cl1 i_ch6_cl2 i_ch10_cl1  
%% 
caso_e1=randi(100);
caso_e2=randi(100);
caso_e3=randi(100);
caso_g1=randi(100);
caso_g2=randi(100);
caso_g3=randi(100);
caso_ig1=randi(100);
caso_ig2=randi(100);
caso_ig3=randi(100);
%% 3 unit
s1=e_ch6_cl0(caso_e1,:);
s2=e_ch6_cl1(caso_e2,:);
s3=e_ch6_cl2(caso_e3,:);
s4=g_ch6_cl0(caso_g1,:);
s5=g_ch6_cl1(caso_g2,:);
s6=g_ch6_cl2(caso_g3,:);
s7=i_ch6_cl0(caso_ig1,:);
s8=i_ch6_cl1(caso_ig2,:);
s9=i_ch6_cl2(caso_ig3,:);

%%

S=[s1;s2;s3;s4;s5;s6;s7;s8;s9];
%% 
unit1=randi(9);
unit2=randi(9);
unit3=randi(9);
%% 
S1=S(unit1,:);
S2=S(unit2,:);
S3=S(unit3,:);
%%
segnale=S1+S2+S3;
data=segnale.*1e6;
save('signal_1.mat','segnale')
save('signal_1microV.mat','data')
%% 
t=[0:length(s1)-1].*(1/24414);
%%
figure
plot(t,segnale), title('signal simulation'), xlabel('Time[s]'),ylabel('Voltage[V]')
%%
dt_expo=load('expo_matrix.mat');
dt_gamma=load('gamma_matrix.mat');
dt_ig=load('ig_matrix.mat');
%%
deltaexpo=dt_expo.expo_matrix.spikeTrain;
deltagamma=dt_gamma.gamma_matrix.spikeTrain;
deltaig=dt_ig.invgau_matrix.spikeTrain;
save('struct_expo_segnale1.mat','deltaexpo');
save('struct_gamma_segnale1.mat','deltagamma');
save('struct_ig_segnale1.mat','deltaig');
%%
dove1=find(deltagamma(caso_g1,:));
dove2=find(deltaexpo(caso_e2,:));
dove3=find(deltagamma(caso_g2,:));
dove_c=[dove1 dove2 dove3];
loc_spike.unit1=dove1;
loc_spike.unit2=dove2;
loc_spike.unit3=dove3;
dove_sort_samples=sort(dove_c); %campioni
dove_sort_s=dove_sort_samples./24414;
save('loc_spike_s1.mat','loc_spike')
%%
[spikes,inspection_length_s,mfr]= gSpikes(segnale,dove_sort_samples,segnale,dove_sort_s);
%%
figure, plot(spikes')
%% 
[allSpikes,class0,class1,class2,class3,class4,class5]=DoClustering(dove_sort_s,inspection_length_s,spikes);
%%
figure, plot(allSpikes(class0,:)'), title('class 0')
figure, plot(allSpikes(class1,:)'), title('class 1')
figure, plot(allSpikes(class2,:)'), title('class 2')
figure, plot(allSpikes(class3,:)'), title('class 3')
figure, plot(allSpikes(class4,:)'), title('class 4')
figure, plot(allSpikes(class5,:)'), title('class 5')
%%
% figure, plot(mean(allSpikes(class0,:))'), title('Mean waveforms found'), ylabel('Voltage[V]'), xlabel('samples')
% hold on, plot(mean(allSpikes(class1,:))'), 
%  plot(mean(allSpikes(class2,:))'),
%  plot(mean(allSpikes(class3,:))'),
%  plot(mean(allSpikes(class4,:))'), 
%  plot(mean(allSpikes(class5,:))'),
%  legend ('0','1','2','3','4','5')
% %%
% sovrapp12=sum(ismember(dove1,dove2));
% sovrapp23=sum(ismember(dove2,dove3));
% sovrapp13=(ismember(dove1,dove3));
% find(sovrapp13)
%% 
