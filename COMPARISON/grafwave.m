clc, clear all, close all

load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Creazione Segnali\Template\Clustering_Ch6.mat')
%%
ch6_spikes=Clustering_Ch6.spikes;
ch6_cl0=Clustering_Ch6.ZeroCluster; 
ch6_cl1=Clustering_Ch6.FirstCluster
ch6_cl2=Clustering_Ch6.SecondoCluster;

cl0=ch6_spikes(ch6_cl0,:);
cl1=ch6_spikes(ch6_cl1,:);
cl2=ch6_spikes(ch6_cl2,:);

figure 
subplot 311
plot(cl0'), ylabel ('Classe 0')
subplot 312
plot(cl1'), ylabel ('Classe 1')
subplot 313
plot(cl2'), ylabel ('Classe 2')

%%
R13_spikes=Clustering_R13.spikes;
R13_cl1=Clustering_R13.FirstCluster
cl1=R13_spikes(R13_cl1,:);
figure 
plot(cl1'), title('Spikes MU'), ylabel('[microV]'), xlabel('samples')
%%
R1308_spikes=Clustering_R1308.spikes;
R1308_cl0=Clustering_R1308.ZeroCluster
R1308_cl1=Clustering_R1308.FirstCluster
R1308_cl2=Clustering_R1308.SecondCluster

cl1=R1308_spikes(R1308_cl1,:);
cl2=R1308_spikes(R1308_cl2,:);
figure 
subplot 211
plot(cl1'), ylabel('Classe 1')
subplot 212
plot(cl2'), ylabel('Classe 2')

figure 
plot(R1308_spikes'), title('Spikes MU'), ylabel('[microV]'), xlabel('samples')

