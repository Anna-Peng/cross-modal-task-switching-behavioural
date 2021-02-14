
function within_subject_boots( file , result_file)

%% outstanding variable: 
% Mix block crosstalk effect

%% Variable Definition
% all_errors: all errors in the experiment
% P_com: commission error in the pure block
% M_com: commission error in the mix block
% M1_com: T1 position commission error
% M234_com: T234 position commission error
% PV_no & rt: Visual target trial no and rt in pure blocks (positive answers)
% PA_no & rt: Auditory target trial no and rt in pure blocks
% MV_no & rt: visual target trial no and rt in mix block
% MA_no & rt: auditory target trial no and rt in mix block
% MAV_no & rt: Visual-auditory target trial no and rt in mix block
% PV2A_no & rt: Visual to Auditory modality shift (i.e. audtory trial) no and rt in pure block
% PA2V_no & rt: Auditory to visual modality shift (i.e. visual trial) no and rt in pure block
% MV2A _no & rt: Visual to Auditory modality shift (i.e. audtory trial) no and rt in mix block
% MA2V_no & rt: Auditory to visual modality shift (i.e. visual trial) no and rt in mix block
% P_Rr_no & rt: Response repetition no and rt in pure block
% P_Rs_no & rt: Response single no and rt in pure block
% M_Rr_no & rt: Response repetition no and rt in mix block
% M_Rs_no & rt: Response single no and rt in mix block

% clear all
% file='A09.csv';

[~,ID,~] = fileparts(file);
[age, dob, gender, date, targetset, version, counter, block, trial, cueName, targetpresent, targetchannel, V_element, A_element, rt_all, answer, hit, nohits] = importfile(file, 2, 173);

iteration=0; % iteration for bootstrap
minimumRT=0.2; % min response time
maximumRT=3.5; % max response time

%% Calculate Age in Months
Month=months(dob(1,1), date(1,1));

% taking out the first 4 trials after each break: trial 1:4, 29:32,57:60, 85:88, 113:116, 141:144

rt=rt_all;
for i=1:length(rt_all)
    if answer(i)==0 & rt_all(i)~=0
        rt(i)=0;
    elseif rt_all(i)~=0 & (rt_all(i)<minimumRT || rt_all(i)>maximumRT)
        answer(i)=0;
        rt(i)=0;
    end
end

rt=rt*1000;
omission=([1:4, 29:32, 57:60, 85:88, 113:116, 141:144])';
block(omission)=[];
rt(omission)=[];
answer(omission)=[];
hit(omission)=[];
targetpresent(omission)=[];
trial(omission)=[];
version(omission)=[];
V_element(omission)=[];
A_element(omission)=[];
targetchannel(omission)=[];
cueName(omission)=[];
counter(omission)=[];


%% pure block index and mix block index, 
mix= block>2;
pure=block<3;

%% T1 & T234 index

P1=trial==1 & block<3;
P2=trial==2 & block<3;
P3=trial==3 & block<3;
P4=trial==4 & block<4;
P234=trial>1 & block<3;

M1=trial==1 & block>2;
M2=trial==2 & block>2;
M3=trial==3 & block>2;
M4=trial==4 & block>2;
M234=trial>1 & block>2;

%% V & A index
V=targetchannel==1;
A=targetchannel==2;
AV=targetchannel==3;

%% 2N modality index
% V2A & A2V in pure & mix
    V2A(1)=0;
    A2V(1)=0;
    A2A(1)=0;
    V2V(1)=0;
    Vsingle(1)=0;
    Asingle(1)=0;
    
    i=1;
    
    while i<length(rt)
    
    prevT=targetchannel(i);
    currentT=targetchannel(i+1);

        if prevT==1 & currentT==2
            V2A(i+1,1)=1;
            A2V(i+1,1)=0;
            V2V(i+1,1)=0;
            A2A(i+1,1)=0;
            Vsingle(i+1,1)=0;
            Asingle(i+1,1)=0;
        elseif prevT==2 & currentT==1
            V2A(i+1,1)=0;
            A2V(i+1,1)=1;
            V2V(i+1,1)=0;
            A2A(i+1,1)=0;
            Vsingle(i+1,1)=0;
            Asingle(i+1,1)=0;
        elseif prevT==1 & currentT==1
            V2A(i+1,1)=0;
            A2V(i+1,1)=0;
            V2V(i+1,1)=1;
            A2A(i+1,1)=0;
            Vsingle(i+1,1)=0;
            Asingle(i+1,1)=0;
        elseif prevT==2 & currentT==2
            V2A(i+1,1)=0;
            A2V(i+1,1)=0;
            V2V(i+1,1)=0;
            A2A(i+1,1)=1;
            Vsingle(i+1,1)=0;
            Asingle(i+1,1)=0;
        elseif prevT==0 & currentT==1 
            V2A(i+1,1)=0;
            A2V(i+1,1)=0;
            V2V(i+1,1)=0;
            A2A(i+1,1)=0;
            Vsingle(i+1,1)=1;
            Asingle(i+1,1)=0;
        elseif prevT==0 & currentT==2 
            V2A(i+1,1)=0;
            A2V(i+1,1)=0;
            V2V(i+1,1)=0;
            A2A(i+1,1)=0;
            Vsingle(i+1,1)=0;
            Asingle(i+1,1)=1; 
            
        else
            V2A(i+1,1)=0;
            A2V(i+1,1)=0;
            V2V(i+1,1)=0;
            A2A(i+1,1)=0;
            Vsingle(i+1,1)=0;
            Asingle(i+1,1)=0; 
        end 
        i=i+1;
    end
    
