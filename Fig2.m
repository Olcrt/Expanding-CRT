
%Figure. 2.
load('Scrt_MEI.mat');

C1 = [255, 128, 128]/256;
C2 = [128, 212, 255]/256;
MEI_p = MEI;MEI_p(MEI<0)=0;
MEI_n = MEI;MEI_n(MEI>0)=0;

[imf_2, residual_2] = emd(S_crt,'SiftRelativeTolerance',0,'SiftMaxIterations',2);
[imf_3, residual_3] = emd(S_crt,'SiftRelativeTolerance',0,'SiftMaxIterations',3);
[imf_4, residual_4] = emd(S_crt,'SiftRelativeTolerance',0,'SiftMaxIterations',4);
[imf_5, residual_5] = emd(S_crt,'SiftRelativeTolerance',0,'SiftMaxIterations',5);
[imf_6, residual_6] = emd(S_crt,'SiftRelativeTolerance',0,'SiftMaxIterations',6);

St(:,1) = imf_2(:,1) + imf_2(:,2);
St(:,2) = imf_3(:,1) + imf_3(:,2);
St(:,3) = imf_4(:,1) + imf_4(:,2);
St(:,4) = imf_5(:,1) + imf_5(:,2);
St(:,5) = imf_6(:,1) + imf_6(:,2);

It(:,1) = imf_2(:,3) + imf_2(:,4) + imf_2(:,5) + imf_2(:,6);
It(:,2) = imf_3(:,3) + imf_3(:,4) + imf_3(:,5);
It(:,3) = imf_4(:,3) + imf_4(:,4) + imf_4(:,5);
It(:,4) = imf_5(:,3) + imf_5(:,4) + imf_5(:,5);
It(:,5) = imf_6(:,3) + imf_6(:,4) + imf_6(:,5) + imf_6(:,6);

Tt(:,1) = residual_2;
Tt(:,2) = residual_3;
Tt(:,3) = residual_4;
Tt(:,4) = residual_5;
Tt(:,5) = residual_6;

for i=1:240
    St_m(i) = nanmean(St(i,:));
    It_m(i) = nanmean(It(i,:));
    Tt_m(i) = nanmean(Tt(i,:));
    St_std(i) = std(St(i,:));
    It_std(i) = std(It(i,:));
    Tt_std(i) = std(Tt(i,:));
end
p = polyfit(time,S_crt,1);
Lxx = sum((time - mean(time)).^2);
y_hat = p(1)*time + p(2);
RSS = sum((S_crt - y_hat).^2);
S = sqrt(RSS/(240-2));
SEB = S/sqrt(Lxx);
t_stat = p(1)/SEB;
p_value = 2 * (1-tcdf(abs(t_stat),240-2));

[p,s] = polyfit(time,S_crt,1);
[y_fit,delta] = polyval(p,time,s);

Tt_dt = Tt_m - detrend(Tt_m);
Tt_yr = (Tt_dt(end) - Tt_dt(1))/240*12

[~,month,~] = datevec(time);

for i =1:12
    loc = find(month==i);
    cS(i) = mean(St_m(loc));
    cS_std(i) = std(St_m(loc));
end
%%
figure(1)
set(gcf,'pos',[2650 200 750 800])
set(gcf,'color',[1 1 1])

s1=subplot(4,1,1)
hold on
l1 = plot(time,S_crt,'color',[2 38 62]/256,'linewidth',1.3)
plot(time,y_fit,'color','r','linewidth',1.3)
B=datestr(time(6+12:48:end),'yyyy');
D = [' 0   ';'  2  ';' 4   '];
set(gca, 'Box', 'off','layer','top','color','none','linewidth',1.1,'XGrid','off','YGrid','off',...
         'TickDir', 'out', 'TickLength', [.006 .006],'XMinorTick', 'off', 'YMinorTick', 'off', ...             % Ð¡¿Ì¶È
         'XColor', [.1 .1 .1],'xlim',[time(1) time(end)],'ylim',[0 4e7],'Xtick',time(6+12:48:end),...
         'xticklabel',B,'Ytick',0:2e7:4e7,'yticklabel',D);
