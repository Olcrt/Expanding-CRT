
%Figure. 6.
load('wind_stress.mat');
ruo_w = 1023;
omiga = 7.29e-5;
distance = 1e7;

et_n = nanmean(tao_x_n)./(-2*omiga*ruo_w*sind(5))*distance/1e6;
et_s = nanmean(tao_x_s)./(-2*omiga*ruo_w*sind(-5))*distance/1e6;
et_all = abs(et_n) + abs(et_s);

[imf_2, residual_2] = emd(et_n,'SiftRelativeTolerance',0,'SiftMaxIterations',2);
[imf_3, residual_3] = emd(et_n,'SiftRelativeTolerance',0,'SiftMaxIterations',3);
[imf_4, residual_4] = emd(et_n,'SiftRelativeTolerance',0,'SiftMaxIterations',4);
[imf_5, residual_5] = emd(et_n,'SiftRelativeTolerance',0,'SiftMaxIterations',5);
[imf_6, residual_6] = emd(et_n,'SiftRelativeTolerance',0,'SiftMaxIterations',6);

for i=1:240
    et_n_std(i,1) = std([residual_5(i),residual_6(i),residual_2(i),residual_3(i),...
        residual_4(i)]);
    et_n_m(i,1) = nanmean([residual_5(i),residual_6(i),residual_2(i),residual_3(i),...
        residual_4(i)]);
end

[imf_2, residual_2] = emd(et_s,'SiftRelativeTolerance',0,'SiftMaxIterations',2);
[imf_3, residual_3] = emd(et_s,'SiftRelativeTolerance',0,'SiftMaxIterations',3);
[imf_4, residual_4] = emd(et_s,'SiftRelativeTolerance',0,'SiftMaxIterations',4);
[imf_5, residual_5] = emd(et_s,'SiftRelativeTolerance',0,'SiftMaxIterations',5);
[imf_6, residual_6] = emd(et_s,'SiftRelativeTolerance',0,'SiftMaxIterations',6);

for i=1:240
    et_s_std(i,1) = std([residual_5(i),residual_6(i),residual_2(i),residual_3(i),...
        residual_4(i)]);
    et_s_m(i,1) = nanmean([residual_5(i),residual_6(i),residual_2(i),residual_3(i),...
        residual_4(i)]);
end

[imf_2, residual_2] = emd(et_all,'SiftRelativeTolerance',0,'SiftMaxIterations',2);
[imf_3, residual_3] = emd(et_all,'SiftRelativeTolerance',0,'SiftMaxIterations',3);
[imf_4, residual_4] = emd(et_all,'SiftRelativeTolerance',0,'SiftMaxIterations',4);
[imf_5, residual_5] = emd(et_all,'SiftRelativeTolerance',0,'SiftMaxIterations',5);
[imf_6, residual_6] = emd(et_all,'SiftRelativeTolerance',0,'SiftMaxIterations',6);

for i=1:240
    et_all_std(i,1) = std([residual_5(i),residual_6(i),residual_2(i),residual_3(i),...
        residual_4(i)]);
    et_all_m(i,1) = nanmean([residual_5(i),residual_6(i),residual_2(i),residual_3(i),...
        residual_4(i)]);
end

Tt_n_m = et_n_m - detrend(et_n_m);
Tt_n_yr = (Tt_n_m(end) - Tt_n_m(1))/240*12

Tt_s_m = et_s_m - detrend(et_s_m);
Tt_s_yr = (Tt_s_m(end) - Tt_s_m(1))/240*12

Tt_w_m = et_all_m - detrend(et_all_m);
Tt_w_yr = (Tt_w_m(end) - Tt_w_m(1))/240*12

%%
figure(1)
set(gcf,'pos',[2650 200 750 680])
set(gcf,'color',[1 1 1])

s1 = subplot(3,1,1)

hold on
f1 = fill([time';flipud(time')],[et_s_m+2*et_s_std;flipud(et_s_m-2*et_s_std)],[.7 .7 .7])
set(f1,'EdgeColor','none','FaceAlpha',0.5)
l1 = plot(time,et_s,'color',[2 38 62]/256,'linewidth',1.3)
l2 = plot(time,et_s_m,'color',[233 0 45]/256,'linewidth',1.2);

