j%% Test spike detection final

% load('signoise1_SNR071.mat');
%close all;
signal_noise=data;
thresh=thresh_vector;
% compare them do it in terms of msec intervals
th_type=0;
w_pre=1;
w_post=1.5;
DMdpolar='negative'
PLP=2;
RP=1;
th_factor=7;
fs=24414;
data_in=signal_noise;
% [data_out,dthresh]=ptsd(signal_noise,th_type,th_factor,fs,w_pre,w_post,DMdpolar,PLP,RP,thresh);
% allspikes1=find(data_out{1}.peak_train);

% Depending on noise level change delta and T
a=data_in-mean(data_in);
delta=1/4*1e-3;
T=1.125*median(abs(a))./0.6745;
[allspikes2]= DMT(a,delta,T,fs);
%%
figure, plot(data), hold on, plot(allspikes2,data(allspikes2),'*r')
%%
%% 
T=1.125*median(abs(a))./0.6745;
mPW=0.24*1e-3;
[reference_train]= adPT(data_in,mPW,T,fs)
%% 
%WINDOW_TEST=1:length(data_in);
WINDOW_TEST=6100:6100+700;
spikes1=allspikes1(allspikes1>WINDOW_TEST(1));
spikes1=spikes1(spikes1<WINDOW_TEST(end))-WINDOW_TEST(1)+1;
spikes2=allspikes2(allspikes2>WINDOW_TEST(1));
spikes2=spikes2(spikes2<WINDOW_TEST(end))-WINDOW_TEST(1)+1;

length(spikes1)
length(spikes2)

pdata_in=data_in(WINDOW_TEST)*1e6;
figure('Position', [20, 300, 1.32e3, 310]);hold on; 
plot(pdata_in);
plot(spikes1,pdata_in(spikes1),'r*');
plot(spikes2,pdata_in(spikes2),'ko');
legend('all','PTSD','aPT')
hold off;
