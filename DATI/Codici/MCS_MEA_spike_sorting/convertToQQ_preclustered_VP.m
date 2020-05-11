%% Convert to Wave_clus by R. Quian Quiroga input format (spike-detected data)
% Code to convert the output of the PTSD spike detection algorithm to a format
% that can be fed into the spike sorting tool Wave_clus by R. Quian Quiroga
%%
% Get input folder
startFolder = uigetdir(pwd,'Select the PeakDetectionMAT folder to convert:');
if strcmp(num2str(startFolder),'0')          % halting case
    return
end
% Set parameters
sf = 10000;
%% Conversion
% [~,~,meta_tmp]=dirr(startFolder,'*_metadata.mat','name','isdir','1');
% load(meta_tmp{1});
% Load experiment number
[srcFldr,nameExp,~] = fileparts(startFolder);
index = find(nameExp=='_');
nameExp = nameExp(1:index(1)-1);
clear index
% Create output folder
qqFldr=fullfile(srcFldr,strcat('QQ_',nameExp));
if ~exist(qqFldr,'dir')
    mkdir(qqFldr)
end
[~,~,nameFldr]=dirr(startFolder,'name','isdir','0');
% [~,~,nameFiles]=dirr(startFolder,'name','isdir','1');
% if length(nameFldr)~=length(nameFiles)
%     nameFiles=nameFldr;
%     clear nameFldr
%     for i=1:length(nameFiles)
    for i=1:length(nameFldr)
%         [~,namePart,~]=fileparts(nameFiles{i});
        [~,namePart,~]=fileparts(nameFldr{i});
        namePart=fullfile(qqFldr,namePart);
        if ~exist(namePart,'dir')
            mkdir(namePart);
        end
%         [~,~,matFiles]=dirr(nameFiles{i},'\.mat\>','name');
        [~,~,matFiles]=dirr(nameFldr{i},'\.mat\>','name');
        for k=1:length(matFiles)
            load(matFiles{k})
            clear artifact
            index=find(peak_train~=0)./(sf/1000);
            index=index';
            t_length=length(peak_train);
            clear peak_train
            [~,filenm,~]=fileparts(matFiles{k});
            save(fullfile(namePart,filenm),'index','spikes','t_length');
            clear index spikes name t_length
        end
    end
% else
%     clear nameFldr
%     for k=1:length(nameFiles)
%         load(nameFiles{k})
%         clear artifact
%         index=find(peak_train~=0)./(sf/1000);
%         index=index';
%         t_length=length(peak_train);
%         clear peak_train
%         [~,filenm,~]=fileparts(nameFiles{k});
%         save(fullfile(qqFldr,filenm),'index','spikes','t_length');
%         clear index spikes name t_length
%     end
% end