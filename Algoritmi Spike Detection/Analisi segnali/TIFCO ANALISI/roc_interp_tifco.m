clc, clear all, close all
%%
param1=1;
param2=20;
list_snr=[1 13 115];
parametro=linspace(param1,param2,30);
%% MU
list_snr=[1 13 115];
for i=1:length(list_snr)
    load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\coordinate roc tifco\XY_MU_snr' num2str(list_snr(i)) '.mat'])
    x=XY(:,1);
    y=XY(:,2);
    xf=flip(x);
    yf=flip(y);
    x_new=unique(xf);
    for curr_x_unique=1:length(x_new)
        y_new(1,curr_x_unique)=mean(yf(xf==x_new(curr_x_unique)));
    end
    if x_new(1)==0
        x_interp(i,:)=[ x_new' 1];
        y_interp(i,:)=[ y_new 1];
    else
        x_interp(i,:)=[0 x_new' 1];
        y_interp(i,:)=[0 y_new 1];
    end
    xq=linspace(0,1,100);
    vq(i,:) = interp1(x_interp(i,:),y_interp(i,:),xq,'linear');
    Legend=cell(3,1);
    Legend{1}='SNR 1' ;
    Legend{2}='SNR 1.3';
    Legend{3}='SNR 1.15';
    figure(1), plot(xq,vq(i,:)), ylim([0 1]), xlabel('FP rate'), ylabel('TP rate'), legend(Legend), hold on
%     AUC=trapz(x_interp(i,:),y_interp(i,:))
    EFF_max(i,1)=max(eff);
    
    figure(2), plot(parametro,eff), xlabel('parametro'), ylabel('efficienza %'), ylim([0 100]), legend(Legend), title(['Max Efficiency SNR 1 = ', num2str(EFF_max(1),'%1.2f')]) , hold on
%     save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\AUC HT\AUC_MU_SNR' num2str(list_snr(i)) '.mat'],'AUC')
    clear XY x y x_new x_interp y_new y_interp curr_x_unique
end

%% EXPO
list_snr=[1 13 115];
parametro=linspace(param1,param2,10);
for i=1:length(list_snr)
    load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\TIFCO ANALISI\coordinate roc tifco\XY_expo_snr' num2str(list_snr(i)) '.mat'])
    x=XY(:,1);
    y=XY(:,2);
    x_new=unique(x);
    for curr_x_unique=1:length(x_new)
        y_new(1,curr_x_unique)=mean(y(x==x_new(curr_x_unique)));
    end
    if x_new(1)==0
        x_interp(i,:)=[ x_new' 1];
        y_interp(i,:)=[ y_new 1];
    else
        x_interp(i,:)=[0 x_new' 1];
        y_interp(i,:)=[0 y_new 1];
    end
    xq=linspace(0,1,100);
    vq(i,:) = interp1(x_interp(i,:),y_interp(i,:),xq,'linear');
    Legend=cell(3,1) 
    Legend{1}='SNR 1' ;
    Legend{2}='SNR 1.3';
    Legend{3}='SNR 1.15';
    figure(1), plot(xq,vq(i,:)), ylim([0 1]), xlabel('FP rate'), ylabel('TP rate'), legend(Legend), hold on
    figure(2), plot(parametro,eff), xlabel('parametro'), ylabel('efficienza %'), ylim([0 100]), legend(Legend), hold on
    AUC=trapz(x_interp(i,:),y_interp(i,:))
%     save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\AUC HT\AUC_expo_SNR' num2str(list_snr(i)) '.mat'],'AUC')
    clear XY x y x_new x_interp y_new y_interp AUC curr_x_unique
end

%% GAMMA
list_snr=[1 13 115];
for i=1:length(list_snr)
    load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\coordinate roc ht\XY_gamma_snr' num2str(list_snr(i)) '.mat'])
    x=XY(:,1);
    y=XY(:,2);
    x_new=unique(x);
    for curr_x_unique=1:length(x_new)
        y_new(1,curr_x_unique)=mean(y(x==x_new(curr_x_unique)));
    end
    if x_new(1)==0
        x_interp(i,:)=[ x_new' 1];
        y_interp(i,:)=[ y_new 1];
    else
        x_interp(i,:)=[0 x_new' 1];
        y_interp(i,:)=[0 y_new 1];
    end
    xq=linspace(0,1,100);
    vq(i,:) = interp1(x_interp(i,:),y_interp(i,:),xq,'linear');
    Legend=cell(3,1)%  two positions
    Legend{1}='SNR 1' ;
    Legend{2}='SNR 1.3';
    Legend{3}='SNR 1.15';
    figure(1), plot(xq,vq(i,:)), ylim([0 1]), xlabel('FP rate'), ylabel('TP rate'), legend(Legend), hold on
    figure(2), plot(parametro,eff), xlabel('parametro'), ylabel('efficienza %'), ylim([0 100]), legend(Legend), hold on
    AUC=trapz(x_interp(i,:),y_interp(i,:))
    save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\AUC HT\AUC_gamma_SNR' num2str(list_snr(i)) '.mat'],'AUC')
    clear XY x y x_new x_interp y_new y_interp AUC curr_x_unique
end


%% INVGAU
list_snr=[1 13 115];
for i=1:length(list_snr)
    load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\coordinate roc ht\XY_ig_snr' num2str(list_snr(i)) '.mat'])
    x=XY(:,1);
    y=XY(:,2);
    x_new=unique(x);
    for curr_x_unique=1:length(x_new)
        y_new(1,curr_x_unique)=mean(y(x==x_new(curr_x_unique)));
    end
    if x_new(1)==0
        x_interp(i,:)=[ x_new' 1];
        y_interp(i,:)=[ y_new 1];
    else
        x_interp(i,:)=[0 x_new' 1];
        y_interp(i,:)=[0 y_new 1];
    end
    xq=linspace(0,1,100);
    vq(i,:) = interp1(x_interp(i,:),y_interp(i,:),xq,'linear');
    Legend=cell(3,1)%  two positions
    Legend{1}='SNR 1' ;
    Legend{2}='SNR 1.3';
    Legend{3}='SNR 1.15';
    figure(1), plot(xq,vq(i,:)), ylim([0 1]), xlabel('FP rate'), ylabel('TP rate'), legend(Legend), hold on
    figure(2), plot(parametro,eff), xlabel('parametro'), ylabel('efficienza %'), ylim([0 100]), legend(Legend), hold on
    AUC=trapz(x_interp(i,:),y_interp(i,:))
    save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\HT ANALISI\AUC HT\AUC_ig_SNR' num2str(list_snr(i)) '.mat'],'AUC')
    clear XY x y x_new x_interp y_new y_interp AUC curr_x_unique
end
