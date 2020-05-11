%%Burstiness Index
%%Alberto Averna (Irene Nava previus algorithm)
clear all
close all

[start_folder]= selectfolder('Select the PeakDetectionMAT folder');
if strcmp(num2str(start_folder),'0')
    errordlg('Selection Failed - End of Session', 'Error');
    return
end
cd(start_folder)
cd ..
exp_folder=pwd;
cancelFlag = 0;
PopupPrompt  = {'Sampling frequency [samples/sec]','BI Window [sec]','Bin [sec]'};
PopupTitle   = 'Burstiness Index - BI)';
PopupLines   = 1;
PopupDefault = {'24414','300','0.02'};
Ianswer = inputdlg(PopupPrompt,PopupTitle,PopupLines,PopupDefault);
if isempty(Ianswer)
    cancelFlag = 1;
else
    fs = str2num(Ianswer{1,1});  % Sampling frequency
     BIWindow = str2num(Ianswer{2,1});  % Window Burstiness Index
     Bin = str2num(Ianswer{3,1});
end
if cancelFlag
    return
else
    
    if BIWindow<100
       disp(['BI Window maybe too short ' num2str(BIWindow) ' [sec]']);
    
    end
    
    l_exp=0;
    j=0;
    first=3;
    peak_train=[];
    firingch=[];
    BI=[];
    BI_Tot=[];
    f15=[];
    %mcmea_electrodes = [(12:17)'; (21:28)'; (31:38)'; (41:48)'; ...
     %   (51:58)'; (61:68)'; (71:78)';(82:87)'];
    
    mcmea_electrodes=(1:16);    
    [exp_num]=find_expnum(start_folder, '_PeakDetection');
    %[SpikeAnalysis]=createSpikeAnalysisfolder(start_folder, exp_num);
    finalstring ='BurstinessIndex';
    %[end_folder]=createresultfolder(SpikeAnalysis, exp_num, finalstring);
    [end_folder] = createresultfolder(exp_folder, exp_num, 'BurstAnalysis');
    [end_folder1]= createresultfolder(end_folder, exp_num, finalstring);
    % ------------------------------------------------ START PROCESSING
    cd (start_folder)         % Go to the PeakDetectionMAT folder
    name_dir=dir;               % Present directories - name_dir is a struct
    num_dir=length (name_dir);  % Number of present directories (also "." and "..")
    nphases=num_dir-first+1;
    allmfr=zeros(nphases,1);
    for i = first:num_dir     % FOR cycle over all the directories
        BI=[];
        spks=[];
        j=j+1;
        current_dir = name_dir(i).name;   % i-th directory - i-th experimental phase
        phasename=current_dir;
        
        cd (current_dir);                 % enter the i-th directory
        current_dir=pwd;
        content=dir;                      % current PeakDetectionMAT files folder
        num_files= length(content);       % number of present PeakDetection files
        
        for k= first:num_files  % FOR cycle over all the PeakDetection files
            filename = content(k).name;
            load (filename);                      % peak_train and artifact are loaded
            el= str2num(filename(end-7:end-6));    % current electrode [double]
          
            spks=[spks ;([el(ones(length(find(peak_train)),1)), find(peak_train)])];
        end
        l_exp=l_exp+(length(peak_train)/fs);
        acq_time=length(peak_train)/fs;
        if acq_time+10<BIWindow
            h=errordlg(['BIWindow>Acq_Time:' num2str(BIWindow) '>' num2str(acq_time)]);
            return
        end
        samples_BI=spks(:,2);
        sec_BI=round(samples_BI/fs);   %samples to seconds
        edges=(Bin:Bin:acq_time);
        n_spikes=hist(sec_BI,edges);
  
        if acq_time>=(BIWindow+10)
            for n=1:round(acq_time/BIWindow)    %calcolo BI ogni 5min di registrazione
                
                if n*(BIWindow)<=acq_time
                    X=n_spikes( ((n-1)*(BIWindow)/Bin)+1 : n*(BIWindow)/Bin);
                    % X=n_spikes( (n-1)*300+1 : n*300 );
                else
                    X=n_spikes( ((n-1)*(BIWindow)/Bin)+1 : end);
                end
                
                X=sort(X);
                NumBins=length(X);
               % LargestCounts=(round(0.85*NumBins):NumBins);
                LargestCounts=(round(0.995*NumBins):NumBins);
                f15(n)=sum(X(LargestCounts))/sum(X); %parameter adapted for in vivo recordings
                %BI(n)=(f15(n)-0.15)/0.85;
                BI(n)=(f15(n)-0.005)/0.995; 
            end
        else
            n=1;
            X=n_spikes;
            X=sort(X);
            NumBins=length(X);
            %LargestCounts=(round(0.85*NumBins):NumBins);
             LargestCounts=(round(0.995*NumBins):NumBins);
            f15=sum(X(LargestCounts))/sum(X);
            %BI=(f15-0.15)/0.85;
            BI=(f15-0.005)/0.995;
        end
        
        BI_Tot(j)=sum(BI)/length(BI);%%<------------------------------------------------
        BI_Tot=BI_Tot';
        cd (start_folder)
    end
    
    cd (end_folder1)
    nome=strcat(exp_num, '_BI.txt');
    save (nome, 'BI_Tot', '-ASCII')
    nome=strcat(exp_num, '_BI');
    save (nome, 'BI_Tot')
    disp(['BI_Tot' '_' num2str(l_exp/60) 'min' ': ' num2str(sum(BI_Tot)/j)]);
    
    EndOfProcessing (start_folder, 'Successfully accomplished');
    
end