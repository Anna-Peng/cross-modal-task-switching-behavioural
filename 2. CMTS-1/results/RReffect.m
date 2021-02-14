
% comparing RT of repeated response and single response

% PURE BLOCK RESPONSE REPETITION & SINGLE RESPONSE
[ ~, P_Rs, ~, P_Rr ] = resp_facilitation( P234, targetpresent );
stat=nonzeros(rt(P_Rr));
P_Rr_no=length(stat);
if P_Rr_no>2
   %stat = bootstrp(iteration, @mean, stat);
end
   P_Rr_rt=mean(stat);
   

stat=nonzeros(rt(P_Rs));
P_Rs_no=length(stat);
if P_Rs_no>2
   %stat = bootstrp(iteration, @mean, stat);
end
   P_Rs_rt=mean(stat);   

% MIX BLOCK RESPONSE REPETITION & SINGLE RESPONSE 

[ ~, M_Rs, ~, M_Rr ] = resp_facilitation( M234, targetpresent );
stat=nonzeros(rt(M_Rr));
M_Rr_no=length(stat);
if M_Rr_no>2
   %stat = bootstrp(iteration, @mean, stat);
end
   M_Rr_rt=mean(stat);
   

stat=nonzeros(rt(M_Rs));
M_Rs_no=length(stat);
if M_Rs_no>2
   %stat = bootstrp(iteration, @mean, stat);
end
   M_Rs_rt=mean(stat);   
