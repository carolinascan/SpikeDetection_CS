function make_figure_eff(list_PLP,parameter,eff,level_snr, method)
if strcmp(method,'PTSD')
   
    MAX=max(max(eff));
    [coeff_var,time_var]=find(eff==MAX)
    if length(coeff_var)>1
        coeff_var=coeff_var(1);
        time_var=time_var(1);
    end 
    save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\max_eff_' ,num2str(level_snr) '.mat'],'coeff_var','time_var','MAX')
    imagesc(eff(:,:))
    title(['Max Efficiency = ', num2str([MAX],'%1.2f'),' Best PLP = ', num2str(list_PLP(time_var),'%1.2f'),' Best param = ', num2str(parameter(coeff_var),'%1.2f')])
    colorbar
    ylabel('Parameter')
    xlabel('PLP')
    yticks(1:length(parameter))
    yticklabels({num2str(parameter(1:end)','%1.1f')})
    xticks(1:length(list_PLP))
    xticklabels(num2str(list_PLP([1:length(list_PLP)])','%1.1f'))  
    suptitle(['Algorithm  ' method ' SNR = ' num2str(level_snr)])
%     caxis([0 100])
elseif strcmp(method,'ATLM')

    MAX=max(max(eff));
    [coeff_var,time_var]=find(eff==MAX)
    if length(coeff_var)>1
        coeff_var=coeff_var(1);
        time_var=time_var(1);
    end 
%     save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\ATML ANALISI\max_eff_' ,num2str(level_snr) '.mat'],'coeff_var','time_var','MAX')
    imagesc(eff(:,:))
    title(['Max Efficiency = ', num2str([MAX],'%1.2f'),' Best sneoN = ', num2str(list_PLP(time_var),'%1.2f'),' Best multCoeff = ', num2str(parameter(coeff_var),'%1.2f')])
    colorbar
    ylabel('Parameter')
    xlabel('TimeWindow')
    yticks(1:length(parameter))
    yticklabels({num2str(parameter(1:end)','%1.1f')})
    xticks(1:length(list_PLP))
    xticklabels(num2str(list_PLP([1:length(list_PLP)])','%1.1f'))
    suptitle(['Algorithm  ' method ' SNR = ' num2str(level_snr)])
%      caxis([0 100])
elseif strcmp(method,'SNEO')
        figure
    three_points=[1:length(list_PLP)];
    MAX=max(max(eff));
    [coeff_var,time_var]=find(eff==MAX)
    if length(coeff_var)>1
        coeff_var=coeff_var(1);
        time_var=time_var(1);
    end 
    save(['C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\SNEO ANALISI\max_eff_' ,num2str(level_snr) '.mat'],'coeff_var','time_var','MAX')
    imagesc(eff(:,:))
    title(['Max Efficiency = ', num2str([MAX],'%1.2f'),' Best SmoothingWindow = ', num2str(list_PLP(time_var),'%1.2f'),' Best multCoeff = ', num2str(parameter(coeff_var),'%1.2f')])
    colorbar
    ylabel('MultCoeff')
    xlabel('SmoothingWindow [samples]')
    yticks(1:length(parameter))
    yticklabels({num2str(parameter(1:end)','%1.1f')})
    xticks(1:length(list_PLP))
    xticklabels(num2str(list_PLP([1:length(list_PLP)])','%1.1f'))
    suptitle(['Algorithm  ' method ' SNR = ' num2str(level_snr)])
%      caxis([0 100])
end 
end

