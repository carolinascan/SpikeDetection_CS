function [Y_INVGAU] = inverse_gaussian(desired_length,mu,lambda)  
x=1:desired_length; % x(length) determines the number of spikes 
mu_ginv=linspace(mu(1),mu(end),10);
lambda_ginv=linspace(lambda(1),lambda(end),10);
Y_INVGAU=zeros(110,length(x));
for jjj=1:length(mu_ginv)
    MU_curr=mu_ginv(jjj);
    for iii=1:length(lambda_ginv)
        LAMBDA_curr=lambda_ginv(iii);
        ISI_ginv= makedist('InverseGaussian','mu',MU_curr,'lambda',LAMBDA_curr);
        trunc_ginv=truncate(ISI_ginv,1e-3,3);
        ISI_trunc_ginv= random(trunc_ginv,length(x),1);
        [k,edges]=histcounts(ISI_trunc_ginv,'Normalization','probability','BinEdges',[0:0.1:5]);
        kk=smooth(k,8);
        invgau(iii,:)=ISI_trunc_ginv';
        figure(1)
        hf_invgau=histfit(ISI_trunc_ginv,1e4,'InverseGaussian'), hold on
        delete(hf_invgau(1));
        hf_invgau(2).LineWidth=0.2;
        title('Inverse Gaussian distribution')
        xlabel('Time [s]')
        ylabel('Count')
        figure(2)
        plot(edges(2:end).*100,kk), hold on 
        title('ISI Inverse Gaussian'),xlabel('Time [s]'), ylabel('Probability')
    end
    row_gau=jjj*10:1:jjj*10+9;
    INV_GAU_zero(row_gau,:)=invgau;
end 
%% extracting from the previous matrix only the data we are looking for 
Y_INVGAU=INV_GAU_zero(10:109,:);
%% 
figure, histogram(Y_INVGAU.*100,'Normalization','probability')
title('Inverse Gaussian distribution')
xlabel('Time [s]')
ylabel('Probability')
% %% getting statistical features
std_ginv=(std(Y_INVGAU,0,2));  
mean_ginv=(mean(Y_INVGAU,2));

%% 
lambda_x=linspace(lambda_ginv(1),lambda_ginv(end),100);
mu_x=linspace(mu_ginv(1),mu_ginv(end),100);
% std_ginv=(sqrt(((mu_x).^3)./lambda_x)h);
CV_ginv=sqrt(mean_ginv./std_ginv);
rad_lambda=1./sqrt(lambda_x);
figure 
histogram(CV_ginv), xlabel('CV inverse gaussian'), ylabel('count')
figure, plot (lambda_x,CV_ginv,'*r'), hold on, plot(lambda_x,rad_lambda), legend('Cv','Expected values')
title('Coefficient of variation vs Lambda values')
end 
