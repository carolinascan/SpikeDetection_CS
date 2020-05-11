load('C:\Users\sbuccelli\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\MULTIUNIT+NOISE\SNR 1\Distribuzioni 1\1\signoise1_SNR1.mat')
fs=24414;

params.method = 'numspikes';
params.numspikes = 50;
params.filter = 0;

in.M = data';
in.SaRa = fs;
spikepos7 = PTSD(in,params);

%% spike positions
plot(data)
hold on
plot(spikepos7,data(spikepos7),'r*')

%% using findpeaks
[val,pos]=findpeaks(data,'MinPeakProminence',100,'MinPeakHeight',30);
figure
plot(data)
hold on
plot(pos,data(pos),'r*')