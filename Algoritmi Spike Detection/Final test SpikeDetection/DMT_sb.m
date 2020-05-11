function [ref_train_mins]= DMT_sb(data_in,delta_seconds,T,fs)
%% this code should represent the  dynamic multi-phasic event detection (DMP)?
%% Spike detection methods for polytrodes and high density microelectrode arrays
%% So far I just changed a couple of names to be more readable..

minPLP_samples = floor(1e-3*fs/2)*2; %Peak Lifetime Period (1ms in samples)
delta_samples  = floor(delta_seconds*fs); %max polarization time
ts_samples_pre = zeros(length(data_in),1);
counter_spk=1;
newIndex=1;
OVERSHOOT=floor((minPLP_samples-delta_samples)/3); %OVERSHOOT

for curr_sample=2:length(data_in)-1
    % Jumpt to next position
    if (curr_sample<newIndex)
        continue;
    end
    
    % If curr sample is a Local maximum or minimum (greater than neighbours)
    if abs(data_in(curr_sample))>abs(data_in(curr_sample-1)) && abs(data_in(curr_sample))>= abs(data_in(curr_sample+1))
        
        % Evaluate for local minimum within 2d window (1d before and 1d
        % after) ---> 1LMM, 2LMM
        CWin1=curr_sample;
        CWin1_plus_delta=min(curr_sample+delta_samples, length(data_in));
        
        % Voltage varies >= 2T within +-d ms of initial detection time --->
        % exceeds unipolar Threshold?
        
        currW=CWin1:CWin1_plus_delta;
        if ~(any(abs(data_in(curr_sample)-data_in(currW))>=2*T))
            continue;
        end
        
        % Find peak of opposite polarity to secure jump (max (minPLP , 2 delta)
        CWin3=min(max(curr_sample+minPLP_samples,curr_sample+2*delta_samples),length(data_in));
        
        if data_in(curr_sample)> 0
            [~,nPeak] = min(data_in(curr_sample:CWin3));
        else
            [~,nPeak] = max(data_in(curr_sample:CWin3));
        end
        
        idxPeak = curr_sample + nPeak-1;
        
        % Peak must not be within end of waveform --->OVERSHOOT
        if (idxPeak > CWin3-OVERSHOOT) % check during window +-OVERSHOOT
            if any(abs(data_in(CWin3-OVERSHOOT:CWin3)>data_in(idxPeak)))==1 % weird!
                newIndex = curr_sample+delta_samples;
                continue;
            end
        end
        % Make sure jump is after following peak given spike --->Refractory
        % period Rp
        newIndex = max(CWin3+1,idxPeak+OVERSHOOT);
        
        % Store minimum spike within window
        [~,minPeak]=min(data_in(curr_sample:CWin3));
        idxMinPeak=curr_sample+minPeak-1;
        ts_samples_pre(counter_spk)=idxMinPeak;
        counter_spk=counter_spk+1;
    end
end

ts_samples=ts_samples_pre(ts_samples_pre~=0);

%% Deleting  spikes out of limits
ts_samples(ts_samples<minPLP_samples)=[];
ts_samples(ts_samples>length(data_in)-minPLP_samples)=[];

%% check within +-minPLP
ts_start_stop=[ts_samples-minPLP_samples+1 ts_samples+minPLP_samples-1]; % for each spike a start and stop position depending on PLP
min_train=zeros(size(ts_start_stop,1),1);
for curr_spike=1:size(ts_start_stop,1)
    [~,min_train(curr_spike)]=min(data_in(ts_start_stop(curr_spike,1):1:ts_start_stop(curr_spike,2)));
end
ref_train_mins=min_train+ts_start_stop(:,1)-1;

%% check within +-delta (but overwrites, why?)
ts_start_stop=[ref_train_mins-delta_samples+2 ref_train_mins+delta_samples-2];
min_train=zeros(size(ts_start_stop,1),1);
for curr_spike=1:size(ts_start_stop,1)
    [~,min_train(curr_spike)]=min(data_in(ts_start_stop(curr_spike,1):1:ts_start_stop(curr_spike,2)));
end
ref_train_mins=min_train+ts_start_stop(:,1)-1;

