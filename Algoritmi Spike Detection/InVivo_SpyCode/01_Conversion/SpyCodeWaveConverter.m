% SpyCode RawData Converter
% Alberto Averna Feb 2015
clear all

phase_st=0;
fs=[]; %Sampling Frequency [Hz]
trigg=[]; %Trigger Channel
acq_time=[]; %Length of entire experiment [s]
artifact=[];
spikes=[];
Tollerance=[];% Length of first noisy part of the recording

StartFolder=selectfolder('Select the Exp Folder Contains Waves');

if strcmp(num2str(StartFolder),'0')
    errordlg('Wrong selection - End of Session', 'Error');
    return
else
    cd (StartFolder);
    StartFolder=pwd; % Folder containing the RawData per Channel
end

PopupPrompt  = {'Sampling frequency [samples/sec]','Number of Basal Sessions','Number of Stim Sessions','Tollerance [s]'};
PopupTitle   = 'SpyCode comp Conversion';
PopupLines   = 1;
PopupDefault = {'24414','4','3','0'};
Ianswer = inputdlg(PopupPrompt,PopupTitle,PopupLines,PopupDefault);

if isempty(Ianswer)
    cancelFlag = 1;
else
    fs  = str2num(Ianswer{1,1});
    nbasal_sessions=str2num(Ianswer{2,1});
    stim_sessions=str2num(Ianswer{3,1});
    Tollerance=str2num(Ianswer{4,1});
end

h = waitbar(0,'Please wait...');
steps = (nbasal_sessions+stim_sessions); %for the waitbar progress

cd(StartFolder)
WaveChannels=dir;

numphases = length(dir);

first=3;
[nome_exp] = find_expnum(lower(StartFolder), 'WaveStimData');

name_folder=[nome_exp '_Mat_files'];

mkdir(name_folder)

for i =first:numphases
  
    waitbar( (i-2) / steps)
    if strfind(WaveChannels(i).name,'Basal')~=0 %for each spontaneous phase
        filenamesp=WaveChannels(i).name;
        for k=1:16
            load (filenamesp,['WaveData_' num2str(k)]);
        end
        load(filenamesp,'BlockData','CurrData','SpikeData','StimCh','TimeRange','TrigCh');
        nameExp=BlockData.blockname;
        phase=filenamesp(end-4:end-4);
        nchannel=filenamesp(end-12:end-12);
        
        phs=str2num(phase)+str2num(phase)-1;
        
        cd(name_folder)
        
        name_Basal_subfolder=[nameExp '_0' num2str(phs) '_nbasal_0001'];
        pkdir= dir;
        numpkdir= length(dir);
        if isempty(strmatch(name_Basal_subfolder, strvcat(pkdir(1:numpkdir).name),'exact'))
            mkdir(name_Basal_subfolder)% Make a new directory only if it doesn't exist
            Bsubfolder=pwd;
            name_Bsubfolder_path=[Bsubfolder '/' name_Basal_subfolder];
        end
        s=who('WaveData*');
        for j=1:length(s)
            
            data=(eval(s{j}))*10^6; %Data From [V] to [uV]
             if Tollerance~=0&&phs==1
            data(1:(ceil(Tollerance*fs)))=0;
             end
            ind_=regexp(s{j},'_') ;
            ch=(s{j}((ind_+1):end));
            cd(name_Bsubfolder_path)
            if str2num(ch)<10
                save([nameExp '_0' num2str(phs) '_nbasal_0001' '_0' ch],'data','artifact','spikes');
            else
                save([nameExp '_0' num2str(phs) '_nbasal_0001' '_' ch],'data','artifact','spikes');
            end
            clear data
            
            
        end
        for z=1:16
            clear (['WaveData_' num2str(z)])
        end
        clear 'BlockData' 'CurrData' 'SpikeData' 'StimCh' 'TimeRange' 'TrigCh'
        cd(StartFolder)
        
    elseif strfind(WaveChannels(i).name,'Stim')~=0 %for each Stim phase
        filenamest=WaveChannels(i).name;
        for k=1:16
            load (filenamest,['WaveData_' num2str(k)]);
        end
        load(filenamest,'BlockData','CurrData','SpikeData','StimCh','TimeRange','TrigCh');
        nameExp=BlockData.blockname;
        phase=filenamest(end-4:end-4);
        phs=str2num(phase)*2;
        nchannel=filenamest(end-12:end-12);
        
        StimDataSamples=CurrData(:,1)*fs; %Stim Time in Samples
        
        if exist('TrigCh')
            trigg=TrigCh(1);
            if length(unique(TrigCh))>1
                disp('Trigger Channel has been changed')  
                end
        else
