
%Figure. 4.

load('E:\进展\文章相关\EEP_HCT\nc_reviewer\final\code\Scrt_overlap.mat');

[imf_2, residual_2] = emd(S_crt,'SiftRelativeTolerance',0,'SiftMaxIterations',2);
[imf_3, residual_3] = emd(S_crt,'SiftRelativeTolerance',0,'SiftMaxIterations',3);
[imf_4, residual_4] = emd(S_crt,'SiftRelativeTolerance',0,'SiftMaxIterations',4);
[imf_5, residual_5] = emd(S_crt,'SiftRelativeTolerance',0,'SiftMaxIterations',5);
[imf_6, residual_6] = emd(S_crt,'SiftRelativeTolerance',0,'SiftMaxIterations',6);

It(:,1) = imf_2(:,3) + imf_2(:,4) + imf_2(:,5) + imf_2(:,6);
It(:,2) = imf_3(:,3) + imf_3(:,4) + imf_3(:,5);
It(:,3) = imf_4(:,3) + imf_4(:,4) + imf_4(:,5);
It(:,4) = imf_5(:,3) + imf_5(:,4) + imf_5(:,5);
It(:,5) = imf_6(:,3) + imf_6(:,4) + imf_6(:,5) + imf_6(:,6);
for i=1:240
    It_m(i) = nanmean(It(i,:));
    It_std(i) = std(It(i,:));
end
S_unit = S_crt - It_m';
for i=1:12
    S_first(i) = mean(S_unit(i:12:48+i));
    S_end(i) = mean(S_unit(180+i:12:228+i));
end
S_first = [S_first(6:12),S_first(1:5)];
S_end = [S_end(6:12),S_end(1:5)];

colortable = jet(21);
C1 = [255, 128, 128]/256;
C2 = [128, 212, 255]/256;
C3 = [123, 202, 161]/256;
colortable_2 = [C2;C3;C1];

%%

figure(1)

set(gcf,'pos',[2650 250 750 680])
set(gcf,'color',[1 1 1])

s1 = subplot(2,1,1)

hold on
plot(8:12,S_unit(1:5),'color',colortable(1,:),'linestyle','-','linewidth',1.15);
for i=1:19
    plot(1:12,S_unit(6+(i-1)*12:17+(i-1)*12),'color',colortable(i+1,:),'linestyle','-','linewidth',1.15);
end
plot(1:7,S_unit(234:240),'color',colortable(21,:),'linestyle','-','linewidth',1.15);

B = datestr(time(6:17),'mmm');
D = [' 1   ';'  2  ';' 3   '];
set(gca, 'Box', 'off','layer','top','color','none','linewidth',1.1,'XGrid','off','YGrid','off', ...
         'TickDir','out','TickLength',[.006 .006],'XMinorTick','off','YMinorTick','off', ...    
         'XColor', [.1 .1 .1],'xlim',[1 12],'ylim',[1.5e7 3.5e7],'Xtick',1:12,'xticklabel',B,...
         'Ytick',1e7:1e7:3e7,'yticklabel',1:1:3);
ylabel({'CRT area';'[10^7 km^2]'},'FontName','Arial','fontsize',12,'fontweight','normal')
xlabel('Date','FontName','Arial','fontsize',12,'fontweight','normal')
title('(a)','FontName','Arial','fontsize',13,'fontweight','bold','position',[1.225 3.57e+07])
set(gca,'FontName','Arial','fontsize',12,'fontweight','normal')
set(s1,'pos',[0.11 0.6 0.85 0.34])

h1=colorbar;
colormap(colortable)
caxis([0 1]) 
E=datestr(time(1:239:end),'yyyy');
set(h1,'Ticks',[1/42:20/21:1-1/42],'TickLabels',E,'fontsize',13)
set(h1,'location','south','AxisLocation','out')
set(h1,'position',[0.16 0.65 0.5 0.0176])
set(h1,'Box','on','linewidth',1.1,'TickDir', 'in', 'TickLength', [.008])
set(gca,'FontName','Arial','fontsize',12,'fontweight','normal')

