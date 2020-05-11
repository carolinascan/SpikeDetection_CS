% SpyCode Spikes Converter
% Alberto Averna
clear all

Ts=[];  %Stim Phase Duration [s]
Tb=[]; %Basal Phase Duration[s]
Spk=[];
fs=[]; %Sampling Frequency [Hz]
trigg=[]; %Trigger Channel
acq_time=[]; %Length of entire experiment [s]
artifact=[];
spikes=[];



[filename,pathname]=uigetfile('.mat');
cd(pathname)
load(filename)
name_exp=filename(1:end-4);
Spikes=SpikeData(:,1);
el=SpikeData(:,2);

PopupPrompt  = {'Sampling frequency [samples/sec]','Trigger Channel','Total Recording Time [s]','Basal Phase Duration [s]','Number of Basal Sessions','Stim Phase Duration','Number of Stim Sessions'};
PopupTitle   = 'SpyCode comp Conversion';
PopupLines   = 1;
PopupDefault = {'24414', '11', '2700','600','4','3600','3'};
Ianswer = inputdlg(PopupPrompt,PopupTitle,PopupLines,PopupDefault);

if isempty(Ianswer)
    cancelFlag = 1;
else
    fs  = str2num(Ianswer{1,1});
    trigg = str2num(Ianswer{2,1});
    acq_time  = str2num(Ianswer{3,1});
    Tb=str2num(Ianswer{4,1});
    nbasal_sessions=str2num(Ianswer{5,1});
    Ts=str2num(Ianswer{6,1});
    stim_sessions=str2num(Ianswer{7,1});
    
end

for i=1:max(el)
    Spk=[Spk;Spikes(find(el==i)) ones(length(find(el==i)),1)*i];
end

TrChInd=find(Spk(:,2)==trigg);

% figure(2)
% plot(Spk(:,1),Spk(:,2),'b.')
% hold on
% plot(Spk(TrChInd,1),Spk(TrChInd,2),'r.')
% 
% for currStim=1:size(StimData)
%     fg=plot([StimData(currStim),StimData(currStim)],[1 max(el)],'g');
% end
% xlabel('Time [s]');
% ylabel('Channels');
% grid on
% evector=1:1:max(el);
% 
% set(gca,'ytick',1:(max(el)),'ylim',[0 (max(el)+1)],'xlim',[0 acq_time+1],'xtick',0:300:acq_time);
% % saveas(fg,[name_exp '_raster_stim.jpg'],'jpg');
% % saveas(fg,[name_exp '_raster_stim.fig'],'fig');




%% for peak_train
SpkSampleTot={};
SpikeTrain={};
SpkSample(:,1)=round(Spk(:,1).*fs);
SpkSample(:,2)=Spk(:,2);
time=zeros(max(SpkSample(:,1)),1);
StimDataSamples=StimData*fs; %Stim Stamps [s] to Samples
for j=1:max(el)
    SpkSampleTot{j}=SpkSample(find(SpkSample(:,2)==j));
    
    SpikeTr{j}=time;
    S=SpkSampleTot{j};
    SpikeTrn=SpikeTr{j};
    SpikeTrn(S)=1;
    SpikeTrain{j}=sparse(SpikeTrn);
    %SpikeTrain{j}=SpikeTrn;
end
SpikeTrain=SpikeTrain';

h = waitbar(0,'Please wait...');
steps = (nbasal_sessions+stim_sessions)*16;

%% for nbasal
%shift=0;
startb=1;
endb=Tb*fs;
name_folder=[name_exp '_PeakDetectionMat'];
mkdir(name_folder)
phase=[];
a=0;
for i=1:nbasal_sessions
     phase=i+i-1;
    name_Basal_subfolder=['ptrain_' name_exp '_0' num2str(phase) '_nbasal_0001'];
    
    cd  (name_folder)
    mkdir(name_Basal_subfolder)
    cd  (name_Basal_subfolder)
    
  
    for j=1:length(SpikeTrain)
        peak_train=SpikeTrain{j};
        a=a+1;
        
        peak_train=sparse((peak_train(startb:endb)));
        if j<10
            save(['ptrain_' name_exp '_0' num2str(phase) '_nbasal_0001' '_0' num2str(j)],'peak_train','artifact','spikes');
        else
            save(['ptrain_' name_exp '_0' num2str(phase) '_nbasal_0001' '_' num2str(j)],'peak_train','artifact','spikes');
        end
        
        clear peak_train
        waitbar( a / steps)
        
    end
    
    if i==nbasal_sessions
        clear  startb endb phase
    else
        
        startb=(endb+(Ts*fs))+1;
        endb=(startb+(Tb*fs));
    end
    
    cd(pathname)
    
    
end
 

%% for Stim
starts=(Tb*fs)+1;
ends=((Ts+Tb)*fs);

for i=1:stim_sessions
    phase=i*2;
    name_Stim_subfolder=['ptrain_' name_exp '_0' num2str(phase) '_Stim' num2str(i) '_' num2str(trigg)];
    cd  (name_folder)
    mkdir(name_Stim_subfolder)
    cd  (name_Stim_subfolder)
   
    for j=1:length(SpikeTrain)
        peak_train=SpikeTrain{j};
        
        peak_train=sparse((peak_train(starts:ends)));
        a=a+1;
        %artifact=round(StimData((starts/fs):((ends/fs)-1)));
        
        artifact=StimDataSamples(find(StimDataSamples>=(starts)&StimDataSamples<=(ends)));
        artifact=(artifact-(starts)-1);
        
        if j<10
            save(['ptrain_'  name_exp '_0' num2str(phase) '_Stim' num2str(i) '_' num2str(trigg) '_0' num2str(j)],'peak_train','artifact','spikes');
        else
            save(['ptrain_' name_exp '_0' num2str(phase) '_Stim' num2str(i) '_' num2str(trigg) '_' num2str(j)],'peak_train','artifact','spikes');
        end
        clear peak_train
        clear artifact
        waitbar( a / steps)
    end
    if i==stim_sessions
        clear  starts ends
    else
        starts=(ends+(Tb*fs))+1;
        ends=(starts+(Ts*fs));
    end
    
    cd(pathname)
end


warndlg('Successfully accomplished!','Conversion')
close(h)
