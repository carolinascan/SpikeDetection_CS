function [spikes_found_matched_from_alg,spikes_found_matched_from_model,fp,fn] =match_spikes(spikes_found_from_alg,timestamps_from_model)
%% check if the founded timestamp falls within +-20samples of the ground truth
counter=1;
win_n_samples=10;
spikes_found_matched_from_model=[];
spikes_found_matched_from_alg=[];
for i=1:length(timestamps_from_model)
    vector_timestamps=[timestamps_from_model(i)-win_n_samples:1:timestamps_from_model(i)+win_n_samples];
    for n=1:length(vector_timestamps)
        idx_timestamps=find(vector_timestamps(n)==spikes_found_from_alg);
        if ~isempty(idx_timestamps)
            spikes_found_matched_from_alg(counter,1)=vector_timestamps(n);
            spikes_found_matched_from_model(counter,1)=timestamps_from_model(i);
            counter=counter+1;
        end
    end
end
idx_fp=find(~ismember(spikes_found_from_alg,spikes_found_matched_from_alg));
idx_fn=find(~ismember(timestamps_from_model',spikes_found_matched_from_model));
fp=spikes_found_from_alg(idx_fp);
fn=timestamps_from_model(idx_fn);
end