%% MULTI-UNIT GENERATION 
clc, clear all, close all

%% % channel 6
e_ch6_cl0=struct_EXPO1_ch6.signal;
e_ch6_cl1=struct_EXPO2_ch6.signal;
e_ch6_cl2=struct_EXPO3_ch6.signal;
g_ch6_cl0=struct_GAMMA1_ch6.signal;
g_ch6_cl1=struct_GAMMA2_ch6.signal;
g_ch6_cl2=struct_GAMMA3_ch6.signal;
i_ch6_cl0=struct_IG1_ch6.signal;
i_ch6_cl1=struct_IG2_ch6.signal;
i_ch6_cl2=struct_IG3_ch6.signal;
%% R1319
e_r1319_cl1=struct_EXPO1_R1319.signal;
g_r1319_cl1=struct_GAMMA1_R1319.signal;
i_r1319_cl1=struct_IG1_R1319.signal;
%% R1308
e_r1308_cl1=struct_EXPO1_R1308.signal;
g_r1308_cl1=struct_GAMMA1_R1308.signal;
i_r1308_cl1=struct_IG1_R1308.signal;
e_r1308_cl2=struct_EXPO2_R1308.signal;
g_r1308_cl2=struct_GAMMA2_R1308.signal;
% i_r1308_cl2=struct_IG3_R1308.signal;
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
caso_e4=randi(100);
caso_e5=randi(100);
caso_e6=randi(100);
caso_g1=randi(100);
caso_g2=randi(100);
caso_g3=randi(100);
caso_g4=randi(100);
caso_g5=randi(100);
caso_g6=randi(100);
caso_ig1=randi(100);
caso_ig2=randi(100);
caso_ig3=randi(100);
caso_ig4=randi(100);
caso_ig5=randi(100);
caso_ig6=randi(100);
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
s10=e_r1319_cl1(caso_e4,:);
s11=e_r1308_cl1(caso_e5,:);
s12=e_r1308_cl2(caso_e6,:);
s13=g_r1319_cl1(caso_g4,:);
s14=g_r1308_cl1(caso_g5,:);
s15=g_r1308_cl2(caso_g6,:);
s16=i_r1319_cl1(caso_ig4,:);
s17=i_r1308_cl1(caso_ig5,:);
% s18=i_r1308_cl2(caso_ig6,:);
%%

S=[s1;s2;s3;s4;s5;s6;s7;s8;s9;s10;s11;s12;s13;s14;s15;s16;s17];
%% 
unit1=randi(18);
unit2=randi(18);
unit3=randi(18);
%% 
S1=S(unit1,:);
S2=S(unit2,:);
S3=S(unit3,:);
%%
loc_spike_s3.Unit1='inverse gaussian row 48 r1308_cl1';
loc_spike_s3.Unit2='inverse gaussian row 39 ch6_cl2';
loc_spike_s3.Unit3='exponential row 31 ch6_cl1';
loc_spike_s3.segnaleUnit1=S1;
loc_spike_s3.segnaleUnit2=S2;
loc_spike_s3.segnaleUnit3=S3;

%%
segnale=S1+S2+S3;
data=segnale; %microV
save('signal3.mat','data')
%% 
t=[1:length(s1)].*(1/24414);
%%
figure
plot(t,segnale), title('multi-unit simulation'), xlabel('Time[s]'),ylabel('Voltage[V]')

%%
deltaexpo=expo_matrix.spikeTrain;
deltagamma=gamma_matrix.spikeTrain;
deltaig=invgau_matrix.spikeTrain;
%%
dove1=find(deltaig(caso_ig5,:));
dove2=find(deltaig(caso_ig3,:));
dove3=find(deltaexpo(caso_e2,:));
dove_c=[dove1 dove2 dove3];
loc_spike_s3.unit1=dove1;
loc_spike_s3.unit2=dove2;
loc_spike_s3.unit3=dove3;
dove_sort_samples=sort(dove_c); %campioni
dove_sort_s=dove_sort_samples./24414;
save('loc_spike_s3.mat','loc_spike_s3')

%%
dove1=loc_spike_s1.unit1;
dove2=loc_spike_s1.unit2;
dove3=loc_spike_s1.unit3;
dove_c=[dove1 dove2 dove3];
dove_sort_samples=sort(dove_c);
dove_sort_s=dove_sort_samples./24414;
%% CHECK IF MULTI-UNIT IS CORRECT
%%
[spikes,inspection_length_s,mfr]= gSpikes(data,dove_sort_samples,data,dove_sort_s);
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
