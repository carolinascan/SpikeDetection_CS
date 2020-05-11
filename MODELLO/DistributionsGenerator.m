clc, clear all, close all
rng('default') % For reproducibility
%% Esponenziale

x=(0:400);
lambda_exp=linspace(eps,0.2,100);
for i=1:100;
    mu_exp=lambda_exp(i);
%     y_exp=makedist('Exponential','mu',mu_exp);
    y_exp=(random('Exponential',mu_exp,length(x),1)).*300; %ms 
%     prova=fitdist(x,'y_exp');
    Y_EXP(i,:)=y_exp;
    hf_exp=histfit(y_exp,100,'Exponential');
    delete(hf_exp(1))
    figure (100)
    histfit(y_exp,100,'Exponential'), hold on 
end 
hold off
figure, histogram(Y_EXP,'Normalization','probability')
std_exp=std(Y_EXP');
mean_exp=mean(Y_EXP');
CV_exp=std_exp./mean_exp;
figure
plot(CV_exp,'*r'), hold on, plot(0:100,ones(101),'-k'), legend('Cv exp','valore atteso'), ylim([0 2])
figure
histogram(CV_exp), xlim([0 2]), xlabel('CV exponential'), ylabel('count')
%% Gamma

x=(0:400);
Alfa=linspace(1,9,10);
lambda_g=linspace(eps,1e-2,10);
Y_GAMMA_zero=zeros(110,length(x));
for jj=1:length(Alfa)
    A=Alfa(jj);
    for ii=1:length(lambda_g)
        B=lambda_g(ii); 
        y_gamma=(random('gam',A,B,length(x),1)).*3000;
        yg(ii,:)=y_gamma';
        h=histfit(y_gamma,1,'Gamma');
        delete(h(1))
        figure(100)
        histfit(y_gamma,100,'Gamma'), hold on, 
    end
    row=jj*10:1:jj*10+9;
    Y_GAMMA_zero(row,:)=yg;
   
end
Y_GAMMA=Y_GAMMA_zero(10:109,:);
figure, histogram(Y_GAMMA,'Normalization','probability')
std_gam=std(Y_GAMMA');
mean_gam=mean(Y_GAMMA');
CV_gam=std_gam./mean_gam;
figure, histogram(CV_gam),xlim([0 2]), xlabel('CV gamma'), ylabel('count')
alfa=linspace(1,9,100);
rad_alfa=(1./sqrt(alfa));
figure, plot (CV_gam,'*r'), hold on, plot(rad_alfa(2:end)), legend('Cv','valore atteso'),


%% GAUSSIANA INVERSA 

x=(0:400); %ms
mu_ginv=linspace(eps,0.2,10);
lambda_ginv=linspace(eps,0.3,10);
INV_GAU=zeros(110,length(x));
for jjj=1:length(mu_ginv)
    MU=mu_ginv(jjj);
    for iii=1:length(lambda_ginv)
        LAMBDA=lambda_ginv(iii);
%         ginv= makedist('InverseGaussian','mu',MU,'lambda',LAMBDA);
        inv_gau= random('InverseGaussian',MU,LAMBDA,length(x),1);
        invgau(iii,:)=inv_gau';
        hing=histfit(inv_gau,100,'InverseGaussian')
%         y_ginv=pdf(ginv,0:400);
%         figure (100)
%         plot(0:400,y_ginv), hold on
    end
    figure
    histfit(inv_gau,100,'InverseGaussian'), hold on
    row_gau=jjj*10:1:jjj*10+9;
    INV_GAU_zero(row_gau,:)=invgau;
end 
INV_GAU=INV_GAU_zero(10:109,:);
figure, histogram(INV_GAU)
std_ginv=std(INV_GAU');
mean_ginv=mean(INV_GAU');
CV_ginv=std_ginv./mean_ginv;
figure, histogram(CV_ginv)
lambda_g_inv=(linspace(eps,0.3,101));
rad_lambda=(1./sqrt(lambda_g_inv));
figure, plot (CV_ginv,'*r'), hold on, plot(rad_lambda(2:end)), legend('Cv','valore atteso'), ylim([-20 20])

% %% TRENI DI DELTA 
% %posizioni da esponenziale 
% [SpikePos_EXP] = spike_position(Y_EXP); %suppongo ms 
% %posizioni da gamma 
% % [SpikePos_GAMMA]=spike_position(Y_GAMMA);
% %%h
% fs=2e4; % 20 kHz
% [spikeT_expo,lunghezza_ex]=DELTA_TRAIN(SpikePos_EXP,fs);
% % [spikeT_gamma,lunghezza_ga]=DELTA_TRAIN(SpikePos_GAMMA,fs);
% time_s=(1:length(lunghezza_ex))./fs;
% % figure, stem(time_s,spikeT_expo(67,:)), xlabel('s')
% % figure, stem(spikeT_gamma(67,:))

