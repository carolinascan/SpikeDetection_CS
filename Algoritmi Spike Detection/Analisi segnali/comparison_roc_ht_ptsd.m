clc, clear all, close all
%% MULTI UNIT
list_snr=[1 13 115]; 
list_snr_title=[1 1.3 1.15];
for i=1:length(list_snr)
    %ht
    load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\coordinate roc ht\XY_MU_snr' num2str(list_snr(i)) '.mat'])
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
    % ptsd
    load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\coordinate roc ptsd\XY_MU_snr' num2str(list_snr(i)) '.mat'])
    x2=XY(:,1);
    y2=XY(:,2);
    x_new2=unique(x2);
    for curr_x_unique2=1:length(x_new2)
        y_new2(1,curr_x_unique2)=mean(y2(x2==x_new2(curr_x_unique2)));
    end
    if x_new2(1)==0
        x_interp2(i,:)=[ x_new2' 1];
        y_interp2(i,:)=[ y_new2 1];
    else
        x_interp2(i,:)=[0 x_new2' 1];
        y_interp2(i,:)=[0 y_new2 1];
    end
    xq2=linspace(0,1,100);
    vq2(i,:) = interp1(x_interp2(i,:),y_interp2(i,:),xq2,'linear');
    Legend=cell(2,1);
    Legend{1}='HT' ;
    Legend{2}='ptsd';
    figure, plot(xq,vq(i,:),'LineWidth',1.5,'Color','r'), ylim([0 1]), xlabel('FP rate'), ylabel('TP rate'),title(['SNR ',num2str(list_snr_title(i))]), hold on
    plot(xq2,vq2(i,:),'LineWidth',1.5,'Color','g'), legend(Legend)
    
    clearvars -except list_snr list_snr_title 
end 
%% EXPO
for i=1:length(list_snr)
    %ht
    load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\coordinate roc ht\XY_expo_snr' num2str(list_snr(i)) '.mat'])
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
    % ptsd
    load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\coordinate roc ptsd\XY_expo_snr' num2str(list_snr(i)) '.mat'])
    x2=XY(:,1);
    y2=XY(:,2);
    x_new2=unique(x2);
    for curr_x_unique2=1:length(x_new2)
        y_new2(1,curr_x_unique2)=mean(y2(x2==x_new2(curr_x_unique2)));
    end
    if x_new2(1)==0
        x_interp2(i,:)=[ x_new2' 1];
        y_interp2(i,:)=[ y_new2 1];
    else
        x_interp2(i,:)=[0 x_new2' 1];
        y_interp2(i,:)=[0 y_new2 1];
    end
    xq2=linspace(0,1,100);
    vq2(i,:) = interp1(x_interp2(i,:),y_interp2(i,:),xq2,'linear');
    Legend=cell(2,1);
    Legend{1}='HT' ;
    Legend{2}='ptsd';
    figure, plot(xq,vq(i,:),'LineWidth',1.5,'Color','r'), ylim([0 1]), xlabel('FP rate'), ylabel('TP rate'),title(['SNR ',num2str(list_snr_title(i))]), hold on
    plot(xq2,vq2(i,:),'LineWidth',1.5,'Color','g'), legend(Legend)
    
    clearvars -except list_snr list_snr_title
end 
%% GAMMA
for i=1:length(list_snr)
    %ht
    load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\coordinate roc ht\XY_gamma_snr' num2str(list_snr(i)) '.mat'])
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
    % ptsd
    load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\coordinate roc ptsd\XY_gamma_snr' num2str(list_snr(i)) '.mat'])
    x2=XY(:,1);
    y2=XY(:,2);
    x_new2=unique(x2);
    for curr_x_unique2=1:length(x_new2)
        y_new2(1,curr_x_unique2)=mean(y2(x2==x_new2(curr_x_unique2)));
    end
    if x_new2(1)==0
        x_interp2(i,:)=[ x_new2' 1];
        y_interp2(i,:)=[ y_new2 1];
    else
        x_interp2(i,:)=[0 x_new2' 1];
        y_interp2(i,:)=[0 y_new2 1];
    end
    xq2=linspace(0,1,100);
    vq2(i,:) = interp1(x_interp2(i,:),y_interp2(i,:),xq2,'linear');
    Legend=cell(2,1);
    Legend{1}='HT' ;
    Legend{2}='ptsd';
    figure, plot(xq,vq(i,:),'LineWidth',1.5,'Color','r'), ylim([0 1]), xlabel('FP rate'), ylabel('TP rate'),title(['SNR ',num2str(list_snr_title(i))]), hold on
    plot(xq2,vq2(i,:),'LineWidth',1.5,'Color','g'), legend(Legend)
    
    clearvars -except list_snr list_snr_title
end 
%% IG
for i=1:length(list_snr)
    %ht
    load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\coordinate roc ht\XY_ig_snr' num2str(list_snr(i)) '.mat'])
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
    % ptsd
    load(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\coordinate roc ptsd\XY_ig_snr' num2str(list_snr(i)) '.mat'])
    x2=XY(:,1);
    y2=XY(:,2);
    x_new2=unique(x2);
    for curr_x_unique2=1:length(x_new2)
        y_new2(1,curr_x_unique2)=mean(y2(x2==x_new2(curr_x_unique2)));
    end
    if x_new2(1)==0
        x_interp2(i,:)=[ x_new2' 1];
        y_interp2(i,:)=[ y_new2 1];
    else
        x_interp2(i,:)=[0 x_new2' 1];
        y_interp2(i,:)=[0 y_new2 1];
    end
    xq2=linspace(0,1,100);
    vq2(i,:) = interp1(x_interp2(i,:),y_interp2(i,:),xq2,'linear');
    Legend=cell(2,1);
    Legend{1}='HT' ;
    Legend{2}='ptsd';
    figure, plot(xq,vq(i,:),'LineWidth',1.5,'Color','r'), ylim([0 1]), xlabel('FP rate'), ylabel('TP rate'),title(['SNR ',num2str(list_snr_title(i))]), hold on
    plot(xq2,vq2(i,:),'LineWidth',1.5,'Color','g'), legend(Legend)
    
    clearvars -except list_snr list_snr_title
end 