s2 = subplot(2,1,2)

hold on
[c1,h1]=contourf(lon_chl,lat_chl,chl_2002',1,'linestyle','none');
[c2,h2]=contourf(lon_chl,lat_chl,chl_both',1,'linestyle','none');
[c3,h3]=contourf(lon_chl,lat_chl,chl_2022',1,'linestyle','none');

h2=colorbar;
colormap(colortable_2)
caxis([0 2]) 
axis equal
xlim([130 290]);ylim([-30 30]);
B_lon=['     ';'150°E';'180° ';'150°W';'120°W';' 90°W';'     '];
set(gca,'Xtick',[130,150:30:270,290],'xticklabel',B_lon,'fontsize',11,'fontweight','bold');
D=['    ';'20°S';' 0° ';'20°N';'    '];
set(gca,'Ytick',[-30,-20,0,20,30],'Yticklabel',D,'fontsize',11,'fontweight','bold');
set(gca,'layer','top', 'Box', 'off','linewidth', 1.2,'TickDir', 'out', 'TickLength', [.01 .01])
grid off

set(s2,'pos',[0.11 0.11 0.85 0.4333])
set(h2,'location','southoutside','Ticks',[0:2/3:2],'TickLabels',[],'position',[0.11 0.075 0.85 0.02],...
    'Box','on','linewidth',1.1,'TickDir', 'out', 'TickLength', [.008 .008]);
title('(b)','FontName','Arial','fontsize',13,'fontweight','bold','position',[133 1.03*60-30])
set(gca,'FontName','Arial','fontsize',12,'fontweight','normal')

ax = axes('Position',[0.11 0.03 0.85 0.02],'XAxisLocation','bottom','YAxisLocation','left');
set(ax,'color','none')
text(0.07,0.5,'2003-2007 Only','FontName','Arial','fontsize',13,'fontweight','normal')
text(0.34,0.5,{'          overlapping of    ';'2003-2007 and 2018-2022'},'FontName','Arial','fontsize',13,'fontweight','normal')
text(0.74,0.5,'2018-2022 Only','FontName','Arial','fontsize',13,'fontweight','normal')

set(ax,'XTick', [],'YTick', [],'box','off');
set(ax,'XColor','none','YColor','none');

set(s1,'colormap',colortable);

ax2 = axes('Position',[0.6 0.8 0.33 0.13],'XAxisLocation','bottom','YAxisLocation','left',...
    'Color','none','XColor','k','YColor','k');

hold on
l_f = plot(1:12,S_first,'color',[2 38 62]/256,'linestyle','--','linewidth',1.15);
l_e = plot(1:12,S_end,'color',[2 38 62]/256,'linestyle','-','linewidth',1.15);

BB = datestr(time(6:17),'mmm');
BB_num = [2,3,5,6,8,9,11,12];
for i = 1:8;
    BB(BB_num(i),:) = '   ';
end
D = [' 1   ';'  2  ';' 3   '];
set(gca, 'Box', 'on','layer','top','color','none','linewidth',1,'XGrid','off','YGrid','off', ...  
         'TickDir','out','TickLength',[.006 .006],'XMinorTick','off','YMinorTick','off', ...    
         'XColor',[.1 .1 .1],'xlim',[1 12],'ylim',[1.8e7 3e7],'Xtick',1:12,'xticklabel',BB,...
         'Ytick',2e7:1e7:3e7,'yticklabel',2:1:3);
ylabel({'CRT area';'[10^7 km^2]'},'FontName','Arial','fontsize',11,'fontweight','normal')
set(gca,'FontName','Arial','fontsize',10,'fontweight','normal')
LG1 = legend([l_f,l_e],'average over 2003-2007','average over 2018-2022');
set(LG1,'FontName','Arial','fontsize',10,'fontweight','normal','box','off')
set(LG1,'pos',[0.6687 0.88 0.2627 0.0537])


