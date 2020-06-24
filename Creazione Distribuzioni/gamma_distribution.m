function [Y_GAMMA] = gamma_distribution(desired_length,a,b)

x=1:desired_length;
alfa=linspace(a(1),a(end),10);
lambda=linspace(b(1),b(end),10);
Y_GAMMA_zero=zeros(110,length(x));
for jj=1:length(alfa)
    A_curr=alfa(jj);
    for ii=1:length(lambda)
        B_curr=lambda(ii); 
        %% generating ISI
        ISI_gamma=makedist('Gamma','a',A_curr,'b',B_curr); 
        trunc_gamma=truncate(ISI_gamma,1e-3,20); %isi<1 ms and isi>200 ms are excluded 
        ISI_trunc_gamma=random(trunc_gamma,length(x),1);
        g(ii,:)=ISI_trunc_gamma';
        %% fitting the distribution
        figure(1) 
        hf_gamma=histfit(ISI_trunc_gamma,100,'Gamma'), hold on
        delete(hf_gamma(1))
        hf_gamma(2).LineWidth=0.2;
        title('Gamma distribution')
        xlabel('Time [s]')
        ylabel('Count')
        [k,edges]=histcounts(ISI_trunc_gamma,'Normalization','probability','BinEdges',[0:0.1:8]);
        kk=smooth(k);
        figure (2)
        plot(edges(2:end).*100,kk), hold on
        title('ISI Gamma'),xlabel('Time [s]'), ylabel('Probability')
    end
    %% concatenating in a bigger matrix 110xlength(x)
    row=jj*10:1:jj*10+9;
    Y_GAMMA_zero(row,:)=g;
end
%% extracting from the previous matrix only the data we are looking for 
Y_GAMMA=Y_GAMMA_zero(10:109,:);
%% 
figure, histogram(Y_GAMMA.*100,'Normalization','probability')
title('Gamma distribution')
xlabel('Time [ms]')
ylabel('Probability')
%% getting statistical features
std_gam=std(Y_GAMMA,0,2);
mean_gam=mean(Y_GAMMA,2);
CV_gam=std_gam./mean_gam;

%% 
figure, histogram(CV_gam),xlim([0 2]), xlabel('CV gamma'), ylabel('count')
%% 
Alfa=linspace(alfa(1),alfa(end),100);
rad_alfa=(1./sqrt(Alfa));
figure, plot (Alfa(2:end),CV_gam(2:end),'*r'), hold on, plot(Alfa(2:end),rad_alfa(2:end)), legend('Cv','expected values'),
xlabel('alpha value')
title('Coefficient of variation vs Alpha values')

end

