clc, clear all, close all
%% DISTRIBUTIONS GENERATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% INPUT 
%%
mfr=1:22; %spikes/s 
desired_length=60; %s
number_spikes=mean(mfr)*desired_length; %number of spikes in 60 s
%  number_spikes=10000;
%% EXPONENTIAL
param_expo=2;
distribution_length_expo=number_spikes.*param_expo;
mu=1./mfr;
[Y_EXP] = exponential_distribution(distribution_length_expo,mu); 

%% GAMMA
param_gamma=3;
desired_length_gamma=number_spikes.*param_gamma; %to get to 60 s in the first distribution
alfa=[0.1:9];
lambda=[0.1:0.1:0.5];
% lambda=alfa.*mfr;
[Y_GAMMA] = gamma_distribution(desired_length_gamma,alfa,lambda);

%% INVERSE GAUSSIAN 
param_ig=2;
distribution_length_ginv=number_spikes.*param_ig;
mu_ig=1./mfr;
lambda_ig=abs(mfr./(1-mfr.^2));
[Y_INVGAU] = inverse_gaussian(distribution_length_ginv,mu_ig,lambda_ig(2:end));

%% DELTA TRAIN 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
desired_length=60;
time=linspace(0,desired_length,desired_length*24414); 
%% EXPONENTIAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% spike position from exponential distribution 
[SpikePos_EXP] = spike_position(Y_EXP); %spike position s
%% delta train from the exponential distribution
[spikeT_EXPO]=DELTA_TRAIN(SpikePos_EXP,desired_length); %samples 
num_spikes_expo=sum(spikeT_EXPO,2);
mfr_calcolata=num_spikes_expo./desired_length;
expo_matrix.spikeTrain=spikeT_EXPO;
expo_matrix.numSpikes=num_spikes_expo;
expo_matrix.mfr=mfr_calcolata;
%%
save('expo_matrix3.mat','expo_matrix')


%% GAMMA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% spike position from gamma distribution 
[SpikePos_GAMMA]=spike_position(Y_GAMMA); %spike position s
%% delta train from the gamma distribution
[spikeT_GAMMA]=DELTA_TRAIN(SpikePos_GAMMA,desired_length); %samples
num_spikes_gamma=sum(spikeT_GAMMA,2);
mfr_calcolata_gamma=num_spikes_gamma./desired_length;
gamma_matrix.spikeTrain=spikeT_GAMMA;
gamma_matrix.numSpikes=num_spikes_gamma;
gamma_matrix.mfr=mfr_calcolata_gamma;
%%
save('gamma_matrix3.mat','gamma_matrix')


%% INVERSE GAUSSIAN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% spike position from gamma distribution 
[SpikePos_INVGAU]=spike_position(Y_INVGAU); %spike position s
%% delta train from the inverse gaussian distribution
[spikeT_INVGAU]=DELTA_TRAIN(SpikePos_INVGAU,desired_length); %samples
num_spikes_invgau=sum(spikeT_INVGAU,2);
mfr_calcolata_invgau=num_spikes_invgau./desired_length;
invgau_matrix.spikeTrain=spikeT_INVGAU;
invgau_matrix.numSpikes=num_spikes_invgau;
invgau_matrix.mfr=mfr_calcolata_invgau;
%%
save('ig_matrix3.mat','invgau_matrix')
































