function [spikepos] = ht(signal,parameter,rumore)
noise=rumore.data;
std_noise=std(noise);
threshold=-parameter*std_noise;
counter=1;
%refractory period
rp=24;
tj=[];
%% find everything that overcomes the threshold 
ts=find(signal<threshold);
%% respect refractory period
for j=1:length(ts)-1
    if  (ts(j+1)-ts(j))>rp %if it is after the refractory period
        tj(counter,:)=ts(j+1);
        counter=counter+1;
    end
end
%%  
if isempty(ts)
    spikepos=[];
else
    TS=[ts(1), tj'];
    spikepos=TS;
end
%% Find the nearest minimum of the signal
%     w_pre=16;
%     w_post=12;
%     if isempty(TS(2:end))
%         spikepos=[];
%     else
%         for i=2:length(TS)
%             spikepos(i,:)=find(signal==min(signal((TS(i)-w_pre-1):(TS(i)+w_post+2))));
%         end
%     end
% end
end

