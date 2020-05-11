% plot_4x4grid3.m

% Modified by Alberto Averna Feb 2015 for In Vivo 16 chs system
%clr
% --------------- MEA variables
lookuptable= [  1  1; 7  2; 13  3; 14  4; 3  5; 4  6; 10  7; 16  8; ...
                2  9; 8 10; 12 11; 11 12; 6 13; 5 14; 9 15; 15 16];
 %mcmea_electrodes = [(11:18)'; (21:28)'; (31:38)'; (41:48)'; (51:58)'; (61:68)'; (71:78)';(81:88)']; % electrode names
 mcmea_electrodes = (1:16); % electrode names
 nch = length(mcmea_electrodes);
 namelegend={};
% Select the source and target folder
[start_folder]= selectfolder('Select the source folder that contains the PSTH files'); %The foldername contains the binsize
if strcmp(num2str(start_folder),'0')
    errordlg('Selection Failed - End of Session', 'Error');
    return
end
end_folder = uigetdir(pwd,'Select the PSTHresults folder');
if strcmp(num2str(end_folder),'0')
    errordlg('Selection Failed - End of Session', 'Error');
    return
end
% Create the end_folder that will contain the 8x8plots of the PSTH
[exp_num]=find_expnum(start_folder, '_PSTHfiles');
[end_folder]=createresultfolder(end_folder, exp_num, 'PSTH_plot8x8grid');
[psthend,yaxis,list_stimel_user,num_stimel_user,cancelFlag] = uiget8x8gridinfo; % USER information
clear title prompt lines def

if cancelFlag
    errordlg('Selection Failed - End of Session', 'Error');
    return
end
% --------------- Property of the PLOT
binindex1=strfind(start_folder, 'bin');
binindex2=strfind(start_folder, '-');
binsize=str2double(start_folder(binindex1+3:binindex2(end)-1));
timeframeindex=strfind(start_folder, 'msec');
timeframe= str2double(start_folder(binindex2(end)+1:timeframeindex-1));
x=binsize*(1:timeframe/binsize);

coll = ['k','r','b','g','y']; % Colors of multiple plot
style=cell(4,1); % Useful if we want to change the style
style{1,1}='-'; % style{1,1}=':';
style{2,1}='-'; % style{2,1}='-';
style{3,1}='-'; % style{3,1}='--';
style{4,1}='-';
style{5,1}='-';

% -------------- START PROCESSING ------------

[name_all_dir_cell,list_stimel] = uigetfolderinfo(start_folder);    % gets information about the directory
listOK = IsListStimOk(list_stimel,list_stimel_user)               % checks if the stimulation sites choosen by the user is OK

if (listOK == 1)
    % Only names of the directories - cell array - selected by the user
    name_dir_cell = cell(1,1);
    
    name_dir = [];
    for i=1:num_stimel_user
        for j=1:length(name_all_dir_cell)
            namefile = name_all_dir_cell{j};
            idx = findstr('Stim',namefile);
            stimphase = str2double(namefile(idx+4));
            if stimphase == list_stimel_user(i)
                %name_dir = [name_dir; namefile];
                name_dir_cell{j} = namefile;
            end
        end
    end
    %name_dir_cell = cellstr(name_dir);

    % Save in the array 'stimoli' the names of the stimulating electrodes
    for i=1:(num_stimel_user) % In the case of tetanus experiment, this number is 3.
        last_=max(strfind(name_dir_cell{i},'_'));
        stimoli(i)=str2double(name_dir_cell{i}(last_+1:end));
    end

    for t=1:length(list_stimel_user)
        namelegend{t}=['Stim' num2str(list_stimel_user(t))];
    end
    for k=1:length(unique(stimoli))
        
        
        stimel= stimoli(k); % name of the stimulating electrodes - double
        [index]=findfolder(name_dir_cell, stimel);
        for j=1:length(index)
        
        folder_path= strcat (start_folder, filesep, name_dir_cell{index(j)});
        scrsz = get(0,'ScreenSize');
        h=figure('Position',[1+100 scrsz(1)+100 scrsz(3)-200 scrsz(4)-200]);
         for i = 1:nch       % start cycling on the directories
            electrode=mcmea_electrodes(i); % name of the considered electrode - double
            
                if electrode<10
                filename= strcat(name_dir_cell{index(j)}, '_0', num2str(electrode), '.mat');
                else
                filename= strcat(name_dir_cell{index(j)}, '_', num2str(electrode), '.mat');    
                end
                graph_pos= lookuptable(find(lookuptable(:,1)==electrode),2);
                subplot(4,4,graph_pos)
              
                if exist(fullfile(folder_path, filename))
                    load (fullfile(folder_path, filename))
                    y=bar(x, psthcnt);
                end
                
               
                
                hold on
                axis ([0 psthend 0 yaxis])
                
                box off
                %set(gca,'ytick',[]);
                set(gca,'xtick',[]);
              text(psthend-0.5,yaxis,num2str(electrode))
                
                if (electrode == stimel)
                    title('Trigg')
                    %text(psthend-0.5,yaxis-0.5,'Trigg')
                end
         end
            
            nome = strcat('PSTH_4x4grid_Stim', num2str(j));
            cd(end_folder)
            saveas(y,[nome,'.jpg'],'jpg');
            saveas(y,[nome,'.fig'],'fig');
            cd (start_folder)
           close (h)
        end
        
        
       
    end

    EndOfProcessing (start_folder, 'Successfully accomplished');
end


clear all
