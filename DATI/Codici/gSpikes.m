function [spikes]= gSpikes(data,spikes_camp,voltage, spikes_s)
%% Extracting main features 
fc=24414; %samples/s
timestamps=spikes_camp; %samples
time_s=[0:length(data)-1]'./fc; %s 
inspection_length_s=spikes_s(end); %s
nspikes=size(timestamps,1); %number of spikes
mfr_inspected_hz=nspikes/inspection_length_s; %Hz

%% creazione della matrice tlength x 32 che rappresenta gli spikes
w_pre=16;
w_post=12;
spikes=zeros(nspikes,32);
for i=17:nspikes                 
    spikes(i,:) = data((timestamps(i)-w_pre-1):(timestamps(i)+w_post+2)); %campioni
end 
%% Figure 
figure
plot(time_s,data), hold on
plot(spikes_s,voltage,'*r'), title('Dati con spike da visual inspection'), xlabel('s'), ylabel('microV')
figure
plot(spikes'), title('spikes'), xlabel('samples'), ylabel('microV')
end

