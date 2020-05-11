function [ref_train_mins]= DMT(data_in,delta,T,fs)

minPLP = floor(1e-3*fs/2)*2; %Peak Lifetime Period
ndelta  = floor(delta*fs); %max polarization time
SpikesIndices = zeros(length(data_in),1);
index_spk=1;
newIndex=1;
OVERSHOOT=floor((minPLP-ndelta)/3); %OVERSHOOT
for index=2:length(data_in)-1
    % Jumpt to next position
    if (index<newIndex)
        continue;
    end
    
    % Local maximum or minimum
    if abs(data_in(index))>abs(data_in(index-1)) && abs(data_in(index))>= abs(data_in(index+1))
        
        % Evaluate for local minimum within 2d window (1d before and 1d
        % after) ---> 1LMM, 2LMM
        CWin1=index;
        CWin2=min(index+ndelta, length(data_in));
        
        % Voltage varies >= 2T within +-d ms of initial detection time --->
        % exceeds unipolar Threshold?

        currW=CWin1:CWin2;
        if ~(any(abs(data_in(index)-data_in(currW))>=2*T))
            continue;
        end
        
        % Find peak of opposite polarity to secure jump
        CWin3=min(max(index+minPLP,index+2*ndelta),length(data_in));
        
        if data_in(index)> 0
            [~,nPeak] = min(data_in(index:CWin3));
        else
            [~,nPeak] = max(data_in(index:CWin3));
        end
        
        idxPeak = index + nPeak-1;
   
        % Peak must not be within end of waveform --->OVERSHOOT
        if (idxPeak > CWin3-OVERSHOOT) % check during window +-OVERSHOOT
            if any(abs(data_in(CWin3-OVERSHOOT:CWin3)>data_in(idxPeak)))==1
                newIndex = index+ndelta;
                continue;
            end
        end
        % Make sure jump is after following peak given spike --->Refractory
        % period Rp
        newIndex = max(CWin3+1,idxPeak+OVERSHOOT);
        
        % Store minimum spike within window
        [~,minPeak]=min(data_in(index:CWin3));
        idxMinPeak=index+minPeak-1;
        SpikesIndices(index_spk)=idxMinPeak;
        index_spk=index_spk+1;
    end
    
end

reference_train=SpikesIndices(SpikesIndices~=0);

% Offline verification according to noise level and fs
reference_train(reference_train<minPLP)=[];
reference_train(reference_train>length(data_in)-minPLP)=[];

Win=[reference_train-minPLP+1 reference_train+minPLP-1];
min_train=zeros(size(Win,1),1);
for in=1:size(Win,1)
    [~,min_train(in)]=min(data_in(Win(in,1):1:Win(in,2)));
end
ref_train_mins=min_train+Win(:,1)-1;

Win=[ref_train_mins-ndelta+2 ref_train_mins+ndelta-2];
min_train=zeros(size(Win,1),1);
for in=1:size(Win,1)
    [~,min_train(in)]=min(data_in(Win(in,1):1:Win(in,2)));
end
ref_train_mins=min_train+Win(:,1)-1;

