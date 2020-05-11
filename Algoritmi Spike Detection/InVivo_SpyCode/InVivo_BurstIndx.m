%BI
close all
clear all

[start_folder]= selectfolder('Select the source folder that contains the PeakDetectionMAT files');
if strcmp(num2str(start_folder),'0')
    errordlg('Selection Failed - End of Session', 'Error');
    return
end
cd(start_folder)
cd ..
exp_folder=pwd;

cancelFlag = 0;
fs         = [];

PopupPrompt  = {'Sampling frequency [samples/sec]','Trigger Channel','Stim Area'};
PopupTitle   = 'Burstines Index)';
PopupLines   = 1;
PopupDefault = { '24414','11','S1'};
Ianswer = inputdlg(PopupPrompt,PopupTitle,PopupLines,PopupDefault);

if isempty(Ianswer)
    cancelFlag = 1;
else
    fs         = str2num(Ianswer{1,1});  % Sampling frequency
    
    TrCh=str2num(Ianswer{2,1});
    StimArea=(Ianswer{3,1});
end

TrChInput=1;
cnt=0;
first=3;
invivo_electrodes= (1:16)';
[exp_num]=find_expnum(start_folder, '_PeakDetection');
%[SpikeAnalysis]=createSpikeAnalysisfolder(start_folder, exp_num);
finalstring ='BurstinessIndex';
%[end_folder]=createresultfolder(SpikeAnalysis, exp_num, finalstring);
[end_folder] = createresultfolder(exp_folder, exp_num, 'BurstAnalysis');
[end_folder1]= createresultfolder(end_folder, exp_num, finalstring);
cd (start_folder)         % Go to the PeakDetectionMAT folder
name_dir=dir;               % Present directories - name_dir is a struct
num_dir=length (name_dir);  % Number of present directories (also "." and "..")
nphases=num_dir-first+1;

distancefromtrigger=[];
for i=1:16
    distancefromtrigger=[distancefromtrigger;DistTrigg(i)];
end
[dvalue,index]=sort(distancefromtrigger);
if TrCh==0
    TrChInput=0;
    TrCh=1;
end
idx=index(:,TrCh);
l_exp=0;
spks=[];

peak_train=[];
firingch=[];
BI=[];
BI_Tot=[];
f15=[];
BIelectrode={};
BItot_neurons=[];

for i = first:num_dir
    BIelectrode{i-2}=nan(16,1);
    current_dir = name_dir(i).name;   % i-th directory - i-th experimental phase
    phasename=current_dir;
    cd (current_dir);                 % enter the i-th directory
    current_dir=pwd;
    content=dir;                      % current PeakDetectionMAT files folder
    num_files= length(content);       % number of present PeakDetection files
    ISIHistLogNorm = cell(1,1);          % cell array containing ISI logarithmic hist
    bins = cell(1,1);                    % cell array cont bins' series
    allISI = cell(1,1);                  % cell array cont all ISIs
    
    for k= first:num_files  % FOR cycle over all the PeakDetection files
        filename = content(k).name;
        load (filename);                      % peak_train and artifact are loaded
        el= str2num(filename(end-7:end-6));     % current electrode [double]
       
        wave= (filename(end-4:end-4));
        spks=[spks ;([el(ones(length(find(peak_train)),1)), find(peak_train)])];
        
    end
    l_exp=l_exp+(length(peak_train)/fs);
    acq_time=length(peak_train)/fs;
    
    for n=1:16
        
        samples_BI=spks(find(spks(:,1)==n),2);
        if length(samples_BI)/(acq_time)>1
        sec_BI=round(samples_BI/fs);   %samples to seconds
        edges=(0.02:0.02:acq_time);
        n_spikes=hist(sec_BI,edges);
             
        X=n_spikes;
        X=sort(X);
        NumBins=length(X);
        LargestCounts=(round(0.995*NumBins):NumBins);
        f15=sum(X(LargestCounts))/sum(X);
        BIelectrode{i-2}(n,:)=(f15-0.005)/0.995;
        cd (start_folder)
        end
    end
    
    samples_BI=spks(:,2);
    sec_BI=round(samples_BI/fs);   %samples to seconds
    edges=(0.02:0.02:acq_time);
    n_spikes=hist(sec_BI,edges);
    
    X=n_spikes;
    X=sort(X);
    NumBins=length(X);
    LargestCounts=(round(0.995*NumBins):NumBins);
    f15=sum(X(LargestCounts))/sum(X);
    BI=(f15-0.005)/0.995;
    cd (start_folder)
    BI_Tot(i-2)=BI;
end

cd (end_folder1)
nome=strcat(exp_num, '_BI_.txt');
save (nome, 'BI_Tot', '-ASCII')
nome=strcat(exp_num, '_BI');
save (nome, 'BI_Tot')
nome=strcat(exp_num, '_BIelectrodes_');
save (nome, 'BIelectrode')

disp(['BI_Tot' '_' num2str(l_exp/60) 'min' ': ' num2str(sum(BI_Tot)/nphases)]);

EndOfProcessing (start_folder, 'Successfully accomplished');
    


            
            