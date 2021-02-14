
function within_subject_boots( file , result_file)

%% outstanding variable: 
% Mix block crosstalk effect

%% Variable Definition

% clear all
% file='AE07.csv';

[~,ID,~] = fileparts(file);
[~,Age,DOB,Gender,Date1,counter,cueName,modality,~,targetpresent,TargetName,TS,MS,answer,rt_all,hit] = importfile(file, 2, 121);
iteration=5000; % iteration for bootstrap
minimumRT=0.3; % min response time

%% Processing Trial Index
MS=(MS==1 & targetpresent==1);
    MSno=sum(MS);
MR=(MS==0 & targetpresent==1);
    MRno=sum(MR);
TS=(TS==1 & targetpresent==1);
    TSno=sum(TS);
TR=(TS==0 & targetpresent==1);
    TRno=sum(TR);
CMTS= (TS==1 & MS==1 & targetpresent==1);
    CMTSno=sum(CMTS);
MRTS= (TS==1 & MS==0 & targetpresent==1);
    MRTSno=sum(MRTS);
CMTR= (TS==0 & MS==1 & targetpresent==1);
    CMTRno=sum(CMTR);
MRTR= (TS==0 & MS==0 & targetpresent==1);
    MRTRno=sum(MRTR);

%% Calculate Age in Months
Month=months(DOB(1,1), Date1(1,1));

rt=rt_all;
for i=1:length(rt_all)
    if answer(i)==0 & rt_all(i)~=0
        rt(i)=0;
    elseif rt_all(i)~=0 & (rt_all(i)<minimumRT)
        answer(i)=0;
        rt(i)=0;
    end
end

rt=rt*1000;
omission=([1,25,49,73,97]); % TAKE OUT THE FIRST TRIAL OF EACH BLOCK
rt(omission)=[];
answer(omission)=[];
hit(omission)=[];
modality(omission)=[];
TargetName(omission)=[];
TS(omission)=[];
MS(omission)=[];
TR(omission)=[];
MR(omission)=[];
MRTR(omission)=[];
MRTS(omission)=[];
CMTR(omission)=[];
CMTS(omission)=[];
cueName(omission)=[];
counter(omission)=[];
targetpresent(omission)=[];


%% Visual & Auditory Index
Vis=modality==1;
Aud=modality==0;


%% TAGRET CHANNEL
targetchannel=0;
for i=1:length(rt)
    if targetpresent(i,1)==1;
        if modality(i)==1;
            targetchannel(i,1)=1; % visual
        else
            targetchannel(i,1)=2; % aud
        end
    else
        targetchannel(i,1)=0; % no target
    end
end


%% 2N modality index
% V2A & A2V in pure & mix
    V2A(1)=0; %initiation
    A2V(1)=0;
    A2A(1)=0;
    V2V(1)=0;
    VSingle(1)=0;
    ASingle(1)=0;
    
    i=1;
    
    while i<length(rt)
    
    prevT=targetchannel(i,1);
    currentT=targetchannel(i+1,1);

        if prevT==1 & currentT==2
            V2A(i+1,1)=1;
            A2V(i+1,1)=0;
            V2V(i+1,1)=0;
            A2A(i+1,1)=0;
            VSingle(i+1,1)=0;
            ASingle(i+1,1)=0;
        elseif prevT==2 & currentT==1
            V2A(i+1,1)=0;
            A2V(i+1,1)=1;
            V2V(i+1,1)=0;
            A2A(i+1,1)=0;
            VSingle(i+1,1)=0;
            ASingle(i+1,1)=0;
        elseif prevT==1 & currentT==1
            V2A(i+1,1)=0;
            A2V(i+1,1)=0;
            V2V(i+1,1)=1;
            A2A(i+1,1)=0;
            VSingle(i+1,1)=0;
            ASingle(i+1,1)=0;
        elseif prevT==2 & currentT==2
            V2A(i+1,1)=0;
            A2V(i+1,1)=0;
            V2V(i+1,1)=0;
            A2A(i+1,1)=1;
            VSingle(i+1,1)=0;
            ASingle(i+1,1)=0;
        elseif prevT==0 & currentT==1 
            V2A(i+1,1)=0;
            A2V(i+1,1)=0;
            V2V(i+1,1)=0;
            A2A(i+1,1)=0;
            VSingle(i+1,1)=1;
            ASingle(i+1,1)=0;
        elseif prevT==0 & currentT==2 
            V2A(i+1,1)=0;
            A2V(i+1,1)=0;
            V2V(i+1,1)=0;
            A2A(i+1,1)=0;
            VSingle(i+1,1)=0;
            ASingle(i+1,1)=1; 
            
        else
            V2A(i+1,1)=0;
            A2V(i+1,1)=0;
            V2V(i+1,1)=0;
            A2A(i+1,1)=0;
            VSingle(i+1,1)=0;
            ASingle(i+1,1)=0; 
        end 
        i=i+1;
    end
    
V2A=logical(V2A);
A2V=logical(A2V);
V2V=logical(V2V);
A2A=logical(A2A);
VSingle=logical(VSingle);
ASingle=logical(ASingle);

% calculate_rt
% calculate_accuracy

calculate_overallperformance
calculate_RR



%% WRITE RESULT
load(result_file);

result(end+1,:)={ID, Month, Age(1,1), Gender(1,1),overallRT, overallAccu,...
TRno, TSno, MRno, MSno, MRTRno, MRTSno, CMTRno, CMTSno,...
MRTR_Rs_no, MRTRRs, MRTR_Rr_no, MRTRRr,...
MRTS_Rs_no, MRTSRs, MRTS_Rr_no, MRTSRr,...
MSTR_Rs_no, MSTRRs, MSTR_Rr_no, MSTRRr,...
MSTS_Rs_no, MSTSRs, MSTS_Rr_no, MSTSRr,...
TR_Rs_no, TRRs, TR_Rr_no, TRRr, TS_Rs_no, TSRs, TS_Rr_no, TSRr,...
MR_Rs_no, MRRs, MR_Rr_no, MRRr, MS_Rs_no, MSRs, MS_Rr_no, MSRr};

%     visNo,visRT, audNo,audRT,...
%     mrtrNo,mrtrRT, cmtrNo,cmtrRT, mrtsNo, mrtsRT, cmtsNo,cmtsRT,...
%     visAccu, audAccu, mrtrAccu, cmtrAccu, mrtsAccu, cmtsAccu,...
%     v2vAccu, a2vAccu, a2aAccu, v2aAccu, VSingleAccu, ASingleAccu...
%     mrtrVNo,mrtrVRT,mrtrANo,mrtrART,mrtsVNo,mrtsVRT,mrtsANo,mrtsART,...
%     cmtrVNo,cmtrVRT,cmtrANo,cmtrART,cmtsVNo,cmtsVRT,cmtsANo,cmtsART,...
%     trVsingleNo,trVsingleRT, trAsingleNo,trAsingleRT};


save(result_file, 'result');
    
end
