% 
% 
% index=[107, 101, 109, 99, 111, 105, 113, 103];
% 
% 
% for j=1:length(index)
%     for i=1:size(result,1)
%         a=result{i,index(j)};
%         if isempty(a)
%             result{i,j}={[]};
%         end
%     end
% end


% PV2V={result{2:end,107}};
% PA2V={result{2:end,101}};
% PA2A={result{2:end,109}};
% PV2A={result{2:end,99}};
% 
% MV2V={result{2:end,111}};
% MA2V={result{2:end,105}};
% MA2A={result{2:end,113}};
% MV2A={result{2:end,103}};
% 
% PV2V=cell2mat(PV2V);
% PA2V=cell2mat(PA2V);
% PA2A=cell2mat(PA2A);
% PV2A=cell2mat(PV2A);
% 
% MV2V=cell2mat(MV2V);
% MA2V=cell2mat(MA2V);
% MA2A=cell2mat(MA2A);
% MV2A=cell2mat(MV2A);
% 
% 
% meanRT=[mean(PV2V), mean(PA2V),...
%     mean(MV2V), mean(MA2V),...
%     mean(PA2A), mean(PV2A)...
%     mean(MA2A), mean(MV2A)];

meanRT=[1174, 1400; 1648, 1726;... % 4-yr-old
    794, 991; 953, 1107;...% 6-yr-old
    593, 663; 776, 1018]; % Adult

se=[88 88; 37 37;...
    51 51; 63 63;...
    16 16; 44 44];

h=figure(2);
box on
color_ref='rbrbrb';
errorbarpos=[repmat([1,2],2,1);repmat([3,4],2,1);repmat([5,6],2,1)];

for i=1:6
g=terrorbar(errorbarpos(i,:),meanRT(i,:), se(i,:), 0.1, 'centi');
set(g,'LineWidth',2, 'color', color_ref(i));
terrorbar(g,.7,'centi');
hold on
j(i)=plot(errorbarpos(i,:), meanRT(i,:), '.-', 'color', color_ref(i), 'markersize', 30);
hold on
end
    
legend_name= {'Baseline', 'Multimodal'};
leg=legend(j, legend_name, 'Location', 'NorthEastoutside');
legend BOXOFF

condition={'Visual', 'Auditory','Visual', 'Auditory','Visual', 'Auditory',};

set(gca,'XTick',1:6 ,'XTickLabel',condition);
set(h, 'Position', [100 100 1800 900]);
set(gcf, 'Color', 'w');
set(gca,'FontSize',26);
xlim([0.5,6.5]);


%ylim([80 100]);
set(gca, 'YTick',500:200:1900, 'YLim',[500 1900])

hold on
y1=get(gca,'ylim');
plot([2.5, 2.5],y1, 'k-', [4.5, 4.5],y1,'k-');


xlabh=xlabel({'4-Year-Olds                                  6-Year-Olds                                  Adults'}, 'FontSize',30);
ylabh=ylabel({'RT (ms) to Targets'}, 'FontSize',30);


set(xlabh,'Position',get(xlabh,'Position') - [0 40 0]);
 % chance level

%clearvars -except result


%set(ylabh,'Position',get(ylabh,'Position') - [0.1 0 0])
