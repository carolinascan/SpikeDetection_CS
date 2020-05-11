function [spikes,inspection_length_s,mfr]= gSpikes(data,spikes_camp,voltage,spikes_s)
%% Extracting main features 
fc=24414; %samples/s
timestamps=spikes_camp'; %samples
time_s=[0:length(data)-1]'./fc; %s 
inspection_length_s=spikes_s(end); %s
nspikes=length(timestamps); %number of spikes
mfr=nspikes/inspection_length_s; %spikes/s

%% creazione della matrice tlength x 32 che rappresenta gli spikes
w_pre=16;
w_post=12;
% spikes=zeros(nspikes,32);
counter=1;
for i=2:nspikes-1               
    spikes(counter,:)= data((timestamps(i)-w_pre-1):(timestamps(i)+w_post+2));%campion
    counter=counter+1;
end 
%% Figure 
% last=length(data)/fc;
% figure
% plot(time_s,data), hold on
% plot(spikes_s,voltage,'*r'), title('Dati con spike da visual inspection'), xlabel('s'), ylabel('V'), xlim([0 last]) 
% figure
% plot(spikes), title('spikes'), xlabel('samples'), ylabel('V')
end

