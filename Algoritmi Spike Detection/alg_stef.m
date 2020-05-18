function [ts_checked,waveforms,ts_centered,waveforms_centered] = alg_stef(signal,thr_incl1,thr_incl2,thr_excl)
tj=[];
ts_checked=[];
counter=1;
waveforms=[];
waveforms_centered=[];
w=32;
TS=[];
%% first inclusive threshold 
ts=find(signal<thr_incl1);
tp=ts;
%% filter the timestamps 
tj_next_min=ts(1)+32;
p=ts(2:end)>tj_next_min;
pp=find(p);
idx=pp(1)+1;
first=idx;
for o=1:length(ts)-1
tj_next_min=ts(idx)+32;
p=ts(2:end)>=tj_next_min;
pp=find(p);
if sum(p)==0
    TS(o,1)=idx;
else 
idx=pp(1)+1;
TS(o,1)=idx;
end 
end 
u=diff(TS);
u2=u==0;
u3=find(u2);
u4=u3(1);
TS2=TS(1:u4);
TS_final=[1; first ; TS2];
%first control 32
% for j=1:length(ts)-1
%     if  (ts(j+1)-ts(j))>w
%         tj(counter,:)=ts(j+1);
%         counter=counter+1;
%     end
% end
%% Checking the II inclusive threshold and the exlcusive one
counter2=1;
timestamps=ts(TS_final);
for k=1:length(TS2)
    signal_windowed(k,:)=signal(timestamps(k):timestamps(k)+w-1);
    a=abs(signal_windowed(k,:))<abs(thr_excl);
    b=signal_windowed(k,:)>thr_incl2;
    if (sum(a)==32 && sum(b)>=1)
        waveforms(counter2,:)=signal_windowed(k,:);
        counter2=counter2+1;
        ts_checked(counter2,1)=timestamps(k);
    end
end
%% centering timestamps and waveforms 
for t=1:length(ts_checked)-1;
[peak(t,:),idx(t,:)]=min(waveforms(t,:));
ts_centered=ts_checked(2:end)+idx(t);
waveforms_centered(t,:)=signal(ts_centered(t)-15:ts_centered(t)+16);
end
end 




