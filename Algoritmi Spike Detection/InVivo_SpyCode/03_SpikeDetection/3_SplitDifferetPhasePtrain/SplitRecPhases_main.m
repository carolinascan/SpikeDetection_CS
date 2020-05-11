% SplitRecPhases_main.m
% MAIN SCRIPT
clr

[mainRegExp,regExprToFullfill,numSplit, flag] = splitRecPhases_getParam();
strToBRep = '';
strToRep  = '';

if flag    
    %startingFolder=uigetfolder(sprintf('Choose the starting folder\n(all PeakDetection folders fullfilling the given parameters will be analysed)')); %get the folder from which to start by the user         
    [startingFolder]= selectfolder('Choose the starting folder\n(all PeakDetection folders fullfilling the given parameters will be analysed)');
    splitDifferentPhasePtrainMod(startingFolder, mainRegExp, regExprToFullfill, numSplit, strToBRep, strToRep)    
end