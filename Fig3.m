
%Figure. 3.
load('chl_boundary.mat');

[imf_2, residual_2] = emd(bd_n,'SiftRelativeTolerance',0,'SiftMaxIterations',2);
[imf_3, residual_3] = emd(bd_n,'SiftRelativeTolerance',0,'SiftMaxIterations',3);
[imf_4, residual_4] = emd(bd_n,'SiftRelativeTolerance',0,'SiftMaxIterations',4);
[imf_5, residual_5] = emd(bd_n,'SiftRelativeTolerance',0,'SiftMaxIterations',5);
[imf_6, residual_6] = emd(bd_n,'SiftRelativeTolerance',0,'SiftMaxIterations',6);
Tt_n(:,1) = residual_2;
Tt_n(:,2) = residual_3;
Tt_n(:,3) = residual_4;
Tt_n(:,4) = residual_5;
Tt_n(:,5) = residual_6;
for i=1:240
    Tt_n_m(i) = nanmean(Tt_n(i,:));
    Tt_n_std(i) = std(Tt_n(i,:));
end

[imf_2, residual_2] = emd(bd_s,'SiftRelativeTolerance',0,'SiftMaxIterations',2);
[imf_3, residual_3] = emd(bd_s,'SiftRelativeTolerance',0,'SiftMaxIterations',3);
[imf_4, residual_4] = emd(bd_s,'SiftRelativeTolerance',0,'SiftMaxIterations',4);
[imf_5, residual_5] = emd(bd_s,'SiftRelativeTolerance',0,'SiftMaxIterations',5);
[imf_6, residual_6] = emd(bd_s,'SiftRelativeTolerance',0,'SiftMaxIterations',6);
Tt_s(:,1) = residual_2;
Tt_s(:,2) = residual_3;
Tt_s(:,3) = residual_4;
Tt_s(:,4) = residual_5;
Tt_s(:,5) = residual_6;
for i=1:240
    Tt_s_m(i) = nanmean(Tt_s(i,:));
    Tt_s_std(i) = std(Tt_s(i,:));
end

[imf_2, residual_2] = emd(bd_w,'SiftRelativeTolerance',0,'SiftMaxIterations',2);
[imf_3, residual_3] = emd(bd_w,'SiftRelativeTolerance',0,'SiftMaxIterations',3);
[imf_4, residual_4] = emd(bd_w,'SiftRelativeTolerance',0,'SiftMaxIterations',4);
[imf_5, residual_5] = emd(bd_w,'SiftRelativeTolerance',0,'SiftMaxIterations',5);
[imf_6, residual_6] = emd(bd_w,'SiftRelativeTolerance',0,'SiftMaxIterations',6);
Tt_w(:,1) = residual_2;
Tt_w(:,2) = residual_3;
Tt_w(:,3) = residual_4;
Tt_w(:,4) = residual_5;
Tt_w(:,5) = residual_6;
for i=1:237
    Tt_w_m(i) = nanmean(Tt_w(i,:));
    Tt_w_std(i) = std(Tt_w(i,:));
end
Tt_dt_n = Tt_n_m - detrend(Tt_n_m);
Tt_n_yr = (Tt_dt_n(end) - Tt_dt_n(1))/240*12

Tt_dt_s = Tt_s_m - detrend(Tt_s_m);
Tt_s_yr = (Tt_dt_s(end) - Tt_dt_s(1))/240*12

Tt_dt_w = Tt_w_m - detrend(Tt_w_m);
Tt_w_yr = (Tt_dt_w(end) - Tt_dt_w(1))/237*12

%%

figure(1)
set(gcf,'pos',[2650 200 750 680])
set(gcf,'color',[1 1 1])

s1 = subplot(3,1,1)
hold on
f3 = fill([time(1:237)';flipud(time(1:237)')],[Tt_w_m'+2*Tt_w_std';flipud(Tt_w_m'-2*Tt_w_std')],[.7 .7 .7])
l3 = plot(time(1:237),bd_w,'color',[2 38 62]/256,'linewidth',1.3)
k3 = plot(time(1:237),Tt_w_m,'color',[233 0 45]/256,'linewidth',1.2)
set(f3,'EdgeColor','none','FaceAlpha',0.5)
B=datestr(time(6+12:48:end),'yyyy');
set(gca, 'Box','off','layer','top','color','none','linewidth',1.1,'XGrid', 'off', 'YGrid', 'off', ... 
         'TickDir','out','TickLength',[.006 .006],'XMinorTick','off','YMinorTick', 'off', ...  
         'XColor', [.1 .1 .1],'xlim',[time(1) time(end)],'ylim',[140 220],...
         'Xtick',time(6+12:48:end),'xticklabel',B,'Ytick',140:40:220,'yticklabel',['140буE';'180бу ';'140буW']);
