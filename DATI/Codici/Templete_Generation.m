clc, clear all, close all
scelta=input('1-BasalCh1 2-ADSPCh5 3-BasalCh6 4-BasalCh10 \n');
fc=24414;
switch scelta
    case 1
        load ('WD_Ch1_NbasalP1.mat') %samples
        spikes_camp=XY_SelectedSpikes(:,1);
        spikes_s=spikes_camp./fc; %s
        voltage=XY_SelectedSpikes(:,2);
        [spikes,inspection_length_s]= gSpikes(data,spikes_camp,voltage, spikes_s);
    case 2
        load ('WD_Ch5_ADSP1.mat') %ms 
        spikes_s=XY_SelectedSpikes(:,1)./1000; %s
        spikes_camp=spikes_s.*fc;
        voltage=XY_SelectedSpikes(:,2);
        [spikes,inspection_length_s]= gSpikes(data,spikes_camp,voltage, spikes_s);
    case 3
        load ('WD_Ch6_NbasalP1.mat') %ms 
        spikes_s=XY_SelectedSpikes(:,1)./1000; %s
        spikes_camp=spikes_s.*fc;
        voltage=XY_SelectedSpikes(:,2);
        [spikes,inspection_length_s]= gSpikes(data,spikes_camp,voltage, spikes_s);
    case 4
        load ('WD_Ch10_NbasalP2.mat') %samples 
        spikes_camp=XY_SelectedSpikes(:,1);
        spikes_s=spikes_camp./fc; %s
        voltage=XY_SelectedSpikes(:,2);
        [spikes,inspection_length_s]= gSpikes(data,spikes_camp,voltage, spikes_s);
end

%% CLUSTERING
%WD_Ch1_NbasalP1
[allSpikes,class0,class1,class2,class3,class4,class5]=DoClustering(spikes_s,inspection_length_s,spikes)