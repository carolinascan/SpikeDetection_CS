function [allSpikes,class0,class1,class2,class3,class4,class5]=DoClustering(spiketime_s,recording_length,spikes)
% print2file = 1;                              % for saving printouts.
% print2file = 0;                              % for printing printouts.
%% PARAMETRI 
% ------------ Acquisition parameters
handles.par.sr = 24414;                     % sampling frequency, in Hz.
% ------------ Spike detection parameters --> maybe unnecessary?
handles.par.w_pre = 10;                       % number of pre-event data points stored
handles.par.w_post = 22;                      % number of post-event data points stored
% handles.par.detection = 'pos';                % type of threshold
handles.par.detection = 'neg';                % type of threshold
% handles.par.detection = 'both';               % type of threshold
handles.par.stdmin = 5.00;                  % minimum threshold
handles.par.stdmax = 50;                    % maximum threshold
handles.par.interpolation = 'y';            % interpolation for alignment
handles.par.int_factor = 2;                 % interpolation factor
handles.par.detect_fmin = 300;              % high pass filter for detection (default 300)
handles.par.detect_fmax = 3000;             % low pass filter for detection (default 3000)
handles.par.sort_fmin = 300;                % high pass filter for sorting (default 300)
handles.par.sort_fmax = 3000;               % low pass filter for sorting (default 3000)
% ------------- Force membership parameters
handles.par.max_spk = 20000;                % max. # of spikes before starting templ. match.
handles.par.min_spk = 50;                   % min. # of spikes before starting sorting
% handles.par.min_spk: this parameter has been added to avoid an error in cluster.exe,
% presumable caused if the number of spikes is too low to perform
% clustering
handles.par.template_type = 'center';       % nn, center, ml, mahal
handles.par.template_sdnum = 3;             % max radius of cluster in std devs.
% handles.par.permut = 'y';                   % for selection of random 'par.max_spk' spikes before starting templ. match.
handles.par.permut = 'n';                 % for selection of the first 'par.max_spk' spikes before starting templ. match.
% ------------- Features parameters
handles.par.features = 'wav';               % choice of spike features (wav)
handles.par.inputs = 10;                    % number of inputs to the clustering (def. 10)
handles.par.scales = 4;                     % scales for wavelet decomposition
if strcmp(handles.par.features,'pca');      % number of inputs to the clustering for pca
    handles.par.inputs = 3;
end
% ------------- SPC parameters
handles.par.mintemp = 0;                    % minimum temperature
handles.par.maxtemp = 0.301;                % maximum temperature (0.201)
handles.par.tempstep = 0.01;                % temperature step
handles.par.num_temp = floor(...
    (handles.par.maxtemp - ...
    handles.par.mintemp)/handles.par.tempstep); % total number of temperatures
handles.par.stab = 0.8;                     % stability condition for selecting the temperature
handles.par.SWCycles = 100;                 % number of montecarlo iterations (100)
handles.par.KNearNeighb = 11;               % number of nearest neighbors
% handles.par.randomseed = 0;                 % if 0, random seed is taken as the clock value
handles.par.randomseed = 147;               % If not 0, random seed
handles.par.fname_in = 'tmp_data';          % temporary filename used as input for SPC
handles.par.min_clus_abs = 50;              % minimum cluster size (absolute value)
handles.par.min_clus_rel = 0.005;           % minimum cluster size (relative to the total nr. of spikes)
%handles.par.temp_plot = 'lin';               %temperature plot in linear scale
handles.par.temp_plot = 'log';              % temperature plot in log scale
handles.par.force_auto = 'y';               % automatically force membership if temp>3.
handles.par.max_spikes = 5000;              % maximum number of spikes to plot.

handles.par.fname = 'tmp_data_prova';          % temporary filename CAPIRE QUESTO


