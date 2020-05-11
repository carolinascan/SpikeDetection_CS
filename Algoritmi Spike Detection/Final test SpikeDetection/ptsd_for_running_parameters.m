function [data_out,dthresh]=ptsd_for_running_parameters(data_in,thresh,fs,w_pre,w_post,DMdpolar,PLP,RP)
%% Parameters: Can be changed
peakDuration    =   floor(PLP*1e-3*fs);   % Pulse lifetime period in samples
refrTime        =   floor(RP*1e-3*fs);   % Refractory time in samples
stim_artifacts  =   -1;                 % No Analog Raw Data folder 
interpolation   =   1;      
w_pre           =   floor(w_pre*1e-3*fs);
w_post          =   floor(w_post*1e-3*fs);
ls              =  w_pre+w_post;
art_thresh_elec =   350;
art_dist        =1/35*fs;               % Maximum Stimulation frequency
%%
if strcmp(DMdpolar,'negative')          % Alignment flag for detection
    alignFlag       =   1;
elseif  strcmp(DMdpolar,'highest')
    alignFlag       =   0;                  
else 
%    fprintf('Default search polarity is negative');
    alignFlag       =   1;
end 

%% With data that has already been FILTERED  [300-5K] 
alignFlag=1;
%        mex SpikeDetection_PTSD_core.cpp;  %Compile mex
        [spkValues, spkTimeStamps] = SpikeDetection_PTSD_core(double(data_in)', thresh, peakDuration, refrTime,alignFlag);
        spikesTime  = 1 + spkTimeStamps( spkTimeStamps > 0 ); % +1 added to accomodate for zero- (c) or one-based (matlab) array indexing
        dthresh= []; %DiffThr( spkTimeStamps > 0 );
        spikesValue = spkValues( spkTimeStamps > 0 );
        spikesValue(spikesTime<=w_pre+1 | spikesTime>=length(data_in)-w_post-2)=[];
        spikesTime(spikesTime<=w_pre+1 | spikesTime>=length(data_in)-w_post-2)=[];
        nspk = length(spikesTime);
        clear spkValues spkTimeStamps;
        
        
        % Check if there are spikes
        if ( any(spikesTime) ) % If there are spikes in the current signal
            peak_train = sparse(spikesTime,1,spikesValue,length(data_in),1);
            %% Output if only one channel
            spk_vec=spikesTime;         
          %clear spikesValue
           artifact = find_artefacts_spikeTrain(peak_train, art_dist, art_thresh_elec);          
            peak_train = sparse(spikesTime,1,spikesValue,length(data_in),1);
            clear spikesValue
            spikes = zeros(nspk,ls+4);
            data_in = [data_in zeros(1,w_post)];
            for ii=1:nspk                          % Eliminates artifacts
                if max(abs(data_in(spikesTime(ii)-w_pre:spikesTime(ii)+w_post))) < art_thresh_elec
                    spikes(ii,:) = data_in(spikesTime(ii)-w_pre-1:spikesTime(ii)+w_post+2);
                end
            end
            aux = find(spikes(:,w_pre)==0);       % erases indexes that were artifacts
            spikes(aux,:)=[];
            peak_train(spikesTime(aux))=0;
            
            spk_vec(aux)=0;   
            clear spikesTime
            %No interpolation in this case 
            switch interpolation
                case 1
                    spikes(:,end-1:end)=[];       %eliminates borders that were introduced for interpolation
                    spikes(:,1:2)=[];
                case 0
                    %                         Does interpolation
                    spikes = interpolate_spikes(spikes,w_pre,w_post,2);
            end
            % ____________________________________
        else % If there are no spikes in the current signal
            peak_train = sparse(length(data_in), 1);
            artifact = [];
            spikes = [];
        end
        data_out.peak_train=peak_train;
        data_out.artifact=artifact;
        data_out.spikes=spikes;    

        clear peak_train artifact spikes aux       

end 

