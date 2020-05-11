clear
close all
clc

%% Change the current folder to the folder of this m-file.
if(~isdeployed)
    cd(fileparts(which(mfilename)));
end
load('data_noise_snr1.mat')

data= data-mean(data); % "center" the data contained in the .mat file on the value 0
thresh = 100; 
n = length(data);
fs=24414;
window=floor(0.002*fs); %% the equivalent of PLP?


% -------------> PEAK DETECTION
%"tokenizedData" contains the same elements of data rearranged in a
%"window" x "floor(numSamples/window)" grid; the ith column of "tokenizedData"
%contains the samples belonging to the ith window used for the spike detection
tokenizedData=reshape(data(1:end-rem(n,window)),window,floor(n/window));
[w_max,maxRows]=max(tokenizedData); %w_max = array with the biggest elements contained in the columns of "tokenizedData", "maxRows" array containing the rows of "tokenizedData" in which the max elements are positioned
[w_min,minRows]=min(tokenizedData); %w_min = array with the smallest elements contained in the columns of "tokenizedData", "minRows" array containing the rows of "tokenizedData" in which the min elements are positioned
wDiff=w_max-w_min; %array conatining the difference between "w_max" and "w_min"
indGrThThreshCol=find(wDiff>thresh); %indexes of wDiff elements greater than "thresh"

% -------------> temporary variables
w_maxTh=w_max(indGrThThreshCol); %array containing the elements of "w_max" belonging to the windows in which the threshold is overcome
w_minTh=w_min(indGrThThreshCol); %array containing the elements of "w_min" belonging to the windows in which the threshold is overcome

w_maxThAbs=abs(w_maxTh);%absolute value of w_maxTh
w_minThAbs=abs(w_minTh);%absolute value of w_minTh

sizeTokenizedData=size(tokenizedData); %array containing the dimensions of tokenizedData
indGrLen=length(indGrThThreshCol); % number of columns in which the threshold is exceeded

indMaxAbsColInd=find(w_maxThAbs>=w_minThAbs); % indices in which the elements of "w_maxThAbs" is greater or equal than "w_minThAbs"
indMinAbsColInd=setdiff(1:indGrLen,indMaxAbsColInd); % indices in which the elements of "w_maxThAbs" is smaller than "w_minThAbs"

indMaxNeeded=indGrThThreshCol(indMaxAbsColInd); %columns in which "w_maxThAbs" is greater or equal than "w_minThAbs" (only the columns in which the threshold is exceeded are considered)
indMinNeeded=indGrThThreshCol(indMinAbsColInd);%columns in which "w_maxThAbs" is smaller than "w_minThAbs" (only the columns in which the threshold is exceeded are considered)

maxRowsNeeded=maxRows(indMaxNeeded); % rows of "tokenizedData" in which "w_maxThAbs" is greater or equal than "w_minThAbs" (only the columns in which the threshold is exceeded are considered)
minRowsNeeded=minRows(indMinNeeded); % rows of "tokenizedData" in which "w_maxThAbs" is smaller than "w_minThAbs" (only the columns in which the threshold is exceeded are considered)

indMaxAbs=sub2ind(sizeTokenizedData,maxRowsNeeded,indMaxNeeded); %indices of "tokenizedData" in which "w_maxThAbs" is greater or equal than "w_minThAbs"  as if "tokenizedData" were a 1D array
indMinAbs=sub2ind(sizeTokenizedData,minRowsNeeded,indMinNeeded); %indices of "tokenizedData" in which "w_maxThAbs" is smaller than "w_minThAbs"  as if "tokenizedData" were a 1D array

peak_train = zeros(n, 1); % store values and timestamps of the peak trains
peak_train=sparse(peak_train); % convert peak_train in a sparse matrix (for performance improvement)
% <-------------

value(1:indGrLen)=wDiff(indGrThThreshCol); %set value with the peak-to-peak values of the windows in which the threshold has been overcome
y=sort([indMaxAbs,indMinAbs]); % indices of "tokenizedData" in which the values to be stored in "peak_train" are contained

% Check if there are spikes before SAVING
if (~isempty(y)) % If there are spikes in the current signal
    y=y'; %transpose the array
    peak_train(y) = value;      % the peak value is the peak-to-peak amplitude in uV
    clear train value           % FREE the memory from the useless variables
    % [artifact] = find_artifact(peak_train, art_dist, art_thresh); % Collection of artifact's positions
end

%% showing results
figure
plot(data)
hold on
plot(find(peak_train),data(find(peak_train)),'r*')