V2A=logical(V2A);
A2V=logical(A2V);
V2V=logical(V2V);
A2A=logical(A2A);
Vsingle=logical(Vsingle);
Asingle=logical(Asingle);

%% Crosstalk Index
% Crosstalk

if targetset(1)==1
    Name_T1='dog';
    Name_T2='bird';
else
    Name_T1='cat';
    Name_T2='sheep';
end

for i=1:length(rt)
    a=cell2mat(V_element(i));
    [~, Name_V]=fileparts(a);
    b=cell2mat(A_element(i));
    [~, Name_A]=fileparts(b);
    
    if (~isempty(strfind(Name_V, Name_T1))) && (~isempty(strfind(Name_A, Name_T2)))  % yes cross-talk
            Crosstalk(i,1)=1;
        elseif (~isempty(strfind(Name_A, Name_T1))) && (~isempty(strfind(Name_V, Name_T2))) % yes cross-talk
            Crosstalk(i,1)=1;
        elseif targetchannel(i,1)==3 % congruent i.e. dog+dog
            Crosstalk(i,1)=3;
        else
            Crosstalk(i,1)=0; % no crosstalk
    end
end

%% Target set index

switch targetset(1,1)
    case 1
    T1V= (pure & strcmp(cueName, 'bird.png') & targetchannel==1);
    T1A= (pure & strcmp(cueName, 'bird.png') & targetchannel==2);
    T2V= (pure & strcmp(cueName, 'dog.png') & targetchannel==1);
    T2A= (pure & strcmp(cueName, 'dog.png') & targetchannel==2);
    
    case 2
    T1V= (pure & strcmp(cueName, 'cat.png') & targetchannel==1);
    T1A= (pure & strcmp(cueName, 'cat.png') & targetchannel==2);
    T2V= (pure & strcmp(cueName, 'sheep.png') & targetchannel==1);
    T2A= (pure & strcmp(cueName, 'sheep.png') & targetchannel==2);
end

%% Calculate general RT
generalRT

%% Modality Effect
modality_shift_234
modality_shift_1
%% Accuracy Rate
accuracy

%% t-1 Response Facilitation Effect (without spatial consideration, only check trial position index with 2,3,4)
RReffect

%% targetset
targetsetRT

%% WRITE RESULT
load(result_file);

result(end+1,:)={ID, Month, age(1,1), gender(1,1), targetset(1,1),mean_accuracy,...
      MAV_accu, ...
     P_accu, P1_accu, P2_accu, P3_accu, P4_accu, P234_accu, M_accu, M1_accu, M2_accu, M3_accu, M4_accu, M234_accu,...
     PV_accu, PA_accu, MV_accu, MA_accu...
     PVsing_accu, PAsing_accu, MVsing_accu, MAsing_accu, PV2V_accu,...
     MV2V_accu, PA2V_accu, MA2V_accu, PA2A_accu, MA2A_accu, PV2A_accu, MV2A_accu,...
     rt_mean, P_no, P_rt, M_no, M_rt, P1_no, P1_rt, P2_no, P2_rt, P3_no, P3_rt, P4_no, P4_rt, P234_no, P234_rt,...
     M1_no, M1_rt, M2_no, M2_rt, M3_no, M3_rt, M4_no, M4_rt, M234_no, M234_rt,... 
     PV_no, PV_rt, PA_no, PA_rt, MV_no, MV_rt, MA_no, MA_rt, MAV_no, MAV_rt,...
     PV234_no, PV234_rt, PA234_no, PA234_rt,...
     Vsing_no, Vsing_rt, Asing_no, Asing_rt, V2A_no, V2A_rt, A2V_no, A2V_rt, V2V_no, V2V_rt, A2A_no, A2A_rt,...
     PVsing_no, PVsing_rt, PAsing_no, PAsing_rt, MVsing_no, MVsing_rt, MAsing_no, MAsing_rt,...
     P1Vsing_no, P1Vsing_rt, P1Asing_no, P1Asing_rt, M1Vsing_no, M1Vsing_rt, M1Asing_no, M1Asing_rt,...
     PV2A_no, PV2A_rt, PA2V_no, PA2V_rt, MV2A_no, MV2A_rt, MA2V_no, MA2V_rt...
     PV2V_no, PV2V_rt, PA2A_no, PA2A_rt, MV2V_no, MV2V_rt, MA2A_no, MA2A_rt...
     P1V2A_no, P1V2A_rt, P1A2V_no, P1A2V_rt, M1V2A_no, M1V2A_rt, M1A2V_no, M1A2V_rt...
     P1V2V_no, P1V2V_rt, P1A2A_no, P1A2A_rt, M1V2V_no, M1V2V_rt, M1A2A_no, M1A2A_rt...
     P1V_no, P1V_rt, P1A_no, P1A_rt, M1V_no, M1V_rt, M1A_no, M1A_rt,... 
     P_Rr_no, P_Rr_rt, P_Rs_no, P_Rs_rt...
     M_Rr_no, M_Rr_rt, M_Rs_no, M_Rs_rt...
     cross_no, cross_rt, nocross_no, nocross_rt,...
     T1V_no, T1V_rt, T1A_no, T1A_rt...
     T2V_no, T2V_rt, T2A_no, T2A_rt};

save(result_file, 'result');
    
end

%       all_errors, P_com, M_com, M1_com, M234_com,...
%     P_RrV2V_no, P_RrV2V_rt, P_RrA2V_no,P_RrA2V_rt...
%     P_RrA2A_no, P_RrA2A_rt, P_RrV2A_no,P_RrV2A_rt...
%     M_RrV2V_no, M_RrV2V_rt, M_RrA2V_no,M_RrA2V_rt...
%     M_RrA2A_no, M_RrA2A_rt, M_RrV2A_no,M_RrV2A_rt