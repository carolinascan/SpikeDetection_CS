function sttc=spikeTimeTilingCoefficient(spikeTrain1,spikeTrain2,deltaT)
% Compute the Spike Time Tiling Coefficient (i.e. a measure of pairwise
% correlation independant from spiking rates) between spikeTrain1 and
% spikeTrain2, which must have the same length. The only free parameter is deltaT (i.e. the time interval
% within which two spikes may be considered close).
% The Journal of Neuroscience, October 22, 2014  34(43):14288 –14303
% http://www.jneurosci.org/content/34/43/14288.full.pdf

% Check whether input vectors have the same length
if length(spikeTrain1)~=length(spikeTrain2)
    disp('Input vectors lengths do not match');
    return;
end

% Use frequency-domain linear filtering to compute covered-times
b=zeros(size(spikeTrain1));
b(1:deltaT)=1;
b(end-deltaT+1:end)=1;
B=conj(fft(b));

% Compute covered times through filtering
coveredTime1=real(ifft(fft(spikeTrain1).*B))>.5; %% Prevents problem tied to numerical rounding
coveredTime2=real(ifft(fft(spikeTrain2).*B))>.5;
T1=sum(single(coveredTime1))/length(coveredTime1);
T2=sum(single(coveredTime2))/length(coveredTime2);
P1=sum(single(coveredTime2.*spikeTrain1))/sum(spikeTrain1);
P2=sum(single(coveredTime1.*spikeTrain2))/sum(spikeTrain2);
sttc=.5*((P1-T2)/(1-P1*T2)+(P2-T1)/(1-P2*T1));
end