% figure
% set(gcf,'PaperOrientation','Landscape','PaperPosition',[0.25 0.25 10.5 8])
%% DATI
spikes_nc=spikes; 
%% CLUSTERIZZAZIONE
nspk = size(spiketime_s,2);
index=spiketime_s;
t_length=recording_length;

 if nspk > handles.par.min_spk % analyze it only if it has a min number of spikes
                naux = min(handles.par.max_spk,size(spikes,1)); % spikes to be considered for the template
                handles.par.min_clus = max(handles.par.min_clus_abs,handles.par.min_clus_rel*naux); % minimum number of spikes in a cluster
                   
                % CALCULATES INPUTS TO THE CLUSTERING ALGORITHM.
                inspk = wave_features(spikes_nc,handles);  

                % SELECTION OF SPIKES FOR SPC
                if handles.par.permut == 'n'
                    % GOES FOR TEMPLATE MATCHING IF TOO MANY SPIKES.
                    if nspk > handles.par.max_spk
                        % take first 'handles.par.max_spk' spikes as an input for SPC
                        inspk_aux = inspk(1:naux,:);
                    else
                        inspk_aux = inspk;
                    end 
                    
                %INTERACTION WITH SPC
                    save(handles.par.fname_in,'inspk_aux','-ascii');
                    [clu, tree] = run_cluster(handles);
                    [temp] = find_temp(tree,handles);
                 %DEFINE CLUSTERS (up to 5)
                    class1=find(clu(temp,3:end)==0);
                    class2=find(clu(temp,3:end)==1);
                    class3=find(clu(temp,3:end)==2);
                    class4=find(clu(temp,3:end)==3);
                    class5=find(clu(temp,3:end)==4);
                    class0=setdiff(1:size(spikes,1), sort([class1 class2 class3 class4 class5]));
                    %             whos class*
                else   
                % GOES FOR TEMPLATE MATCHING IF TOO MANY SPIKES.
                    if size(spikes,1) > handles.par.max_spk;
                        % random selection of spikes for SPC
                        ipermut = randperm(length(inspk));
                        ipermut(naux+1:end) = [];
                        inspk_aux = inspk(ipermut,:);
                    else
                        ipermut = randperm(size(inspk,1));
                        inspk_aux = inspk(ipermut,:);
                    end
                     
                    %INTERACTION WITH SPC
                    save(handles.par.fname_in,'inspk_aux','-ascii');
                    [clu, tree] = run_cluster(handles);
                    [temp] = find_temp(tree,handles);
                    
                    %DEFINE CLUSTERS
                    class1=ipermut(find(clu(temp,3:end)==0));
                    class2=ipermut(find(clu(temp,3:end)==1));
                    class3=ipermut(find(clu(temp,3:end)==2));
                    class4=ipermut(find(clu(temp,3:end)==3));
                    class5=ipermut(find(clu(temp,3:end)==4));
                    class0=setdiff(1:size(spikes,1), sort([class1 class2 class3 class4 class5]));
                    %             whos class*
                end
                 % IF TEMPLATE MATCHING WAS DONE, THEN FORCE
                if (size(spikes,1) > handles.par.max_spk || ...
                        (handles.par.force_auto == 'y'));
                    classes = zeros(size(spikes,1),1);
                    if length(class1)>=handles.par.min_clus; classes(class1) = 1; end
                    if length(class2)>=handles.par.min_clus; classes(class2) = 2; end
                    if length(class3)>=handles.par.min_clus; classes(class3) = 3; end
                    if length(class4)>=handles.par.min_clus; classes(class4) = 4; end
                    if length(class5)>=handles.par.min_clus; classes(class5) = 5; end
                    f_in  = spikes(classes~=0,:);   % already classified spikes
                    f_out = spikes(classes==0,:);   % unclassified spikes
                    class_in = classes(find(classes~=0),:);
                    class_out = force_membership_wc(f_in, class_in, f_out, handles);
                    classes(classes==0) = class_out;
                    class0=find(classes==0);
                    class1=find(classes==1);
                    class2=find(classes==2);
                    class3=find(classes==3);
                    class4=find(classes==4);
                    class5=find(classes==5);
                end
                % Building output variables
                temperature = handles.par.mintemp+temp*handles.par.tempstep;
                features_name = handles.par.features;
                clus_pop = [];
                cluster = zeros(nspk,2);
                cluster(:,2)= index';
                clus_pop = [clus_pop length(class0)];
                if ~isempty(class1);
                    clus_pop = [clus_pop length(class1)];
                    cluster(class1(:),1)=1;
                end
                if ~isempty(class2)
                    clus_pop = [clus_pop length(class2)];
                    cluster(class2(:),1)=2;
                end
                if ~isempty(class3)
                    clus_pop = [clus_pop length(class3)];
                    cluster(class3(:),1)=3;
                end
                if ~isempty(class4)
                    clus_pop = [clus_pop length(class4)];
                    cluster(class4(:),1)=4;
                end
                if ~isempty(class5)
                    clus_pop = [clus_pop length(class5)];
                    cluster(class5(:),1)=5;
                end
                % Save files
                %             par = handles.par;
                cluster_class = cluster;
                clear cluster
                allSpikes = spikes_nc;
                clear spikes_nc
%            
                clear spikes; clear inspk; clear cluster_class
 end
 clear class_in f_in
end