%             trigg=StimCh(1);
%             if length(unique(StimCh))>1
%                     disp('Trigger Channel has been changed')
%                     break
%             end
        trigg=2;
        end       
            
        
        
        cd(name_folder)
     if length(unique(trigg))==1
        if phs<10
         name_Stim_subfolder=[nameExp '_0' num2str(phs) '_Stim' num2str(phase) '_' num2str(trigg)];
        else
            name_Stim_subfolder=[nameExp '_' num2str(phs) '_Stim' num2str(phase) '_' num2str(trigg)];
        end
        pkdir= dir;
        numpkdir= length(dir);
        if isempty(strmatch(name_Stim_subfolder, strvcat(pkdir(1:numpkdir).name),'exact'))
            mkdir(name_Stim_subfolder)% Make a new directory only if it doesn't exist
            Ssubfolder=pwd;
            name_Ssubfolder_path=[Ssubfolder '/' name_Stim_subfolder];
        end
        
        s=who('WaveData*');
        for j=1:length(s)
            
            data=(eval(s{j}))*10^6; %Data From [V] to [uV]
            ind_=regexp(s{j},'_') ;
            ch=(s{j}((ind_+1):end));
            
            starts=((TimeRange(1))*fs);
            ends=((TimeRange(2))*fs);
            artifact=StimDataSamples(find(StimDataSamples>=(starts)&StimDataSamples<=(ends)));
            artifact=(artifact-(starts)-1); %shift artifact vector to 0
            
            cd(name_Ssubfolder_path)
            if str2num(ch)<10
                save([nameExp '_0' num2str(phs) '_Stim' num2str(phase) '_' num2str(trigg) '_0' ch],'data','artifact','spikes');
            else
                save([nameExp '_0' num2str(phs) '_Stim' num2str(phase) '_' num2str(trigg) '_' ch],'data','artifact','spikes');
            end
            clear data
            
        end
        for z=1:16
            clear (['WaveData_' num2str(z)])
        end
        clear 'BlockData' 'CurrData' 'SpikeData' 'StimCh' 'TimeRange' 'TrigCh'
        cd(StartFolder)
     
     else                     %%2 or more trigger channels in the same exp Phase
         [v,timeind]=unique(TrigCh);
         timetrch=cell(length(timeind),1);
         for k=1:length(v)
         timetrch{k}=find(TrigCh==v(k));
         end
         
         
         for n=1:length(v)
         cntch=length(v);
         cnttms=length(timeind);
         if phs<10
         name_Stim_subfolder=[nameExp '_0' num2str(phs) '_Stim' num2str(phase) '_' num2str(v(n))];
         else
              name_Stim_subfolder=[nameExp '_' num2str(phs) '_Stim' num2str(phase) '_' num2str(v(n))];
         end
         
        pkdir= dir;
        numpkdir= length(dir);
        if isempty(strmatch(name_Stim_subfolder, strvcat(pkdir(1:numpkdir).name),'exact'))
            mkdir(name_Stim_subfolder)% Make a new directory only if it doesn't exist
            Ssubfolder=pwd;
            name_Ssubfolder_path=[Ssubfolder '/' name_Stim_subfolder];
        end
        
         s=who('WaveData*');
        for j=1:length(s)
            
            datas=(eval(s{j}));
            ind_=regexp(s{j},'_') ;
            ch=(s{j}((ind_+1):end));
            
            if timetrch{n}(1)==1
            startdata=1;
            else
            startdata=(timetrch{n}(1))*fs;
            end
            enddata=(timetrch{n}(end))*fs;
            data=datas(startdata:enddata);
            data=data*10^6; %Data From [V] to [uV]
            
            starts=((TimeRange(1))*fs);
            ends=((TimeRange(2))*fs);
            artifact=StimDataSamples(find(StimDataSamples>=(starts)&StimDataSamples<=(ends)));
            artifact=(artifact-(starts)-1); %shift artifact vector to 0
            
            cd(name_Ssubfolder_path)
            if str2num(ch)<10
                save([nameExp '_0' num2str(phs) '_Stim' num2str(phase) '_' num2str(trigg) '_0' ch],'data','artifact','spikes');
            else
                save([nameExp '_0' num2str(phs) '_Stim' num2str(phase) '_' num2str(trigg) '_' ch],'data','artifact','spikes');
            end
            clear data
            
        end
        for z=1:16
            clear (['WaveData_' num2str(z)])
        end
        clear 'BlockData' 'CurrData' 'SpikeData' 'StimCh' 'TimeRange' 'TrigCh'
        cd(StartFolder)
         end
     end
    end 
    end
warndlg('Successfully accomplished!','Conversion')
close(h)