
% 
% month={result{2:end,2}};
% RT={result{2:end,7}};
% accuracy={result{2:end,6}};
% 
% month=cell2mat(month);
% RT=cell2mat(RT);
% accuracy=cell2mat(accuracy);
% 
% RT(24)=[];
% month(24)=[];
% accuracy(24)=[];

% young= (month<60);
% old= (month>72 & month<84); 
% adult= (month>100);
%AgeRT=[mean(RT(young)), mean(RT(old)), mean(RT(adult))];
% AgeAccuracy=[mean(accuracy(young))*100, mean(accuracy(old))*100, mean(accuracy(adult))*100];

RT=[988 1143; 1266 1268];
sd=[35 40; 35 43];

x=[1,2;1,2];
condition={'Mod. Rep.', 'Mod. Shift'};

h=figure(2);
box on
color_ref='rbrb';

hold on
for i=1:2
g=terrorbar(x(i,:), RT(i,:), sd(i,:), 0.1, 'centi');
set(g,'LineWidth',2, 'color', color_ref(i))
terrorbar(g,.7,'centi');
hold on
j(i)=plot(x(i,:), RT(i,:), '.-', 'color', color_ref(i), 'markersize', 40);
end

legend_name= {'Visual Target','Auditory Target'};
leg=legend(j, legend_name, 'Location', 'NorthEast');
legend BOXOFF

set(gca,'XTick',1:2,'XTickLabel',condition);
set(h, 'Position', [100 100 600 900]);
set(gcf, 'Color', 'w');
set(gca,'FontSize',25);
%ylim([80 100]);
set(gca, 'YTick',500:200:1900, 'YLim',[500 1900])
xlabh=xlabel({'Trial Types in Mixed Condition'}, 'FontSize',25);
ylabh=ylabel({'RT(ms) to Targets'}, 'FontSize',25);

set(xlabh,'Position',get(xlabh,'Position') - [0 30 0]);


%set(ylabh,'Position',get(ylabh,'Position') - [0.1 0 0])

%plot(0:4, [60, 60, 60], 'g-'); % chance level