function [signal,idx,templates] = Signal_Generator(delta_train,Template) 
% Overwrites the spikes waveform over the deltas, idx returns where the deltas are, and so
% the spike positions.
idx=find(delta_train); %finds out where the deltas are
% template is the matrix containing all the waveforms of a cluster  
signal=zeros(1, length(delta_train)); 
% 32 samples 
wpre=18;
wpost=14;
[m,n]=size(Template);

%% put 1 in every
for i=1:length(idx)-1
    bo=idx(i);
    choose_template=randi(m);
    template=Template(choose_template,:);
    smoothing_window=window(@tukeywin,length(template),0.25);
    signal((bo-wpre-1):(bo+wpost+2))=(template-mean(template)).*smoothing_window';
    templates(1,i)=choose_template; 
end
end 