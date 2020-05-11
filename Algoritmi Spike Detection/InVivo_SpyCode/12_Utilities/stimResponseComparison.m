function [PC12,maxXC12,delayXC12,xc12]=stimResponseComparison(spikeTrain1,spikeTrain2,filterType,filterLength)
% [PC12,MAXXC12,DELAYXC12,XC12]=stimResponseComparison(SPIKETRAIN1,SPIKETRAIN2,FILTERTYPE,FILTERLENGTH)
% Computes Pearson's coefficient (PC12), maximum value of cross-correlation
% function (MAXXC12) and its delay  (DELAYXC12)of the two vectors 
% SPIKETRAIN1 and SPIKETRAIN2, after pre-filtering. XC12 is the
% cross-correlation function after pre-filtering.
% SPIKETRAIN1 and SPIKETRAIN2 can actually represent both spikes and
% stimulations. Each entry contains the number of events in a given time
% bin (actual size of each time bin is irrelevant).
% FILTERTYPE can be either 'rectangular' or 'gaussian'. It defines the
% shape of the filter to be applied in the pre-filtering phase. 
% FILTERLENGTH represents the duration, in samples, of the time window used
% for filtering. A  rectangular window of length 200 will extend a pulse 100
% samples before and 99 samples after the position of the actual pulse.
% WARNING: this script cannot support analysis on vectors of arbitrary
% length. If an out-of-memory error occurs, downsample data, or ask me to
% add automatic downsampling before pre-filtering.
% Version 1.0 - by Jacopo Tessadori 27/02/2015


% Generate filter vector. Dimensions have to be compatible with expected
% application. E.g., if testing for network responses to stimulation, a .5
% s wide filter might make sense
if ~exist('filterType','var') %% Defaults to rectangular window if no filterType input is present
    filterType='rectangular';
end
if ~exist('filterLength','var') %% Defaults to 200 sample-wide filter if no filterLength input is present
    filterLength=200;
end
B=zeros(size(spikeTrain1));
switch lower(filterType)
    case 'rectangular'
        B(1:filterLength)=1; % Rectangular window
    case 'gaussian'
        B(1:filterLength)=gausswin(filterLength); % Gaussian window
end
B=B-mean(B); %% Our filter has now zero-mean. It will compensate signal offset
B=B/sum(B); %% Filter has weight = 1, power of signal will not be affected
B=circshift(B,[-round(filterLength/2),0]); %% Need to make so that filter window is centered (i.e. peak should be at sample 1)
B=conj(fft(B)); %% We'll filter in frequency domain. It saves time to compute FFT of filter only once

% Filter stimTrains
fltrdStimTrain1=real(ifft(fft(spikeTrain1).*B));
fltrdStimTrain2=real(ifft(fft(spikeTrain2).*B));

% Brutal downsampling
fltrdStimTrain1=fltrdStimTrain1(1:round(filterLength/10):end);
fltrdStimTrain2=fltrdStimTrain2(1:round(filterLength/10):end);

% Compute normalized cross-correlation
% This is much slower than strictly required. Cross-correlation can be
% computed much faster in frequency domain as well, if required. Let me
% know if you need something faster.
xc12=xcorr(fltrdStimTrain1,fltrdStimTrain2,'coef');

% Recover Pearson's coefficients from cross correlations. It is simply the
% value of normalized cross-correlation at lag 0
PC12=xc12(round(length(fltrdStimTrain1))+1);

% It might make much more sense to retrieve maxima of cross correlations,
% and their delays
maxXC12=max(xc12);
delayXC12=find(xc12==maxXC12,1)-length(fltrdStimTrain1);