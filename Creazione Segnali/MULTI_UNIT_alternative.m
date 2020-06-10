%% ora prima estraggo le 3 righe di distribuzioni con MFR scelto da me e poi ci sovrappongo randomicamente i 70 template
%% MFR minimo
min_ig=invgau_matrix.spikeTrain(1,:);
min_g=gamma_matrix.spikeTrain(100,:);
min_e=expo_matrix.spikeTrain(1,:);
MU_min=min_ig+min_g+min_e;

%%
% for j=1:64
%     load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_CS\DATI\VISUAL INSPECTION\newTemplate_',num2str(j),'.mat']);
% end 
%%
T_1=Spikes(randi(64)).wave;
T_2=Spikes(randi(64)).wave;
T_3=Spikes(randi(64)).wave;
%%
TEMPLATE=[T_1;T_2;T_3];
%% 
 [signal,ts,templates] = Signal_Generator(MU_min,TEMPLATE) ;
 %%
%  for k=1:length(templates,2);
%      if templates(k)<