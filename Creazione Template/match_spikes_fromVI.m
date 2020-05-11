function [XYcorrected] = match_spikes_fromVI(XY_SelectedSpikes,data)
%XY_SelectedSpikes in samples(first column) and microV in the second one 
voltage=XY_SelectedSpikes(:,2);
for i=1:length(XY_SelectedSpikes(:,1))
    if voltage(i)<=-20
    snap=[round((XY_SelectedSpikes(i,1)-(2/1000*24414):XY_SelectedSpikes(i,1)+(2/1000*24414)))' ...
        round(data(XY_SelectedSpikes(i,1)-(2/1000*24414):XY_SelectedSpikes(i,1)+(2/1000*24414)))];
    for j=1:length(snap)
        D(j) = pdist([[XY_SelectedSpikes(i,1),XY_SelectedSpikes(i,2)];snap(j,:)]);
    end
    XYcorrected(i,:)=snap(find(D==min(D)),:);
    clear snap D
    else
    XYcorrected(i,:)=[NaN NaN];    
    end 
end

