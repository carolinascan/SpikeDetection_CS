function [ts_samples]= adPT_sb(data_in,mPW,T,fs)
% SB: renaming variables for clarity.

% When call
% mPW=0.24*1e-3;
% th_value=DMth_cte*median(abs(data_in))/0.6745;
% [peak_train]= kelly_v5(data_in,mPW,th_value,fs);
%
mPW = floor(mPW*fs); % window in samples
% RP    = mPW*5;       % refractory period as a function of the window
RP    = floor(0.001*fs);;       % refractory period let's fix it to: 

ts_samples_pre = zeros(length(data_in),1);
counter_detected_spks=1;
newIndex=1;
%% for each sample
for curr_sample=2:length(data_in)-1
    
    %% Jumpt to next position to avoid spikes within RP
    if (curr_sample<newIndex)
        continue;
    end
    if counter_detected_spks>1
        if curr_sample-ts_samples_pre(counter_detected_spks-1)<=RP
            newIndex=ts_samples_pre(counter_detected_spks-1)+RP;
            continue;
        end
    end
    % Local voltage greater or equal than threshold
    
    %% TO RUN faster it excludes all values that are lower than 1/3 of T
    if abs(data_in(curr_sample))<T/3  % NOT CLEAR WHY T/3 ??
        continue;
    end
    
    %% If curr_sample is a Local maximum or minimum
    curr_sample_is_LMM=abs(data_in(curr_sample))>abs(data_in(curr_sample-1)) && abs(data_in(curr_sample))>= abs(data_in(curr_sample+1));
    if curr_sample_is_LMM
        % Evaluate for local minimum within 2d window (1d before and 1d after
        %    CWin1=max(index-delta,1);
        last_sample_mPW=min(curr_sample+mPW, length(data_in)-1);
        % Voltage varies >= 2T within +-d ms of initial detection time
        %    currW=CWin1:CWin2;
        list_samples_in_mPW=curr_sample:last_sample_mPW;
        
        %% if the difference within mPW is not larger than 2T go to next sample
        if ~(any(abs(data_in(curr_sample)-data_in(list_samples_in_mPW))>=2*T))
            %   newIndex=index+delta;
            continue;
        end
        %% check polarity of current sample
        if data_in(curr_sample)>0
            pol=1; %positive
        else
            pol=0; %negative
        end
        
        %% look for some LMM
        nidx=curr_sample; % this index
        counter_mPW = 0;
        while nidx <= curr_sample+mPW*3 % why 3 times??
            %% if polarity is positive, it looks for a minimum, within 3 mPW
            if pol==1
                [~,n2d]=min(data_in(list_samples_in_mPW));
            else
                [~,n2d]=max(data_in(list_samples_in_mPW));
            end
            
            nidx = nidx+n2d-1;
            
            %% check if the new minum (or maximum, depending on polarity) is a LMM
            nidx_is_LMM=abs(data_in(nidx))>abs(data_in(nidx-1))&& abs(data_in(nidx))>= abs(data_in(nidx+1));

            if nidx_is_LMM
                %% if it is a LMM save the spike in curr_sample and break the while loop
                ts_samples_pre(counter_detected_spks)=curr_sample; %nidx
                newIndex=min(nidx+nidx-curr_sample,length(data_in));
                break;
            else
                %% WTF? if counter_mPW is 0 or 1 or 2 the list of samples in mPW changes. The starting point is not the last end but the last end +mPW (not considering samples?)
                if counter_mPW <=2
                    list_samples_in_mPW = nidx + mPW : min(nidx + mPW*2, length(data_in)-1);
                    if isempty(list_samples_in_mPW) % SB: this is just to avoid checking in non-existent samples!!
                       break  
                    end
                    counter_mPW = counter_mPW+1;
                else
                    break
                end
            end
        end
        
        %% if a spike was detected in nidx, increment counter and continue
        if counter_detected_spks>1 && ts_samples_pre(counter_detected_spks)==nidx %SpikesIndices(index_spk-1)==nidx
            counter_detected_spks=counter_detected_spks+1;
            continue;
        end
        
        %% depending on the polarity of curr_sample, check from - to + mPW
        minus_plus_mPW = max(1,nidx-mPW):min(nidx+mPW,length(data_in)-1);
        if  pol==1
            %% if curr_sample is positive, check other values greater than itself, if any, change newIndex
            if any(data_in(minus_plus_mPW)>data_in(curr_sample))
                newIndex=min(curr_sample+mPW,length(data_in));
                continue;
            else
                %% if curr sample was the maximum, you found a spike in nidx??, increment counters
                ts_samples_pre(counter_detected_spks)=nidx;
                counter_detected_spks=counter_detected_spks+1;
                newIndex=min(nidx+nidx-curr_sample,length(data_in));
            end
        else
            %% if curr_sample is negative, check other values lower than itself, if any, change newIndex
            if any(data_in(minus_plus_mPW)<data_in(curr_sample))
                newIndex=min(curr_sample+mPW,length(data_in));
                continue;
            else
                 %% if curr sample was the minimum, you found a spike in nidx??, increment counters
                ts_samples_pre(counter_detected_spks)=nidx;
                counter_detected_spks = counter_detected_spks+1;
                newIndex=min(nidx+nidx-curr_sample,length(data_in));
            end
        end
    end
end
%% ts_samples contains all the non zero values of ts_samples_pre (initialized as a vector of the same length of data, of course too much)
ts_samples=ts_samples_pre(ts_samples_pre~=0);

%UNreference_train=SpikesIndices(SpikesIndices~=0);

%% For offline
%Lx=floor(1*1e-3*fs);
%rm_train=UNreference_train(find(diff(UNreference_train)<Lx)+1);
%reference_train=setdiff(UNreference_train,rm_train);
% LCKreference_train=zeros(length(UNreference_train),1);
% remUNreference_train=UNreference_train;
% for im=1:length(UNreference_train)
%     cW=UNreference_train(im);
%     CWin1=max(cW-Lx,1);
%     CWin2=min(cW+Lx, length(data_in));
%
%     CWIN=CWin1:CWin2;
%     C=intersect(CWIN,remUNreference_train);
%     Cn=0;
%     if length(C)>1
%     Cn=C(1);
%     end
%
%     LCKreference_train(im)=Cn;
%     remUNreference_train=setdiff(remUNreference_train,C);
% end
%
% reference_train=LCKreference_train(LCKreference_train~=0);






