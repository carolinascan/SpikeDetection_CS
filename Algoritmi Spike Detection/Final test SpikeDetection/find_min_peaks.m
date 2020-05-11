function [spikepos]= find_min_peaks(segnale,timestamps)
%% segnale=data without noise 
% timestamsp= where the max are located 
nspikes=length(timestamps);
w_pre=16;
w_post=12;
counter=1;
for i=1:nspikes-1
    if segnale(timestamps(i))>0
        spikepos(counter,:)=find(segnale==min(segnale((timestamps(i)-w_pre-1):(timestamps(i)+w_post+2))));
        counter=counter+1;
    else 
        spikepos(counter,:)=timestamps(i);
        counter=counter+1;
    end 
end

