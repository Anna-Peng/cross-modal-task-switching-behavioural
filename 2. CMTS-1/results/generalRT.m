%% mean main RTs in blocks (Pure, Mix, P1, P234, M1, M234)
stat=nonzeros(rt(answer==1));
%stat = bootstrp(iteration, @mean, stat);
rt_mean=mean(stat);
% mean rt in pure block
stat=nonzeros(rt(pure));
P_no=length(stat);
%stat = bootstrp(iteration, @mean, stat);
P_rt=mean(stat);
% mean rt in mix block
stat=nonzeros(rt(mix));
M_no=length(stat);
%stat = bootstrp(iteration, @mean, stat);
M_rt=mean(stat);
% mean rt at cue position in the pure block
stat=nonzeros(rt(P1));
P1_no=length(stat);
%stat = bootstrp(iteration, @mean, stat);
P1_rt=mean(stat);

stat=nonzeros(rt(P2));
P2_no=length(stat);
%stat = bootstrp(iteration, @mean, stat);
P2_rt=mean(stat);

stat=nonzeros(rt(P3));
P3_no=length(stat);
%stat = bootstrp(iteration, @mean, stat);
P3_rt=mean(stat);

stat=nonzeros(rt(P4));
P4_no=length(stat);
%stat = bootstrp(iteration, @mean, stat);
P4_rt=mean(stat);
% mean rt in repetition position 234 in pure block (for calculating mixing cost)
stat=nonzeros(rt(P234));
P234_no=length(stat);
%stat = bootstrp(iteration, @mean, stat);
P234_rt=mean(stat);
% mean rt in switch position in mix block
stat=nonzeros(rt(M1));
M1_no=length(stat);
%stat = bootstrp(iteration, @mean, stat);
M1_rt=mean(stat);

stat=nonzeros(rt(M2));
M2_no=length(stat);
%stat = bootstrp(iteration, @mean, stat);
M2_rt=mean(stat);

stat=nonzeros(rt(M3));
M3_no=length(stat);
%stat = bootstrp(iteration, @mean, stat);
M3_rt=mean(stat);

stat=nonzeros(rt(M4));
M4_no=length(stat);
%stat = bootstrp(iteration, @mean, stat);
M4_rt=mean(stat);
% mean rt in repetition position 234 in mix block (for calculating mixing cost)
stat=nonzeros(rt(M234));
M234_no=length(stat);
%stat = bootstrp(iteration, @mean, stat);
M234_rt=mean(stat);


%% Mean main RT by channel (V, A)

% Pure block visual
stat=nonzeros(rt(answer==1 & V & pure));
PV_no=length(stat);
%stat = bootstrp(iteration, @mean, stat);
PV_rt=mean(stat);

% mix block visual
stat=nonzeros(rt(answer==1 & V & mix));
MV_no=length(stat);
%stat = bootstrp(iteration, @mean, stat);
MV_rt=mean(stat);


% Pure block visual
stat=nonzeros(rt(answer==1 & A & pure));
PA_no=length(stat);
%stat = bootstrp(iteration, @mean, stat);
PA_rt=mean(stat);

% mix block visual
stat=nonzeros(rt(answer==1 & A & mix));
MA_no=length(stat);
%stat = bootstrp(iteration, @mean, stat);
MA_rt=mean(stat);

% mix block visual
stat=nonzeros(rt(answer==1 & AV));
MAV_no=length(stat);
%stat = bootstrp(iteration, @mean, stat);
MAV_rt=mean(stat);

stat=nonzeros(rt(answer==1 & V & P234));
PV234_no=length(stat);
%stat = bootstrp(iteration, @mean, stat);
PV234_rt=mean(stat);

stat=nonzeros(rt(answer==1 & A & P234));
PA234_no=length(stat);
%stat = bootstrp(iteration, @mean, stat);
PA234_rt=mean(stat);
%% Crosstalk Effect in each block
% mix block visual
stat=nonzeros(rt(mix & Crosstalk==1));
cross_no=length(stat);
%stat = bootstrp(iteration, @mean, stat);
cross_rt=mean(stat);

stat=nonzeros(rt(mix & Crosstalk==0));
nocross_no=length(stat);
%stat = bootstrp(iteration, @mean, stat);
nocross_rt=mean(stat);

%% Position 1 by modality
% P1 visual
stat=nonzeros(rt(P1 & V));
P1V_no=length(stat);
if P1V_no>2
%stat = bootstrp(iteration, @mean, stat);
end
P1V_rt=mean(stat);

stat=nonzeros(rt(P1 & A));
P1A_no=length(stat);
if P1A_no>2
%stat = bootstrp(iteration, @mean, stat);
end
P1A_rt=mean(stat);

stat=nonzeros(rt(M1 & V));
M1V_no=length(stat);
if M1V_no>2
%stat = bootstrp(iteration, @mean, stat);
end
M1V_rt=mean(stat);

stat=nonzeros(rt(M1 & A));
M1A_no=length(stat);
if M1A_no>2
%stat = bootstrp(iteration, @mean, stat);
end
M1A_rt=mean(stat);
