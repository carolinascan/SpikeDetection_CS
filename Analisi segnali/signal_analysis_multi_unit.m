function [analysis] = signal_analysis_multi_unit(timestamps_from_algorithm,timestamps_from_model,data)
% load timestamps found
NS=length(timestamps_from_algorithm); 
% from model 
spikes_position1=timestamps_from_model.unit1;
spikes_position2=timestamps_from_model.unit2;
spikes_position3=timestamps_from_model.unit3;
timestamps_from_model=sort([spikes_position1 spikes_position2 spikes_position3]);
%% Positives
NREF=length(timestamps_from_model);
analysis.NREF=NREF;
%% Negatives 
wlen=24; %1 ms
N=(length(data)-NREF*wlen)/wlen;
%% MATCHING SPIKES 
[spikes_found_matched,spikes_found_matched_from_model,fp,fn] = match_spikes(timestamps_from_algorithm,timestamps_from_model');
%% GIT CALCULATION
git=(spikes_found_matched-spikes_found_matched_from_model);
%% TRUE
true_positive=length(spikes_found_matched);
%% FALSE
false_positive=length(fp);
false_negative=NREF-true_positive;
%% TRUE NEGATIVE
true_negative=N-false_positive;
%% RATE
sensitivity=true_positive/NREF;     %tp_rate
specificity=true_negative/N;        %tn_rate or selectivity 
FN_rate=false_negative/NREF;        %miss rate
FP_rate=false_positive/N;           %fall out                              
false_discovery_rate=(false_positive/NS); %NS=FP+TP
eff=true_positive/(NREF+false_positive); %efficiency
accuracy=(true_positive+true_negative)/(N+NREF);
F1_Score=2*true_positive/(2*true_positive+false_positive+false_negative);
precision=true_positive/(true_positive+false_positive);
negative_predictive_value=true_negative/(true_negative+false_negative);
false_omission_rate=false_negative/(false_negative+true_negative);
MCC=(true_positive*true_negative-false_positive*false_negative)/sqrt((true_positive+false_positive)*(true_positive+false_negative)*(true_negative+false_positive)*(true_negative+false_negative));
%% Save 
analysis.git=git;
analysis.tp=true_positive;
analysis.fp=false_positive;
analysis.tn=true_negative;
analysis.fn=false_negative;
analysis.sensitivity=sensitivity;
analysis.specificity=specificity;
analysis.FN_rate=FN_rate;
analysis.FP_rate=FP_rate;
analysis.false_discovery_rate=false_discovery_rate;
analysis.eff=eff;   %or treat score or critical success index 
analysis.TS_tp=spikes_found_matched;
analysis.TS_tp_from_model=spikes_found_matched_from_model;
analysis.TS_fp=fp;
analysis.TS_fn=fn;
analysis.accuracy=accuracy;
analysis.F1_score=F1_Score;
analysis.precision=precision;
analysis.FOR=false_omission_rate;
analysis.MCC=MCC;
analysis.NPV=negative_predictive_value;
end
