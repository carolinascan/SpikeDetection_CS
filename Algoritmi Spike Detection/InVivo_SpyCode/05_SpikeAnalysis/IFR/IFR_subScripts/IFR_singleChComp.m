function [IFRTrace, binWidth] = IFR_singleChComp(peakTrain, commonParam, computParam)
% modified by Alberto Averna Feb 2015 for InVivo exp
numSamples = length(peakTrain);
acqTime = numSamples/commonParam.sf;
mfr = calcMFR(peakTrain,acqTime,computParam.spikingThreshold);
if mfr~=0
    if(computParam.autoAdjFlag)
        kernelWidth_samples = round((1/(computParam.mfrMultFactor*mfr))*commonParam.sf);    % [sample]
    else
        kernelWidth_samples = computParam.kernelWidth*1e-3*commonParam.sf;      % [sample]
    end
    % kernelWidth must be odd
    if ~rem(kernelWidth_samples,2)
        kernelWidth_samples = kernelWidth_samples+1;
    end
    if strcmp(computParam.selectedKernel_string,'rectangular')
        kernel = rectwin(kernelWidth_samples);
    else if strcmp(computParam.selectedKernel_string,'gaussian')
            kernel = gausswin(kernelWidth_samples);
        end
    end
    % normalize kernel
    kernel = kernel./sum(kernel);
    % only 0s and 1s
    peakTrain = spones(peakTrain);
    IFRTrace = sparseconv(peakTrain,kernel);
    semiWindow = (kernelWidth_samples-1)/2;
    IFRTrace = IFRTrace(semiWindow+1:end-(semiWindow-1));
    % now IFR is in spikes/sample --> I have to multiply it by commonParam.sf
    IFRTrace = IFRTrace*commonParam.sf;
    if computParam.undersamplingFactor==1
        IFRTrace = sparse(IFRTrace);
    else
        IFRTrace = sparse(IFRTrace(computParam.undersamplingFactor:computParam.undersamplingFactor:end));
    end
    binWidth = kernelWidth_samples/commonParam.sf*1e+3;
else
    IFRTrace = zeros(floor(numSamples/computParam.undersamplingFactor),1);
    binWidth = 0;
    return
end



