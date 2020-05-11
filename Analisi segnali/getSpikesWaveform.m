function [tp_waveform,fp_waveform] = getSpikesWaveform(data,tp,fp)
%1 ms before and 1 ms after the timestamp
w_pre=24;
w_post=24;
if isempty(tp)
    tp_waveform=0;
else
for i=1:length(tp)
    tp_waveform(i,:)= data((tp(i)-w_pre):1:(tp(i)+w_post));
end
if isempty(fp)
    fp_waveform=0;
elseif length(fp)==1
        fp_waveform= data((fp-w_pre):1:(fp+w_post));
else 
    for j=2:length(fp)-2
        fp_waveform(j,:)= data((fp(j)-w_pre):1:(fp(j)+w_post));
    end
end
end

