%% ACURRACY
% mean overall accuracy
mean_accuracy=mean(answer);
% mean accuracy rate in each condition
P_accu=mean(answer(pure));
M_accu=mean(answer(mix));
P1_accu=mean(answer(P1));
P2_accu=mean(answer(P2));
P3_accu=mean(answer(P3));
P4_accu=mean(answer(P4));
P234_accu=mean(answer(P234));
M1_accu=mean(answer(M1));
M2_accu=mean(answer(M2));
M3_accu=mean(answer(M3));
M4_accu=mean(answer(M4));
M234_accu=mean(answer(M234));

% Accuracy by modality
PV_accu=mean(answer(pure & V));
MV_accu=mean(answer(mix & V));

PA_accu=mean(answer(pure & A));
MA_accu=mean(answer(mix & A));
MAV_accu=mean(answer(mix & AV));

PVsing_accu=mean(answer(pure & Vsingle));
PAsing_accu=mean(answer(pure & Asingle));
MVsing_accu=mean(answer(mix & Vsingle));
MAsing_accu=mean(answer(mix & Asingle));

PV2V_accu=mean(answer(pure & V2V));
PVSV_accu=mean(answer(pure & V2V));
MV2V_accu=mean(answer(mix & V2V));
MVSV_accu=mean(answer(mix & V2V));

PV2A_accu=mean(answer(pure & V2A));
PVSA_accu=mean(answer(pure & V2A));
MV2A_accu=mean(answer(mix & V2A));
MVSA_accu=mean(answer(mix & V2A));

PA2A_accu=mean(answer(pure & A2A));
PASA_accu=mean(answer(pure & A2A));
MA2A_accu=mean(answer(mix & A2A));
MASA_accu=mean(answer(mix & A2A));

PA2V_accu=mean(answer(pure & A2V));
PASV_accu=mean(answer(pure & A2V));
MA2V_accu=mean(answer(mix & A2V));
MASV_accu=mean(answer(mix & A2V));
% no. of commission errors and comission error rate in each condition
all_errors=172-24-sum(answer);
[ P_com ] = Commission( pure, answer, hit);
[ M_com ] = Commission( mix, answer, hit);
[ M234_com ] = Commission( M234, answer, hit);
[ M1_com ] = Commission( M1, answer, hit);
