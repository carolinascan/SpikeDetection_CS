function [TS,soglia,rp_samples] = atlm(signal,parameter,rp_variable)
fc=24414;
rp_time=rp_variable;
rp_samples=floor(rp_time*fc);
w=round(length(signal)/rp_samples);
LOCS=NaN(w,length(signal));
for i=1:w-1
    signal_windowed(i,:)=signal((i-1)*rp_samples+1:i*rp_samples);
    dev=-std(signal_windowed(i,:));
    soglia(i,1)=-parameter*dev;
    [peaks,locs]=findpeaks(-(signal((i-1)*rp_samples+1:i*rp_samples)),'MinPeakHeight',soglia(i),'MinPeakDistance',24);
    LOCS(i,1:length(locs))=locs;
end
idx1=~isnan(LOCS(1,:));
timestamps_found1(:,1)=LOCS(1,idx1);
counter=1;
TJ=[];
for j=2:w
    idx=~isnan(LOCS(j,:));
    timestamps_foundj=LOCS(j,idx)+((j-1)*rp_samples); 
    TJ=[TJ;timestamps_foundj'];
    clear timestamps_foundj
end
TS=[timestamps_found1;TJ];
end





%% metodo senza findpeaks 
% for i=1:w
%     signal_windowed(i,:)=signal((i-1)*rp_samples+1:i*rp_samples);
%     dev(i)=-std(signal_windowed(i,:));
%     for j=1:length(signal_windowed)
%         if signal_windowed(i,j)<parameter*dev(i)
%             timestamps_found(counter,:)=j+((i-1)*rp_samples);
%             counter=counter+1;
%         end
%     end
% end
% for k=1:length(timestamps_found)-1
%     vector=timestamps_found(k):timestamps_found(k)+24;
%     for p=1:length(vector)
%     if timestamps_found(k+1)==vector(p)
%         timestamps_found(k+1)=NaN;
%     end
%     end
% end
% idx=~isnan(timestamps_found);
% timestamps_found_filtered=timestamps_found(idx);
% for f=1:length(timestamps_found_filtered)
%     v_samples=(timestamps_found_filtered(f)-24:timestamps_found_filtered+24)';
%     v_voltage=signal(v_samples)';
%     V=[v_samples v_voltage];
%     [minv,ind]=min(V(:,2));
%     timestamps_found_min=V(ind,1);
% end
% for d=1:length(timestamps_found_min)-1
%     vector2=timestamps_found_min(d):timestamps_found_min(d)+24;
%     for h=1:length(vector2)
%     if timestamps_found_min(d+1)==vector(h)
%         timestamps_found_min(d+1)=NaN;
%     end
%     end
% end
% idx2=~isnan(timestamps_found_min);
% timestamps_found_min_filtered=timestamps_found_min(idx2);
% end

