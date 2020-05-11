function makeFig_MAXIMIZE(ax,list_window,INDEX,parameter,level_snr,title_figure,method)
if strcmp(method,'ATLM')
    MAX_index=max(max(INDEX));
    MIN_index=min(min(INDEX));
    [coeff_var,time_var]=((find(INDEX==MAX_index)));
    [coeff_var_min,time_var_min]=((find(INDEX==MIN_index)));
    coeff_var=coeff_var(1);
    time_var=time_var(1);
    coeff_var_min=coeff_var_min(1);
    time_var_min=time_var_min(1);
    XY_index=[time_var coeff_var];
     b=imagesc(ax,INDEX(:,:));
    set(b,'AlphaData',~isnan(INDEX))
    hold(ax,'on')
    plot(ax,time_var,coeff_var,'Og','MarkerSize',20,'LineWidth',3)
    plot(ax,time_var_min,coeff_var_min,'Or','MarkerSize',20,'LineWidth',3)
    title(ax,['Max ' num2str(title_figure) ' = ' num2str(MAX_index,'%1.2f') ' Min ' num2str(title_figure) ' = ' num2str(MIN_index,'%1.2f') ])
    caxis(ax,[0 1])
    colorbar(ax)
    ylabel(ax,'MultCoeff')
    xlabel(ax,'TimeWindow [s]')
    yticks(ax,1:length(parameter))
    yticklabels(ax,{num2str(parameter(1:end)','%1.1f')})
    xticks(ax,1:length(list_window))
    xticklabels(ax,{num2str(list_window([1:length(list_window)])','%1.1f')})
elseif strcmp(method,'SNEO')
    %% SNEO 
    MAX_index=max(max(INDEX));
    MIN_index=min(min(INDEX));
    [coeff_var,time_var]=((find(INDEX==MAX_index)));
    [coeff_var_min,time_var_min]=((find(INDEX==MIN_index)));
    coeff_var=coeff_var(1);
    time_var=time_var(1);
    coeff_var_min=coeff_var_min(1);
    time_var_min=time_var_min(1);
    XY_index=[time_var coeff_var];
     b=imagesc(ax,INDEX(:,:));
    set(b,'AlphaData',~isnan(INDEX))
    hold(ax,'on')
    plot(ax,time_var,coeff_var,'Og','MarkerSize',20,'LineWidth',3)
    plot(ax,time_var_min,coeff_var_min,'Or','MarkerSize',20,'LineWidth',3)
    title(ax,['Max ' num2str(title_figure) ' = ' num2str(MAX_index,'%1.2f') ' Min ' num2str(title_figure) ' = ' num2str(MIN_index,'%1.2f') ])
    caxis(ax,[0 1])
    colorbar(ax)
    ylabel(ax,'MultCoeff')
    xlabel(ax,'SmoothWindow [samples]')
    yticks(ax,1:length(parameter))
    yticklabels(ax,{num2str(parameter(1:end)','%1.1f')})
    xticks(ax,1:length(list_window))
    xticklabels(ax,{num2str(list_window([1:length(list_window)])','%1.1f')})
elseif strcmp(method,'PTSD')
    MAX_index=max(max(INDEX));
    MIN_index=min(min(INDEX));
    [coeff_var,time_var]=((find(INDEX==MAX_index)));
    [coeff_var_min,time_var_min]=((find(INDEX==MIN_index)));
    coeff_var=coeff_var(1);
    time_var=time_var(1);
    coeff_var_min=coeff_var_min(1);
    time_var_min=time_var_min(1);
    XY_index=[time_var coeff_var];
    b=imagesc(ax,INDEX(:,:));
    set(b,'AlphaData',~isnan(INDEX))
    hold(ax,'on')
    plot(ax,time_var,coeff_var,'Og','MarkerSize',20,'LineWidth',3)
    plot(ax,time_var_min,coeff_var_min,'Or','MarkerSize',20,'LineWidth',3)
    title(ax,['Max ' num2str(title_figure) ' = ' num2str(MAX_index,'%1.2f') ' Min ' num2str(title_figure) ' = ' num2str(MIN_index,'%1.2f') ])
    caxis(ax,[0 1])
    colorbar(ax)
    ylabel(ax,'MultCoeff')
    xlabel(ax,'PLP [ms]')
    yticks(ax,1:3:length(parameter))
    yticklabels(ax,{num2str(parameter(1:3:end)','%1.1f')})
    xticks(ax,1:length(list_window))
    xticklabels(ax,{num2str(list_window([1:length(list_window)])','%1.1f')})
end
end
