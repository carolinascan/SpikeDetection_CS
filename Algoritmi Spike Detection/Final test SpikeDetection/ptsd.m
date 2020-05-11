function [data_out,dthresh]=ptsd(data_in,th_type,th_factor,fs,w_pre,w_post,DMdpolar,PLP,RP,thresh)

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
% Nc      =       size(data_in,1);             %Total number of channels    
% tpoint  =       size(data_in,2);     %Total numer of points per channel 

% 
% for ich=1:Nc % For every channel
%           data=data_in(ich,:)';
          data=data_in-mean(data_in);
            
%         if th_type==1
%             thresh_vector = [];
%         elseif th_type==0
%                 h=msgbox(strvcat('Threshold file is missing','The panel for calculating the threshold will appear'),'Warning', 'warn');
%                 uiwait(h)
%                 [threshfile] = ComputeThresholdGUI(exp_num, mat_folder, exp_folder);
%                 load(threshfile); % thresh_vector is loaded
%         end
%         
% 
%             if ~isempty(thresh_vector)
%                 thresh = thresh_vector(ich); % read the vector of threshold
%             else
%                 thresh = autComputTh(data,fs,th_factor);
%             end
%        fprintf('\tDifferential threshold\t%d\n',thresh);

       mex SpikeDetection_PTSD_core.cpp;  %Compile mex
        [spkValues, spkTimeStamps] = SpikeDetection_PTSD_core(double(data)', thresh, peakDuration, refrTime,alignFlag);
        spikesTime  = 1 + spkTimeStamps( spkTimeStamps > 0 ); % +1 added to accomodate for zero- (c) or one-based (matlab) array indexing
        dthresh= []; %DiffThr( spkTimeStamps > 0 );
        spikesValue = spkValues( spkTimeStamps > 0 );
        spikesValue(spikesTime<=w_pre+1 | spikesTime>=length(data)-w_post-2)=[];
        spikesTime(spikesTime<=w_pre+1 | spikesTime>=length(data)-w_post-2)=[];
        nspk = length(spikesTime);
        clear spkValues spkTimeStamps;
        
        
        % Check if there are spikes
        if ( any(spikesTime) ) % If there are spikes in the current signal
            peak_train = sparse(spikesTime,1,spikesValue,length(data),1);
            %% Output if only one channel
            spk_vec=spikesTime;         
          %clear spikesValue
           artifact = find_artefacts_spikeTrain(peak_train, art_dist, art_thresh_elec);          
            peak_train = sparse(spikesTime,1,spikesValue,length(data),1);
            clear spikesValue
            spikes = zeros(nspk,ls+4);
            data = [data; zeros(w_post,1)];
            for ii=1:nspk                          % Eliminates artifacts
                if max(abs(data(spikesTime(ii)-w_pre:spikesTime(ii)+w_post))) < art_thresh_elec
                    spikes(ii,:) = data(spikesTime(ii)-w_pre-1:spikesTime(ii)+w_post+2);
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
            peak_train = sparse(length(data), 1);
            artifact = [];
            spikes = [];
        end
        data_out{ich}.peak_train=peak_train;
        data_out{ich}.artifact=artifact;
        data_out{ich}.spikes=spikes;    

        clear peak_train artifact spikes aux       

end 

