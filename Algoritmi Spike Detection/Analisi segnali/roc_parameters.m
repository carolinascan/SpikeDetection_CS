function [FP_rate,TP_rate] = roc_parameters(NREF,FP,NCS,data)
wlen=24; %1 ms
N=(length(data)-NREF*wlen)/wlen;
FP_rate=FP/N;
TP_rate=NCS/NREF;
end

