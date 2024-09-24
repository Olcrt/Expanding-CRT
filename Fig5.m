
%Figure. 5.
load('wind_current.mat');

[imf_2, residual_2] = emd(wind_m,'SiftRelativeTolerance',0,'SiftMaxIterations',2);
[imf_3, residual_3] = emd(wind_m,'SiftRelativeTolerance',0,'SiftMaxIterations',3);
[imf_4, residual_4] = emd(wind_m,'SiftRelativeTolerance',0,'SiftMaxIterations',4);
[imf_5, residual_5] = emd(wind_m,'SiftRelativeTolerance',0,'SiftMaxIterations',5);
[imf_6, residual_6] = emd(wind_m,'SiftRelativeTolerance',0,'SiftMaxIterations',6);

for i=1:240
    wind_t_std(i,1) = std([residual_5(i),residual_6(i),residual_2(i),residual_3(i),...
        residual_4(i)]);
    wind_t_m(i,1) = nanmean([residual_5(i),residual_6(i),residual_2(i),residual_3(i),...
        residual_4(i)]);    
end

Tt_wind_dt_m = wind_t_m - detrend(wind_t_m);
Tt_wind_yr = (Tt_wind_dt_m(end) - Tt_wind_dt_m(1))/240*12

[imf_2, residual_2] = emd(current_m,'SiftRelativeTolerance',0,'SiftMaxIterations',2);
[imf_3, residual_3] = emd(current_m,'SiftRelativeTolerance',0,'SiftMaxIterations',3);
[imf_4, residual_4] = emd(current_m,'SiftRelativeTolerance',0,'SiftMaxIterations',4);
[imf_5, residual_5] = emd(current_m,'SiftRelativeTolerance',0,'SiftMaxIterations',5);
[imf_6, residual_6] = emd(current_m,'SiftRelativeTolerance',0,'SiftMaxIterations',6);

for i=1:240
    current_t_std(i,1) = std([residual_5(i),residual_6(i),residual_2(i),residual_3(i),...
        residual_4(i)]);
    current_t_m(i,1) = nanmean([residual_5(i),residual_6(i),residual_2(i),residual_3(i),...
        residual_4(i)]);
end

Tt_current_dt_m = current_t_m - detrend(current_t_m);
Tt_current_yr = (Tt_current_dt_m(end) - Tt_current_dt_m(1))/240*12



%%
figure(1)

set(gcf,'pos',[2650 200 770 500])
set(gcf,'color',[1 1 1])

s1=subplot(2,1,1)

hold on
f1 = fill([time';flipud(time')],[wind_t_m+2*wind_t_std;flipud(wind_t_m-2*wind_t_std)],[.7 .7 .7])
set(f1,'EdgeColor','none','FaceAlpha',0.5)
l1 = plot(time,wind_m,'color',[2 38 62]/256,'linewidth',1.3)
l2 = plot(time,wind_t_m,'color',[233 0 45]/256,'linewidth',1.2);

B=datestr(time(6+12:48:end),'yyyy');
set(gca, 'Box', 'off','layer','top','color','none','linewidth',1.1,'XGrid','off','YGrid','off', ...                   
         'TickDir','out','TickLength',[.006 .006],'XMinorTick','off','YMinorTick','off', ...     
         'XColor',[.1 .1 .1],'xlim',[time(1) time(end)],'ylim',[-8 2],...
         'Xtick',time(6+12:48:end),'xticklabel',B,'Ytick',-8:5:2,'yticklabel',-8:5:2);
ylabel({'Wind speed';'[m/s]'},'FontName','Arial','fontsize',12,'fontweight','normal')
title('(a)','FontName','Arial','fontsize',13,'fontweight','bold','position',[time(1)+265 0.85*10-8])
t2 = text(time(120),-6.75,[sprintf('%5.2f',Tt_wind_yr*240/12),' m/s, {\itP} < 0.05'],...
    'color','r','FontName','Arial','fontsize',15,'fontweight','normal');
set(gca,'FontName','Arial','fontsize',12,'fontweight','normal')
set(s1,'pos',[0.13 0.572 0.81 0.388])

s2=subplot(2,1,2)

hold on
f1 = fill([time';flipud(time')],[current_t_m+2*current_t_std;flipud(current_t_m-2*current_t_std)],[.7 .7 .7])
set(f1,'EdgeColor','none','FaceAlpha',0.5)
l1 = plot(time,current_m,'color',[2 38 62]/256,'linewidth',1.3)
l2 = plot(time,current_t_m,'color',[233 0 45]/256,'linewidth',1.2);
set(gca, 'Box', 'off','layer','top','color','none','linewidth',1.1,'XGrid','off','YGrid','off', ...                   
         'TickDir','out','TickLength',[.006 .006],'XMinorTick','off','YMinorTick','off', ...          
         'XColor',[.1 .1 .1],'xlim',[time(1) time(end)],'ylim',[-0.8 0.4],...
         'Xtick',time(6+12:48:end),'xticklabel',B,'Ytick',-0.8:0.6:0.4,'yticklabel',-0.8:0.6:0.4);
ylabel({'Zonal SEC';'[m/s]'},'FontName','Arial','fontsize',12,'fontweight','normal')
xlabel('Year','FontName','Arial','fontsize',12,'fontweight','normal')
title('(b)','FontName','Arial','fontsize',13,'fontweight','bold','position',[time(1)+265 0.85*1.2-0.8])
t4 = text(time(120),-0.65,[sprintf('%6.2f',Tt_current_yr*240/12),' m/s, {\itP} < 0.05'],...
    'color','r','FontName','Arial','fontsize',15,'fontweight','normal');
set(gca,'FontName','Arial','fontsize',12,'fontweight','normal')
set(s2,'pos',[0.13 0.11 0.81 0.388])

