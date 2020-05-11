%% Get folders to merge and starting folder
[myGui,srcFolder,FoldersToMerge] = Merge_GUI();
close(myGui);
%% Create destination folder
dest_dr = strcat(srcFolder,'_all');
if ~exist(dest_dr,'dir')
    try
        mkdir(dest_dr)
    catch ME
        error(ME.identifier,ME.message);
    end   
end
%% Create destination sub-folder
[~,folderName] = fileparts(FoldersToMerge{1});
outSubfolder = fullfile(dest_dr,folderName);
if ~exist(outSubfolder,'dir')
    try
        mkdir(outSubfolder)
    catch ME
        error(ME.identifier,ME.message);
    end
end
% Retrieve files to merge from the different folders
for i = 1:length(FoldersToMerge)
    [~,~,fileNames] = dirr(FoldersToMerge{i},'name');
    filesToMerge(:,i) = fileNames';
end
%% Merge files

for i = 1:size(filesToMerge,1)
    spikes_all = [];
    peak_train_all = [];
    artifact_all = [];
    for k = 1:size(filesToMerge,2)
        load(filesToMerge{i,k})
        totLength = length(peak_train_all);
        spikes_all=[spikes_all;spikes];
        peak_train_all = [peak_train_all;peak_train];
        artifact_all = [artifact_all;artifact+totLength-1];
        clear spikes peak_train artifact
    end
    [~,outFilename,~] = fileparts(filesToMerge{i,1});
    outFullFilename = fullfile(outSubfolder,outFilename);
    spikes = spikes_all;
    peak_train = peak_train_all;
    artifact = artifact_all;
    clear spikes_all peak_train_all artifact_all
    save(outFullFilename,'spikes','peak_train','artifact')
    clear spikes peak_train artifact
end