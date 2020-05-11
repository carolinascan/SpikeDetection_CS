function [MAT] = DELTA_TRAIN(spike_position,desired_length)     
%this function compares a time buffer vector with the spikes times
%X=samples matrix of the spikes positions
spike_pos_camp=spike_position.*24414; %spike position in samples 
samples=desired_length*24414;
% massimo=max(max(X));
camp=linspace(1,desired_length*24414,samples); 
M=zeros(1,length(camp));
[m,n]=size(spike_pos_camp);
for i=1:m                   %this loop searches for the same values in the spike positions matrix and in the samples vector 
    row=round(spike_pos_camp(i,:));
    M=ismember(camp,row);
%       M(round(X(i,:)))=1;
    MAT(i,:)=M;
end 
end 