B=datestr(time(6+12:48:end),'yyyy');
set(gca, 'Box', 'off','layer','top','color','none','YAxisLocation','left','linewidth',1.1,...
         'XGrid','off','YGrid','off','TickDir','out','TickLength', [.006 .006], ...       
         'XMinorTick','off','YMinorTick','off','XColor',[.1 .1 .1],'xlim',[time(1) time(end)],...
         'ylim',[-100 0],'Xtick',time(6+12:48:end),'xticklabel',B,'Ytick',-100:50:0,'yticklabel',-100:50:0);
ylabel({'Southward Ekman transport';'[Sv]'},'FontName','Arial','fontsize',12,'fontweight','normal')
title('(a)','FontName','Arial','fontsize',13,'fontweight','bold','position',[time(1)+285 0.85*100-100])
set(gca,'FontName','Arial','fontsize',12,'fontweight','normal')
t4 = text(time(120),-80,[sprintf('%5.2f',Tt_s_yr*240/12),' Sv, {\itP} < 0.05'],...
    'color','r','FontName','Arial','fontsize',15,'fontweight','normal');
set(gca,'FontName','Arial','fontsize',12,'fontweight','normal')
set(gca,'pos',[0.12 0.702 0.77 0.258])

s2 = subplot(3,1,2)

hold on
f1 = fill([time';flipud(time')],[et_n_m+2*et_n_std;flipud(et_n_m-2*et_n_std)],[.7 .7 .7])
set(f1,'EdgeColor','none','FaceAlpha',0.5)
l1 = plot(time,et_n,'color',[2 38 62]/256,'linewidth',1.3)
l2 = plot(time,et_n_m,'color',[233 0 45]/256,'linewidth',1.2);

set(gca, 'Box', 'off','layer','top','color','none','YAxisLocation','right','linewidth',1.1,...
         'XGrid','off','YGrid','off','TickDir','out','TickLength',[.006 .006], ...       
         'XMinorTick','off','YMinorTick','off','XColor',[.1 .1 .1],'xlim',[time(1) time(end)],...
         'ylim',[0 100],'Xtick',time(6+12:48:end),'xticklabel',B,'Ytick',0:50:100,'yticklabel',0:50:100);
ylabel({'Northward Ekman transport';'[Sv]'},'Rotation',90,...
'FontName','Arial','fontsize',12,'fontweight','normal','position',[time(end)+430 50])
title('(b)','FontName','Arial','fontsize',13,'fontweight','bold','position',[time(end)-285 0.85*100])
t2 = text(time(120),85,[sprintf('%5.2f',Tt_n_yr*240/12),' Sv, {\itP} < 0.05'],...
    'color','r','FontName','Arial','fontsize',15,'fontweight','normal');
set(gca,'FontName','Arial','fontsize',12,'fontweight','normal')
set(gca,'pos',[0.12 0.394 0.77 0.258])

s3 = subplot(3,1,3)

hold on
f1 = fill([time';flipud(time')],[et_all_m+2*et_all_std;flipud(et_all_m-2*et_all_std)],[.7 .7 .7])
set(f1,'EdgeColor','none','FaceAlpha',0.5)
l1 = plot(time,et_all,'color',[2 38 62]/256,'linewidth',1.3)
l2 = plot(time,et_all_m,'color',[233 0 45]/256,'linewidth',1.2);

set(gca, 'Box', 'off','layer','top','color','none','linewidth', 1.1,'XGrid', 'off', 'YGrid', 'off', ...                
         'TickDir', 'out', 'TickLength', [.006 .006],'XMinorTick', 'off', 'YMinorTick', 'off', ...       
         'XColor', [.1 .1 .1],'xlim',[time(1) time(end)],'ylim',[0 150],...
         'Xtick',time(6+12:48:end),'xticklabel',B,'Ytick',0:75:150,'yticklabel',0:75:150);
ylabel({'Ekman divergence';'[Sv]'},'FontName','Arial','fontsize',12,'fontweight','normal')
xlabel('Year','FontName','Arial','fontsize',12,'fontweight','normal')
title('(c)','FontName','Arial','fontsize',13,'fontweight','bold','position',[time(1)+285 0.85*150])
t6 = text(time(120),120,[sprintf('%5.2f',Tt_w_yr*240/12),' Sv, {\itP} < 0.05'],...
    'color','r','FontName','Arial','fontsize',15,'fontweight','normal');
set(gca,'FontName','Arial','fontsize',12,'fontweight','normal')
set(gca,'pos',[0.12 0.086 0.77 0.258])


