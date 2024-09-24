
%Figure. 1.

load('chl_uv_cm.mat');

M = contour(lon_chl,lat_chl,chl',[0.1 0.1],'color','k','linewidth',1.2);
line_c = M(:,232:518);

%%

figure(1)

set(gcf,'pos',[2650 200 700 570])
set(gcf,'color',[1 1 1])

s1 = subplot(2,1,1)

hold on
[c,h]=contourf(lon_chl,lat_chl,chl',500,'linestyle','none');
plot(line_c(1,:),line_c(2,:),'color','k','linewidth',1.2);

h1=colorbar;
axis equal
xlim([130 290]);ylim([-30 30]);
B=['     ';'150буE';'180бу ';'150буW';'120буW';' 90буW';'     '];
set(gca,'Xtick',[130,150:30:270,290],'xticklabel',B,'fontsize',11,'fontweight','bold');
D=['    ';'20буS';' 0бу ';'20буN';'    '];
set(gca,'Ytick',[-30,-20,0,20,30],'Yticklabel',D,'fontsize',11,'fontweight','bold');
set(gca,'layer','top', 'Box', 'off','linewidth', 1.2,'TickDir', 'out', 'TickLength', [.01 .01])
grid off
set(gca,'pos',[0.04 0.57 0.88 0.36])

caxis([0 1]) 
set(h1,'Ticks',[0:0.2:1],'TickLabels',[0:0.2:1],'linewidth',1.1)
set(get(h1,'title'),'Rotation',90,'string','Chl [mg/m^3]','fontsize',13,'position',[42 80]);
set(h1,'position',[0.9 0.57 0.0125 0.36])
set(gca,'FontName','Arial','fontsize',12,'fontweight','normal')
t1=title('(a)','FontName','Arial','fontsize',13,'fontweight','bold','position',[133 1.03*60-30])

s2 = subplot(2,1,2)

hold on
Q=quiver(lon_uv(1:4:end,1:4:end),lat_uv(1:4:end,1:4:end),u(1:4:end,1:4:end),v(1:4:end,1:4:end),11);
Q.MaxHeadSize = 0.01;
Q.AutoScale = 'on';
Q.AutoScaleFactor = 3;
axis equal
xlim([130 290]);ylim([-30 30]);
plot(line_c(1,:),line_c(2,:),'color','k','linewidth',1.2);

set(gca,'Xtick',[130,150:30:270,290],'xticklabel',B,'fontsize',11,'fontweight','bold');
set(gca,'Ytick',[-30,-20,0,20,30],'Yticklabel',D,'fontsize',11,'fontweight','bold');
set(gca,'layer','top', 'Box', 'off','linewidth', 1.2,'TickDir', 'out', 'TickLength', [.01 .01])
grid off
set(gca,'pos',[0.04 0.09 0.88 0.36])

t2=title('(b)','FontName','Arial','fontsize',13,'fontweight','bold','position',[133 1.03*60-30])
line([170,260,260,170,170],[-5,-5,5,5,-5],'color',[249,41,42]/256,'linewidth',1.2,'linestyle','--')
set(gca,'FontName','Arial','fontsize',12,'fontweight','normal')

ax = axes('Position',[0.57 0.48 0.35 0.05],'XAxisLocation','bottom','YAxisLocation','left',...
    'Color','none','XColor','none','YColor','none');
set(ax,'pos',[0.57 0.48 0.35 0.05]);

Qc=quiver(30,4,0.5,0,11,'filled');
xlim([0 160/0.83*0.312]);ylim([0 60/0.258*0.05]);
Qc.LineWidth = 1.2;
Qc.MaxHeadSize = 1;
Qc.AutoScale = 'on';
Qc.AutoScaleFactor = 11;
text(38,4,'0.3 m/s','FontName','Arial','fontsize',13,'fontweight','normal')
text(14,4,'current','FontName','Arial','fontsize',13,'fontweight','normal')
set(ax,'XTick', [],'YTick', []); 
set(ax,'box','off');
set(ax,'Xcolor','none')
set(ax,'Ycolor','none')
set(ax,'color','none')








