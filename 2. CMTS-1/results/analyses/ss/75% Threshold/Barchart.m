clear

meanRT=[79.4, 247.4; 111.8, 214.2; -3.8, 96.6];
sd=[177.9, 177.9; 100.5, 100.5; 71.6, 74.3];
x=[1, 3, 5; 1.5 3.5 5.5];
colorindex=[1, .3 .3; .3 .5 1];
h=figure(1);
box on

for i=1:2
b(i)=bar(x(i,:), meanRT(:,i),.2);
b(i).FaceColor=colorindex(i,:);
hold on
% errorbar(x(i,:), meanRT(:,i), sd(:,i), 'k.');

g=terrorbar(x(i,:),meanRT(:,i), sd(:,i), 0.1, 'centi');
set(g,'LineWidth',2, 'color', [0 0 0]);
terrorbar(g,.7,'centi');
hold on
end
legend_name= {'Vis Target: A2V-V2V', 'Aud Target: V2A-A2A'};
leg=legend(b, legend_name, 'Location', 'NorthEast');


ylim([-200 500]);
condition={'4-year-old','6-year-old', 'adult'};
set(gca,'XTick',[1.25,3.25,5.25] ,'XTickLabel',condition);
set(h, 'Position', [100 100 1800 900]);
set(gcf, 'Color', 'w');
set(gca,'FontSize',26);

xlabh=xlabel({'Modality Shift Costs in Pure Condition'}, 'FontSize',30);
ylabh=ylabel({'Latency Cost in milliseconds'}, 'FontSize',30);

set(xlabh,'Position',get(xlabh,'Position') - [0 30 0]);