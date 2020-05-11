function [spikes_found_matched_from_model,spikes_found_matched_from_ptsd,check] =match_spikes(spikes_found_from_ptsd,timestamps_found_from_model)
counter=1;
for i=1:length(timestamps_found_from_model) 
    vector_timestamps=[timestamps_found_from_model(i)-12:1:timestamps_found_from_model(i)+12];
    for n=1:25
        idx_timestamps=find(vector_timestamps(n)==spikes_found_from_ptsd);
        if ~isempty(idx_timestamps)
            spikes_found_matched_from_model(counter,1)=vector_timestamps(n);
%             spikes_found_matched_from_ptsd(counter,1)=find(spikes_found_matched_from_model(counter)==timestamps_from_model);
            counter=counter+1;  
        end 
    end
end
check=find(~ismember(spikes_found_from_ptsd,spikes_found_matched_from_model));
appoggio=[check;spikes_found_matched_from_model];
spikes_found_matched_from_ptsd=sort(appoggio);  
end 