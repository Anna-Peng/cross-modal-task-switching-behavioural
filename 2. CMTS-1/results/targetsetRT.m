% targetset

stat=nonzeros(rt(T1V));
T1V_no=length(stat);
%if T1V_no>2
%   stat = bootstrp(iteration, @mean, stat);
%end
   T1V_rt=mean(stat);
   
stat=nonzeros(rt(T1A));
T1A_no=length(stat);
%if T1A_no>2
%   stat = bootstrp(iteration, @mean, stat);
%end
   T1A_rt=mean(stat);  
   
stat=nonzeros(rt(T2V));
T2V_no=length(stat);
%if T2V_no>2
%   stat = bootstrp(iteration, @mean, stat);
%end
   T2V_rt=mean(stat);
   
stat=nonzeros(rt(T1A));
T2A_no=length(stat);
%if T2A_no>2
%   stat = bootstrp(iteration, @mean, stat);
%end
   T2A_rt=mean(stat); 