function [SpikePos] = spike_position(X)
%This function makes the cumulative sum of the spike times in order to get the consecutive time instants  
[m,n]=size(X); 
for i=1:m
isi=X(i,:);
spike_pos=cumsum(isi);
SpikePos(i,:)=spike_pos;
end 
end 