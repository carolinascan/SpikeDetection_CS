function [Y_EXP] = exponential_distribution(distribution_length,mu)
for curr_distr=1:100
    mu_exp=linspace(mu(1),mu(end),100);
    x=1:distribution_length;
    mu_curr_exp=mu_exp(curr_distr);
    %% generating ISI
    ISI_exp=makedist('Exponential','mu',mu_curr_exp); %s
    trunc_expo=truncate(ISI_exp,1e-3,5); %isi<1 ms are excluded 
    isi_trunc_expo=random(trunc_expo,distribution_length,1);
    Y_EXP(curr_distr,:)=isi_trunc_expo';
    %% concatenating in a matrix
%     fitting the distribution
%     figure(1)
%     hf_exp=histfit(isi_trunc_expo,100,'Exponential'); % 100 is the bin number 
%     hold on
%     delete(hf_exp(1))
%     hf_exp(2).LineWidth=0.2;
%     title('Exponential distributions')
%     xlabel('Time [s]')
%     ylabel('Count')
    [k,edges]=histcounts(isi_trunc_expo,'Normalization','probability','BinEdges',0:0.1:5);
    kk=smooth(k);
    figure(2)
    plot(edges(2:end).*100,kk), hold on 
    title('ISI Exponential'),xlabel('Time [ms]'), ylabel('Probability')
end

% generating general distribution
figure, histogram(Y_EXP.*100,'Normalization','probability')
title('Exponential distribution')
xlabel('Time [ms]')
ylabel('Probability')
% getting statistical features
% std_exp=std(Y_EXP,0,2);
% mean_exp=mean(Y_EXP,2);
% CV_exp=std_exp./mean_exp; % coefficient of variation
% %
% figure
% plot(mu_exp,CV_exp,'*r'), hold on, plot(mu_exp,ones(1,100),'-k'), legend('Cv exp','expected value'), ylim([0 2])
% xlabel('mu value')
% title('Coefficient of variation vs Mu values')
% % %
% figure
% histogram(CV_exp), xlim([0 2]), xlabel('CV exponential'), ylabel('count')
end

