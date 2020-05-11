function [spikes,maximum,minimum]= width_peaks(segnale,timestamps)
%% segnale=data without noise 
% timestamsp= where the max are located 
nspikes=length(timestamps);
w_pre=16;
w_post=12;
counter=1;
for i=1:nspikes               
    spikes(counter,:)= segnale((timestamps(i)-w_pre-1):(timestamps(i)+w_post+2));
    maximum(counter,:)=max(spikes(counter,:));
    minimum(counter,:)=min(spikes(counter,:));
    counter=counter+1;
end 
end

