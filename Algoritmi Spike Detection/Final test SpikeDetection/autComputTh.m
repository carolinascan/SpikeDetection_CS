function th = autComputTh(data,sf,multCoeff)
nSamples = length(data);
nWin = 30;
winDur = 200*1e-3;
winDur_samples = winDur.*sf;
startSample = 1:(floor(nSamples/nWin)):nSamples;
endSample = startSample+winDur_samples-1;

last_sample_win=nSamples-endSample(nWin-1);
endSample(nWin) = endSample(nWin-1)+last_sample_win;
th = 100;
for ii = 28:nWin
%     
%     if endSample(ii)>length(data)
%         continue;
%     end
CW=startSample(ii):min(endSample(ii),nSamples);
    thThis = std(data(CW));
    if th > thThis
        th = thThis;
    end
end
th = th.*multCoeff;



