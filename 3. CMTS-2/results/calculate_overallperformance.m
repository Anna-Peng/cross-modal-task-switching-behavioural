%% Overall RT
% overallRT=mean(nonzeros(rt));

stat=nonzeros(rt);
overallRT_no=length(stat);
if overallRT_no>2
stat = bootstrp(iteration, @mean, stat);
end
overallRT=mean(stat);

if isnan(overallRT)
    overallRT=[];
end



% Overall accuracy
overallAccu=mean(answer);