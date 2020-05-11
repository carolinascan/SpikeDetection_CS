function [SpikePos] = spike_position(X)
[m,n]=size(X);
isi=zeros(n);
for i=1:m
isi=X(i,:);
spike_pos=cumsum(isi);
SpikePos(i,:)=spike_pos;
end 