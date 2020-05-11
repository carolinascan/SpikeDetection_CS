%GenerateSpikesModel v1.0
%Jacopo Tessadori & Alberto Averna 17-07-15

%Input: TimeStamps: in samples
%       spikes: Waves of the TimeStamps (32 samples for example)
%       tLength: Length in samples of the new model of spikes
%       SDnoise: best way to estimate: median(abs(data))/0.6745 where data is a typical raw data 
%Output: SpikesModel:new RawData
%        randSpikePos:position of the spikes in the model [samples]     


function [SpikesModel,randSpikePos]=GenerateSpikesModel(TimeStamps,spikes,tLength,SDnoise)
% Generate template
template=mean(spikes);

% Remove baseline
baseLine=interp1([1,length(template)],[template(1),template(end)],1:length(template));
tmplt=template-baseLine;

% Randomize spike order, preserving ISI hist
spikeDist=diff(TimeStamps);
randSpikeOrder=randperm(length(TimeStamps)-1);
randSpikePos=[TimeStamps(1);cumsum(spikeDist(randSpikeOrder))];
randSpikeTrain=zeros(tLength,1,'single');
randSpikeTrain(randSpikePos)=1;

% Convolve template shape with randomized peak train
b=zeros(tLength,1,'single');
b(1:length(tmplt))=tmplt;
SpikesModel=real(ifft(fft(randSpikeTrain).*fft(b)));

% Add noise
SpikesModel=SpikesModel+randn(length(SpikesModel),1)*SDnoise;

% Correct randSpikePos (i.e. randSpikePos is beginning of template, it
% needs to be peak position instead)
templatePeak=max(max(template),abs(min(template)));
randSpikePos=randSpikePos+find(abs(template)==templatePeak,1,'first')-1;

% Save results
save(['SpikesModel_sd' num2str(SDnoise) '.mat'],'SpikesModel')
save(['SpikesPos_sd' num2str(SDnoise) '.mat'],'randSpikePos')

end