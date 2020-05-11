% SpyCode RawData Converter spin-off
% Alberto Averna Feb 2015
clear all

fs=[]; %Sampling Frequency [Hz]
StartFolder=selectfolder('Select the Exp Folder Contains Waves');

if strcmp(num2str(StartFolder),'0')
    errordlg('Wrong selection - End of Session', 'Error');
    return
else
    cd (StartFolder);
    StartFolder=pwd; % Folder containing the RawData per Channel
end

PopupPrompt  = {'Sampling frequency [samples/sec]','Number of Basal Sessions'};
PopupTitle   = 'SpyCode comp Conversion';
PopupLines   = 1;
PopupDefault = {'24414','1'};
Ianswer = inputdlg(PopupPrompt,PopupTitle,PopupLines,PopupDefault);

if isempty(Ianswer)
    cancelFlag = 1;
else
    fs  = str2num(Ianswer{1,1});
    nbasal_sessions=str2num(Ianswer{2,1});
end
h = waitbar(0,'Please wait...');
steps = (64); %for the waitbar progress
cd(StartFolder)
WaveChannels=dir;
numphases = length(dir);
first=3;
[nome_exp] = find_expnum(lower(StartFolder), '_');
name_folder=[nome_exp '_Mat_files'];
mkdir(name_folder)
artifact=[];
spikes=[];

for i =first:numphases
    
  
        filenamesp=WaveChannels(i).name;
        for k=1:32%%%<----------------------------------------------------------------------------------------------
            load (filenamesp,['WaveData_' num2str(k)]);
         waitbar( (k) / steps)
        end
        
      
        phase=filenamesp(end-4:end-4);
        nchannel=filenamesp(end-12:end-12);
        phs=str2num(phase)+str2num(phase)-1;
        cd(name_folder)
        name_Basal_subfolder=[nome_exp '_0' num2str(phs) '_nbasal_0001'];
        pkdir= dir;
        numpkdir= length(dir);
        if isempty(strmatch(name_Basal_subfolder, strvcat(pkdir(1:numpkdir).name),'exact'))
            mkdir(name_Basal_subfolder)% Make a new directory only if it doesn't exist
            Bsubfolder=pwd;
            name_Bsubfolder_path=[Bsubfolder '/' name_Basal_subfolder];
        end
        s=who('WaveData*');
        for j=1:length(s)
            waitbar( (j+k) / steps)
            data=(eval(s{j}))*10^6; %Data From [V] to [uV]
            ind_=regexp(s{j},'_') ;
            ch=(s{j}((ind_+1):end));
            cd(name_Bsubfolder_path)
            if str2num(ch)<10
                save([nome_exp '_0' num2str(phs) '_nbasal_0001' '_0' ch],'data','artifact','spikes');
            else
                save([nome_exp '_0' num2str(phs) '_nbasal_0001' '_' ch],'data','artifact','spikes');
            end
            clear data
        end
        for z=1:32
            clear (['WaveData_' num2str(z)])
        end
       
        cd(StartFolder)

end
warndlg('Successfully accomplished!','Conversion')
close(h)