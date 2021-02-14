% 
% month={result{2:end,2}};
% T1={result{2:end,51}};
% T2={result{2:end,53}};
% T3={result{2:end,55}};
% T4={result{2:end,57}};
% accuracy={result{2:end,6}};
% % 
% month=cell2mat(month);
% T1=cell2mat(T1);
% T2=cell2mat(T2);
% T3=cell2mat(T3);
% T4=cell2mat(T4);
% accuracy=cell2mat(accuracy);
% 
% exclude=accuracy<.75;
% T1(exclude)=[];
% T2(exclude)=[];
% T3(exclude)=[];
% T4(exclude)=[];
% month(exclude)=[];
% 
% 
% young= (month<60);
% old= (month>71 & month<84); 
% adult= (month>100);
% RT_ref=[mean(T1(young)), mean(T2(young)), mean(T3(young)), mean(T4(young));...
%     mean(T1(old)), mean(T2(old)), mean(T3(old)), mean(T4(old));...
%     mean(T1(adult)), mean(T2(adult)), mean(T3(adult)), mean(T4(adult))];
% AgeAccuracy=[mean(accuracy(young))*100, mean(accuracy(old))*100, mean(accuracy(adult))*100];

RT_ref=[1516, 1742; 1231, 1396; 745, 780;... % TS switch cost
1585, 1720; 1186, 1239; 839, 854;...% CMTS switch cost
1431, 1516; 1131, 1231; 706, 745;... % TS mix cost
1636, 1585; 1088, 1186; 856, 839]; % CMTS mix cost

se=[63, 63; 53, 53; 23, 23;...
49, 49; 23, 23; 19 19;...
43, 43; 43, 43; 23, 23;...
61, 61; 28, 28; 32, 32];



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
set(h, 'Position', [100 100 2000 1000]);
set(gcf, 'Color', 'w');
set(gca,'FontSize',25);
xlim([0.5,8.5]);


%ylim([80 100]);
set(gca, 'YTick',500:200:1900, 'YLim',[500 1900])

hold on
y1=get(gca,'ylim');
plot([2.5, 2.5],y1, 'k-', [4.5 4.5], y1, 'k-', [6.5 6.5], y1, 'k-');


xlabh=xlabel({'TS Switch Cost                    CMTS Switch Cost                   TS Mix Cost                    CMTS Mix Cost'}, 'FontSize',30);
ylabh=ylabel({'RT (ms) to Targets'}, 'FontSize',30);


set(xlabh,'Position',get(xlabh,'Position') - [0 40 0]);
 % chance level

%clearvars -except result


%set(ylabh,'Position',get(ylabh,'Position') - [0.1 0 0])