ylabel({'CRT area (original data)';'[10^7 km^2]'},'FontName','Arial',...
    'fontsize',11,'fontweight','normal','position',[time(1)-500 2e7])
title('(a)','FontName','Arial','fontsize',13,'fontweight','bold','position',[time(1)+265 0.85*4e+07])
t1 = text(time(45),1.3e7,['-2.25 ¡Á 10^4 km^2/yr, {\itP} = ',sprintf('%4.2f',p_value)],'color','r',...
    'FontName','Arial','fontsize',15,'fontweight','normal');
set(gca,'FontName','Arial','fontsize',12,'fontweight','normal')
set(gca,'pos',[0.12 0.77 0.75 0.19])

s2=subplot(4,1,2)
hold on
f2 = fill([time;flipud(time)],[St_m'+2*St_std';flipud(St_m'-2*St_std')],[.7 .7 .7])
l2 = plot(time,St_m,'color',[2 38 62]/256,'linewidth',1.3)
set(f2,'EdgeColor','none','FaceAlpha',0.5)
set(gca, 'Box', 'off','layer','top','color','none','YAxisLocation','right','linewidth', 1.1,...
         'XGrid','off','YGrid','off','TickDir','out','TickLength',[.006 .006],'XMinorTick','off',...
         'YMinorTick','off','XColor',[.1 .1 .1],'xlim',[time(1) time(end)],'ylim',[-14e6 14e6],...
         'Xtick',time(6+12:48:end),'xticklabel',B,'Ytick',-1.4e7:1.4e7:1.4e7,'yticklabel',-1.4:1.4:1.4);
ylabel({'Seasonal component';'[10^7 km^2]'},'Rotation',90,'FontName','Arial',...
    'fontsize',11,'fontweight','normal','position',[time(end)+500 4]);
set(gca,'FontName','Arial','fontsize',12,'fontweight','normal')
title('(b)','FontName','Arial','fontsize',13,'fontweight','bold','position',[time(end)-295 0.85*2.8e7-1.4e7])
set(gca,'FontName','Arial','fontsize',12,'fontweight','normal')
set(gca,'pos',[0.12 0.54 0.75 0.19])

s3=subplot(4,1,3)
hold on
yyaxis right
area(time,MEI_p,'LineWidth',1,'FaceColor',C1,'EdgeColor','none','FaceAlpha',.8,'EdgeAlpha',1,'ShowBaseLine','off');
hold on
area(time,MEI_n,'LineWidth',1,'FaceColor',C2,'EdgeColor','none','FaceAlpha',.8,'EdgeAlpha',1,'ShowBaseLine','off');
set(gca, 'Box','off','color','none','linewidth',1.1,'XGrid','off','YGrid','off', ... 
         'TickDir','out','TickLength',[.006 .006],'XMinorTick','off','YMinorTick', 'off', ...  
         'XColor',[.1 .1 .1],'YColor',[.1 .1 .1],'xlim',[time(1) time(end)],'ylim',[-3 3],...
         'Xtick',time(18:48:end),'xticklabel',[],'Ytick',-3:3:3,'yticklabel',-3:3:3);      
ylabel('MEI','Rotation',90,'FontName','Arial','fontsize',11,...
    'fontweight','normal','color','k','position',[time(end)+500 0])

yyaxis left
f3 = fill([time;flipud(time)],[It_m'+2*It_std';flipud(It_m'-2*It_std')],[.7 .7 .7])
l3 = plot(time,It_m,'color',[2 38 62]/256,'linestyle','-','linewidth',1.3)
set(f3,'EdgeColor','none','FaceAlpha',0.5)
set(gca, 'Box', 'off','layer','top','color','none','linewidth',1.1,'XGrid','off','YGrid','off', ...
         'TickDir','out','TickLength',[.006 .006],'XMinorTick','off','YMinorTick','off', ...
         'XColor', [.1 .1 .1],'YColor', [.1 .1 .1],'xlim',[time(1) time(end)],'ylim',[-14e6 14e6],...
         'Xtick',time(6+12:48:end),'xticklabel',B,'Ytick',-1.4e7:1.4e7:1.4e7,'yticklabel',-1.4:1.4:1.4);
