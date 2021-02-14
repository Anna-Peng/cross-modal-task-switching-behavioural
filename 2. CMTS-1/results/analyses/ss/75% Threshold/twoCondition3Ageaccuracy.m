

RT_ref=[85.9, 85.1; 91.9, 91.4; 97.8, 97.7;... % TS switch cost
87.6, 83.5; 95.7, 88.2; 98.5, 96.9;...% CMTS switch cost
91.5, 85.9; 96, 91.9; 98.4, 97.8;... % TS mix cost
85.6, 87.6; 96, 95.7; 98.2, 98.5]; % CMTS mix cost

se=[2.1, 2.1; 1.57, 1.57; 0.91, 0.91;...
1.56, 1.56; 1.33, 1.33; 0.89, 0.89;...
1.68, 1.68; 1.26, 1.26; 0.42, 0.42;...
2.19, 2.19; 0.77, 0.77; 0.67, 0.67];



h=figure(2);
box on


color_ref='rbgrbgrbgrbgrbg';
xvalue=[repmat([1,2], 3,1); repmat([3,4], 3,1); repmat([5,6], 3,1);repmat([7,8], 3,1)];

for i=1:size(xvalue,1)

g=terrorbar(xvalue(i,:), RT_ref(i,:), se(i,:), 0.1, 'centi');
set(g,'LineWidth',2, 'color', color_ref(i));
terrorbar(g,.7,'centi');
hold on

j(i)=plot(xvalue(i,:), RT_ref(i,:), '.-', 'color', color_ref(i), 'markersize', 30);
hold on
end

legend_name= {'4-Year-Old', '6-Year-Old', 'Adult'};
leg=legend(j, legend_name, 'Location', 'NorthEastoutside');
legend BOXOFF

xname={'Rep.', 'Swi.', 'Rep.', 'Swi.', 'Pure', 'Mix', 'Pure', 'Mix'};
set(gca,'XTick',1:8,'XTickLabel',xname);
set(h, 'Position', [100 100 2000 700]);
set(gcf, 'Color', 'w');
set(gca,'FontSize',25);
xlim([0.5,8.5]);


%ylim([80 100]);
set(gca, 'YTick',50:10:100, 'YLim',[50 110])

hold on
y1=get(gca,'ylim');
plot([2.5, 2.5],y1, 'k-', [4.5 4.5], y1, 'k-', [6.5 6.5], y1, 'k-');
xlabh=xlabel({'TS Switch Cost                    CMTS Switch Cost                   TS Mix Cost                    CMTS Mix Cost'}, 'FontSize',30);
ylabh=ylabel({'Accuracy %'}, 'FontSize',30);
set(xlabh,'Position',get(xlabh,'Position') - [0 0 0]);