ylabel('Western boundary','FontName','Arial','fontsize',12,'fontweight','normal')
title('(a)','FontName','Arial','fontsize',13,'fontweight','bold','position',[time(1)+265 0.85*80+140])
t2 = text(time(52),200,[sprintf('%4.2f',Tt_w_yr),' бу/yr, {\itP} < 0.05'],...
    'color','r','FontName','Arial','fontsize',15,'fontweight','normal');
set(gca,'FontName','Arial','fontsize',12,'fontweight','normal')
set(gca,'pos',[0.12 0.705 0.77 0.26])

s2 = subplot(3,1,2)
hold on
f1 = fill([time';flipud(time')],[Tt_n_m'+2*Tt_n_std';flipud(Tt_n_m'-2*Tt_n_std')],[.7 .7 .7])
l1 = plot(time,bd_n,'color',[2 38 62]/256,'linewidth',1.3)
k1 = plot(time,Tt_n_m,'color',[233 0 45]/256,'linewidth',1.2)
set(f1,'EdgeColor','none','FaceAlpha',0.5)
set(gca, 'Box', 'off','layer','top','color','none','YAxisLocation','right','linewidth',1.1,...
         'XGrid','off', 'YGrid','off','TickDir','out','TickLength',[.006 .006], ... 
         'XMinorTick','off','YMinorTick','off','XColor',[.1 .1 .1],'xlim',[time(1) time(end)],...
         'ylim',[0 20],'Xtick',time(6+12:48:end),'xticklabel',B,'Ytick',0:10:20,'yticklabel',[' 0бу ';'10буN';'20буN']);
ylabel('Northern boundary','Rotation',90,'FontName','Arial',...
    'fontsize',12,'fontweight','normal','position',[time(end)+620 10])
title('(b)','FontName','Arial','fontsize',13,'fontweight','bold','position',[time(end)-400 0.85*20])
t4 = text(time(46),4,[sprintf('%5.3f',Tt_n_yr),' бу/yr, {\itP} < 0.05'],...
    'color','r','FontName','Arial','fontsize',15,'fontweight','normal');
set(gca,'FontName','Arial','fontsize',12,'fontweight','normal')
set(gca,'pos',[0.12 0.395 0.77 0.26])

s3 = subplot(3,1,3)
hold on
f2 = fill([time';flipud(time')],[Tt_s_m'+2*Tt_s_std';flipud(Tt_s_m'-2*Tt_s_std')],[.7 .7 .7])
l2 = plot(time,bd_s,'color',[2 38 62]/256,'linewidth',1.3)
k2 = plot(time,Tt_s_m,'color',[233 0 45]/256,'linewidth',1.2)
set(f2,'EdgeColor','none','FaceAlpha',0.5)
set(gca, 'Box', 'off','layer','top','color','none','linewidth',1.1,'XGrid','off','YGrid','off',...
         'TickDir','out','TickLength',[.006 .006],'XMinorTick','off','YMinorTick','off', ... 
         'XColor',[.1 .1 .1],'xlim',[time(1) time(end)],'ylim',[-20 0],...
         'Xtick',time(6+12:48:end),'xticklabel',B,'Ytick',-20:10:0,'yticklabel',['20буS';'10буS';' 0бу ']);
ylabel('Southern boundary','FontName','Arial','fontsize',12,'fontweight','normal')
xlabel('Year','FontName','Arial','fontsize',12,'fontweight','normal')
title('(c)','FontName','Arial','fontsize',13,'fontweight','bold','position',[time(1)+265 0.85*20-20])
t6 = text(time(46),-8.8,[sprintf('%5.3f',Tt_s_yr),' бу/yr, {\itP} < 0.05'],...
    'color','r','FontName','Arial','fontsize',15,'fontweight','normal');
set(gca,'FontName','Arial','fontsize',12,'fontweight','normal')
set(gca,'pos',[0.12 0.085 0.77 0.26])



