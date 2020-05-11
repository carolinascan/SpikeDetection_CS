clc, clear all, close all
%%

param1=3;
param2=9;
load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\SNR_param.mat');
list_snr=SNR_param(:,1);
list_param=linspace(param1,param2,10);

%% Change the current folder to the folder of this m-file.
list_noise=1:10;
mkdir('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\THRESH_VECTOR\TV_V2')
for i=1:length(list_snr)
    for j=1:length(list_param)
    load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\RUMORI v2\N' num2str(list_noise(j)) '\N' num2str(list_noise(j)) '_FilteredData\N' num2str(list_noise(j)) '_Mat_Files\' num2str(list_noise(j)) '\noise.mat']);
    thresh_vector= std(data)*list_param(j);
    save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Dati\THRESH_VECTOR\TV_V2\thresh_vector_param' num2str(list_param(j)) '_snr' num2str(list_snr(i)) '.mat'], 'thresh_vector')
    end 
end 