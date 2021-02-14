
% comparing RT of repeated response and single response

%% MRTR RESPONSE REPETITION & SINGLE RESPONSE
[ MRTRRsNo, MRTR_Rs, MRTRRrNo, MRTR_Rr ] = resp_facilitation( MRTR, targetpresent );
stat=nonzeros(rt(MRTR_Rr));
MRTR_Rr_no=length(stat);
if MRTR_Rr_no>2
   stat = bootstrp(iteration, @mean, stat);
end
   MRTRRr=mean(stat);
   
stat=nonzeros(rt(MRTR_Rs));
MRTR_Rs_no=length(stat);
if MRTR_Rs_no>2
   stat = bootstrp(iteration, @mean, stat);
end
   MRTRRs=mean(stat);  

%% MRTS RESPONSE REPETITION & SINGLE RESPONSE
[ MRTSRsNo, MRTS_Rs, MRTSRrNo, MRTS_Rr ] = resp_facilitation( MRTS, targetpresent );
stat=nonzeros(rt(MRTS_Rr));
MRTS_Rr_no=length(stat);
if MRTS_Rr_no>2
   stat = bootstrp(iteration, @mean, stat);
end
   MRTSRr=mean(stat);
   
stat=nonzeros(rt(MRTS_Rs));
MRTS_Rs_no=length(stat);
if MRTS_Rs_no>2
   stat = bootstrp(iteration, @mean, stat);
end
   MRTSRs=mean(stat);  
   
%% MSTR RESPONSE REPETITION & SINGLE RESPONSE
[ MSTRRsNo, MSTR_Rs, MSTRRrNo, MSTR_Rr ] = resp_facilitation( CMTR, targetpresent );
stat=nonzeros(rt(MSTR_Rr));
MSTR_Rr_no=length(stat);
if MSTR_Rr_no>2
   stat = bootstrp(iteration, @mean, stat);
end
   MSTRRr=mean(stat);
   
stat=nonzeros(rt(MSTR_Rs));
MSTR_Rs_no=length(stat);
if MSTR_Rs_no>2
   stat = bootstrp(iteration, @mean, stat);
end
   MSTRRs=mean(stat);  
   
%% MSTS RESPONSE REPETITION & SINGLE RESPONSE
[ MSTSRsNo, MSTS_Rs, MSTSRrNo, MSTS_Rr ] = resp_facilitation( CMTS, targetpresent );
stat=nonzeros(rt(MSTS_Rr));
MSTS_Rr_no=length(stat);
if MSTS_Rr_no>2
   stat = bootstrp(iteration, @mean, stat);
end
   MSTSRr=mean(stat);
   
stat=nonzeros(rt(MSTS_Rs));
MSTS_Rs_no=length(stat);
if MSTS_Rs_no>2
   stat = bootstrp(iteration, @mean, stat);
end
   MSTSRs=mean(stat);  
   
%% TS RESPONSE REPETITION & SINGLE RESPONSE
[ TSRsNo, TS_Rs, TSRrNo, TS_Rr ] = resp_facilitation( TS, targetpresent );
stat=nonzeros(rt(TS_Rr));
TS_Rr_no=length(stat);
if TS_Rr_no>2
   stat = bootstrp(iteration, @mean, stat);
end
   TSRr=mean(stat);
   
stat=nonzeros(rt(TS_Rs));
TS_Rs_no=length(stat);
if TS_Rs_no>2
   stat = bootstrp(iteration, @mean, stat);
end
   TSRs=mean(stat);  
   
%% TR RESPONSE REPETITION & SINGLE RESPONSE
[ TRRsNo, TR_Rs, TRRrNo, TR_Rr ] = resp_facilitation( TR, targetpresent );
stat=nonzeros(rt(TR_Rr));
TR_Rr_no=length(stat);
if TR_Rr_no>2
   stat = bootstrp(iteration, @mean, stat);
end
   TRRr=mean(stat);
   
stat=nonzeros(rt(TR_Rs));
TR_Rs_no=length(stat);
if TR_Rs_no>2
   stat = bootstrp(iteration, @mean, stat);
end
   TRRs=mean(stat);  
   
   %% MS RESPONSE REPETITION & SINGLE RESPONSE
[ MSRsNo, MS_Rs, MSRrNo, MS_Rr ] = resp_facilitation( MS, targetpresent );
stat=nonzeros(rt(MS_Rr));
MS_Rr_no=length(stat);
if MS_Rr_no>2
   stat = bootstrp(iteration, @mean, stat);
end
   MSRr=mean(stat);
   
stat=nonzeros(rt(MS_Rs));
MS_Rs_no=length(stat);
if MS_Rs_no>2
   stat = bootstrp(iteration, @mean, stat);
end
   MSRs=mean(stat);  
   
%% TR RESPONSE REPETITION & SINGLE RESPONSE
[ MRRsNo, MR_Rs, MRRrNo, MR_Rr ] = resp_facilitation( MR, targetpresent );
stat=nonzeros(rt(MR_Rr));
MR_Rr_no=length(stat);
if MR_Rr_no>2
   stat = bootstrp(iteration, @mean, stat);
end
   MRRr=mean(stat);
   
stat=nonzeros(rt(MR_Rs));
MR_Rs_no=length(stat);
if MR_Rs_no>2
   stat = bootstrp(iteration, @mean, stat);
end
   MRRs=mean(stat);  