y1 = ylabel({'Interannual component';'[10^7 km^2]'},'FontName','Arial',...
    'fontsize',11,'fontweight','normal','color','k','position',[time(1)-500 11.444])
set(gca,'FontName','Arial','fontsize',12,'fontweight','normal')
title('(c)','FontName','Arial','fontsize',13,'fontweight','bold','position',[time(1)+265 0.85*2.8e7-1.4e7])
set(gca,'FontName','Arial','fontsize',12,'fontweight','normal')
set(gca,'pos',[0.12 0.31 0.75 0.19])

s4=subplot(4,1,4)
hold on
f4 = fill([time;flipud(time)],[Tt_m'+2*Tt_std';flipud(Tt_m'-2*Tt_std')],[.7 .7 .7])
l4 = plot(time,Tt_m,'color',[2 38 62]/256,'linewidth',1.3)
set(f4,'EdgeColor','none','FaceAlpha',0.5)
set(gca, 'Box', 'off','layer','top','color','none','YAxisLocation','right','linewidth',1.1,...
         'XGrid','off','YGrid','off','TickDir','out','TickLength',[.006 .006],...
         'XMinorTick','off','YMinorTick','off','XColor',[.1 .1 .1],'xlim',[time(1) time(end)],...
         'ylim',[2e7 3e7],'Xtick',time(6+12:48:end),'xticklabel',B,'Ytick',2e7:5e6:3e7,'yticklabel',2:0.5:3);
y1=ylabel({'Residual component';'[10^7 km^2]'},'Rotation',90,'FontName','Arial',...
    'fontsize',11,'fontweight','normal','position',[time(end)+500 2.5e7])
xlabel('Year','FontName','Arial','fontsize',12,'fontweight','normal')
title('(d)','FontName','Arial','fontsize',13,'fontweight','bold','position',[time(end)-295 0.85*1e7+2e7])
t2 = text(time(30),2.7e7,['1.87(¡À0.82) ¡Á 10^5 km^2/yr, {\itP} < 0.05'],'color','r',...
    'FontName','Arial','fontsize',15,'fontweight','normal');
set(gca,'FontName','Arial','fontsize',12,'fontweight','normal')
set(gca,'pos',[0.12 0.08 0.75 0.19])

ax5 = axes('pos',[0.5 0.535 0.33 0.095],'XAxisLocation','bottom','YAxisLocation','left',...
    'Color','none','XColor','k','YColor','k');
set(ax5,'pos',[0.5 0.535 0.33 0.095])
set(ax5,'XTick', [],'YTick', [],'linewidth', 1.1,'layer','top');  
hold on
E1 = errorbar(1:12,cS,cS_std);
set(E1,  'LineStyle', '-', 'Color', 'k','LineWidth', 1.1, 'Marker', 'o', 'MarkerSize', 3, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , 'k')
BB = datestr(time(6:17),'mmm');
D = [' 1   ';'  2  ';' 3   '];
set(gca, 'Box', 'off','layer','top','color','none','linewidth',1,'XGrid','off','YGrid','off', ... 
         'TickDir','out','TickLength',[.006 .006],'XMinorTick','off','YMinorTick','off', ... 
         'XColor', [.1 .1 .1],'xlim',[-1.5 14.5],'ylim',[-6e6 6e6],'Xtick',1:12,'xticklabel',[],...
         'Ytick',-4e6:4e6:4e6,'yticklabel',[]);
text(-0.4,-1.5e6,'Jan','FontName','Arial','fontsize',14,'fontweight','normal')
text(11.6,-3.5e6,'Dec','FontName','Arial','fontsize',14,'fontweight','normal')
line([-0.6 14 14 -0.6 -0.6],[-4.9e6 -4.9e6 3.9e6 3.9e6 -4.9e6],'color','k','linewidth',1)
set(ax5,'XColor','none')
set(ax5,'Ycolor','none')



