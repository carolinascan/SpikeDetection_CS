function [spikes,maximum,minimum]= find_min_peaks(segnale,timestamps)
%% segnale=data without noise 
% timestamsp= where the max are located 
nspikes=length(timestamps);
w_pre=16;
w_post=12;
counter=1;
for i=1:nspikes
    if segnale(timestamps(i))>0
        spikes(counter,:)= segnale((timestamps(i)-w_pre-1):(timestamps(i)+w_post+2));
        spikepos(counter,:)=find(min(spikes));
        counter=counter+1;
    else 
        spikepos(counter,:)=timestamps(i);
        counter=counter+1;
    end 
end

