function within_subject_boots( file , result_file)
%   Generate Bootstrapped Mean from each participants
%   Excluding the first 4 trials from each block
% switch case= total 18, among which 12 are target present

% clear
% 
% addpath(genpath('/Users/annapeng/Dropbox/Anna/PhD Year 1/Codes/Task Switch Code/results')); 
% file='YE001.csv';
% 
[~,ID,~] = fileparts(file);
[age,dob,date, gender,version,counter,block,trial,rule,target,Right,Left,rt_all,rightanswer,hit,nohits] = importfile(file, 2, 161);

iteration=5000; % iteration for bootstrap
minimumRT=0.3; % min response time
maximum=3.5; % max response time

%% Calculate Age in Months
DOB=cell2mat(dob(1,1));
DATE=cell2mat(date(1,1));
DOB=[DOB(4:6),DOB(1:3),DOB(7:8)];
DATE=[DATE(4:6),DATE(1:3),DATE(7:8)];

Month=months(DOB, DATE);

%% taking out the first 4 trials at the beginning of the block
rt=rt_all;
for i=1:length(rt_all)
    if rightanswer(i)==0 & rt_all(i)~=0
        rt(i)=0;
        incorrect_rt(i)=rt_all(i);
        
    elseif ((rt(i)<minimumRT && rt(i)>0)| rt(i)>maximum) & rightanswer(i)==1
        rt(i)=0;
        rightanswer(i)=0;
        incorrect_rt(i)=0;
    else
        rt(i)=rt_all(i);
        incorrect_rt(i)=0;
    end
    
end

omission=([1:4, 41:44, 81:84, 121:124])';
block(omission)=[];
rt(omission)=[];
rightanswer(omission)=[];
hit(omission)=[];
target(omission)=[];
trial(omission)=[];
version(omission)=[];
Right(omission)=[];
Left(omission)=[];

mix=block==3;
pure=block<3;
pure_rep=trial>1 & block<3;
pure_cue=trial==1 & block<3;
mix_swi=trial==1 & block==3;
mix_rep=trial>1 & block==3;



%% mean RTs
stat=nonzeros(rt);
stat = bootstrp(iteration, @mean, stat);
rt_mean=mean(stat);
% mean rt in pure block
stat=nonzeros(rt(pure));
pure_case=length(stat);
stat = bootstrp(iteration, @mean, stat);
rt_pure=mean(stat);
% mean rt in mix block
stat=nonzeros(rt(mix));
mix_case=length(stat);
stat = bootstrp(iteration, @mean, stat);
rt_mix=mean(stat);
% mean rt at cue position in the pure block
stat=nonzeros(rt(pure_cue));
pure_cue_case=length(stat);
stat = bootstrp(iteration, @mean, stat);
rt_pure_cue=mean(stat);
% mean rt in repetition position 234 in pure block (for calculating mixing
% cost)
stat=nonzeros(rt(pure_rep));
pure_rep_case=length(stat);
stat = bootstrp(iteration, @mean, stat);
rt_pure_rep=mean(stat);
% mean rt in repetition position 234 in mix block (for calculating mixing
% cost)
stat=nonzeros(rt(mix_rep));
mix_rep_case=length(stat);
stat = bootstrp(iteration, @mean, stat);
rt_mix_rep=mean(stat);
% mean rt in switch position in mix block
stat=nonzeros(rt(mix_swi));
mix_swi_case=length(stat);
stat = bootstrp(iteration, @mean, stat);
rt_mix_swi=mean(stat);

%% RT in each index
T2_pure=(trial==2 & pure);
stat=nonzeros(rt(T2_pure));
stat = bootstrp(iteration, @mean, stat);
T2_pure_rt=mean(stat);

T3_pure=(trial==3 & pure);
stat=nonzeros(rt(T3_pure));
stat = bootstrp(iteration, @mean, stat);
T3_pure_rt=mean(stat);

T4_pure=(trial==4 & pure);
stat=nonzeros(rt(T4_pure));
stat = bootstrp(iteration, @mean, stat);
T4_pure_rt=mean(stat);

T2_mix=(trial==2 & mix);
stat=nonzeros(rt(T2_mix));
stat = bootstrp(iteration, @mean, stat);
T2_mix_rt=mean(stat);

T3_mix=(trial==3 & mix);
stat=nonzeros(rt(T3_mix));
stat = bootstrp(iteration, @mean, stat);
T3_mix_rt=mean(stat);

T4_mix=(trial==4 & mix);
stat=nonzeros(rt(T4_mix));
stat = bootstrp(iteration, @mean, stat);
T4_mix_rt=mean(stat);

%% Accuracy Rate
% mean overall accuracy
mean_accuracy=mean(rightanswer);
% mean accuracy rate in each condition
pure_accuracy=mean(rightanswer(pure));
purerep_accuracy=mean(rightanswer(pure_rep));
mix_accuracy=mean(rightanswer(mix));
rep_accuracy=mean(rightanswer(mix_rep));
swi_accuracy=mean(rightanswer(mix_swi));
% no. of commission & omission errors and comission error rate in each condition

[ com_pure, precomPure ] = Commission( pure, rightanswer, hit);
[ com_mix, precomMix ] = Commission( mix, rightanswer, hit);
[ com_purerep, ~ ] = Commission( pure_rep, rightanswer, hit);
[ com_mixrep, ~ ] = Commission( mix_rep, rightanswer, hit);
[ com_swi, ~ ] = Commission( mix_swi, rightanswer, hit);

omi_pure=sum(pure)-sum(rightanswer(pure)==1)-com_pure;
omi_mix=sum(mix)-sum(rightanswer(mix)==1)-com_mix;
omi_purerep=sum(pure_rep)-sum(rightanswer(pure_rep)==1)-com_purerep;
omi_mixrep=sum(mix_rep)-sum(rightanswer(mix_rep)==1)-com_mixrep;
omi_swi=sum(mix_swi)-sum(rightanswer(mix_swi)==1)-com_swi;
total_omi_error=omi_pure+omi_mix;
total_com_error=com_mix+com_pure;
all_errors=sum(rightanswer==0);
com_vs_allerror=total_com_error/all_errors; % the proportion of commission error vs all errors

if isnan(com_vs_allerror)
    com_vs_allerror=0;
end


%% t-1 Response Facilitation Effect (without spatial consideration, only check trial position index with 2,3,4)
% to see if response to T-1 stimulus has facilitative effect at T trial
% comparing RT of repeated response and single response

% Generate positon index for the trials with respose repetition and single
% response
[ ~, single_response, ~, rep_response ] = resp_facilitation( pure_rep, target );
% mean rt for response repetition in pure block
stat=nonzeros(rt(rep_response));
pure_rsp_rep_case=length(stat);
if pure_rsp_rep_case>2
   stat = bootstrp(iteration, @mean, stat);
end
   rt_pure_rsp_rep=mean(stat);

% mean rt for single response in pure block
stat=nonzeros(rt(single_response));
pure_rsp_single_case=length(stat);
if pure_rsp_single_case>2
   stat = bootstrp(iteration, @mean, stat);
end
   rt_pure_rsp_sing=mean(stat);



% Generate positon index for the trials with respose repetition and single
% response
[ ~, single_response, ~, rep_response ] = resp_facilitation( mix_rep, target ); 
% mean rt for response repetition in mix block
stat=nonzeros(rt(rep_response));
mix_rsp_rep_case=length(stat);
if mix_rsp_rep_case>2
   stat = bootstrp(iteration, @mean, stat);
end
   rt_mix_rsp_rep=mean(stat);

% mean rt for single response in mix block
stat=nonzeros(rt(single_response));
mix_rsp_single_case=length(stat);
if mix_rsp_single_case>2
   stat = bootstrp(iteration, @mean, stat);
end
   rt_mix_rsp_sing=mean(stat);



%% Stimuli Congruencey Effect at the same trial
rt_block3=rt(mix);
mix_start=numel(mix(mix==0)); %from 73rd

% extracting the trials with congruent stimuli set
for i=1:length(rt_block3)
    k=i+mix_start;
    if ~isempty(cell2mat(strfind(Right(k), 'car'))) && ~isempty(cell2mat(strfind(Left(k), 'dog')))
       s_congruent(i,:)=1;
    elseif ~isempty(cell2mat(strfind(Right(k), 'dog'))) && ~isempty(cell2mat(strfind(Left(k), 'car')))
       s_congruent(i,:)=1;
    else
       s_congruent(i,:)=0;
    end
end
s_congruent=logical(s_congruent);

stat=nonzeros(rt_block3(s_congruent));
cong_case=length(stat);
if cong_case>2
stat = bootstrp(iteration, @mean, stat);
end
rt_s_cong=mean(stat);

stat=nonzeros(rt_block3(~s_congruent));
incong_case=length(stat);
if cong_case>2
stat = bootstrp(iteration, @mean, stat);
end
rt_s_incong=mean(stat);

% congruent trials at switch position
swi_cong= (s_congruent==1 & mix_swi(73:end)==1);
swi_incong= (s_congruent==0 & mix_swi(73:end)==1);
rep_cong= (s_congruent==1 & mix_swi(73:end)==0);
rep_incong= (s_congruent==0 & mix_swi(73:end)==0);
% switch congruent
stat=nonzeros(rt_block3(swi_cong));
swi_cong_case=length(stat);
if swi_cong_case>2
stat = bootstrp(iteration, @mean, stat);
end
rt_swi_cong=mean(stat);

% switch incongruent
stat=nonzeros(rt_block3(swi_incong));
swi_incong_case=length(stat);
if swi_incong_case>2
stat = bootstrp(iteration, @mean, stat);
end
rt_swi_incong=mean(stat);


% repetition congruent
stat=nonzeros(rt_block3(rep_cong));
rep_cong_case=length(stat);
if rep_cong_case>2
stat = bootstrp(iteration, @mean, stat);
end
rt_rep_cong=mean(stat);


% repetition incongruent
stat=nonzeros(rt_block3(rep_incong));
rep_incong_case=length(stat);
if rep_incong_case>2
stat = bootstrp(iteration, @mean, stat);
end
rt_rep_incong=mean(stat);

%incorrect trial RT in Pure
stat=nonzeros(incorrect_rt(pure));
incorrect_case=length(stat);
if incorrect_case>2
stat = bootstrp(iteration, @mean, stat);
end

if stat==0
   rt_pure_incorrect=[];
else
rt_pure_incorrect=mean(stat);
end

%incorrect trial RT in Mix
stat=nonzeros(incorrect_rt(mix));
incorrect_case=length(stat);
if incorrect_case>2
stat = bootstrp(iteration, @mean, stat);
end

if stat==0
   rt_mix_incorrect=[];
else
rt_mix_incorrect=mean(stat);
end

%incorrect trial RT in Pure_Rep
stat=nonzeros(incorrect_rt(pure_rep));
incorrect_case=length(stat);
if incorrect_case>2
stat = bootstrp(iteration, @mean, stat);
end

if stat==0
   rt_pureRep_incorrect=[];
else
rt_pureRep_incorrect=mean(stat);
end

%incorrect trial RT in Mix_Rep
stat=nonzeros(incorrect_rt(mix_rep));
incorrect_case=length(stat);
if incorrect_case>2
stat = bootstrp(iteration, @mean, stat);
end

if stat==0
   rt_mixRep_incorrect=[];
else
rt_mixRep_incorrect=mean(stat);
end


% storing result
DATA={age(1), Month, ID, gender(1), version(1),...
rt_mean, mean_accuracy,...
pure_case, rt_pure, mix_case, rt_mix,...
pure_rep_case, rt_pure_rep, pure_cue_case, rt_pure_cue...
mix_rep_case, rt_mix_rep mix_swi_case, rt_mix_swi,...
pure_rsp_rep_case, rt_pure_rsp_rep, pure_rsp_single_case, rt_pure_rsp_sing, ...
mix_rsp_rep_case, rt_mix_rsp_rep, mix_rsp_single_case, rt_mix_rsp_sing, ...
cong_case, rt_s_cong, incong_case, rt_s_incong,...
pure_accuracy, purerep_accuracy, mix_accuracy, ...
rep_accuracy, swi_accuracy,...
omi_pure, omi_mix, omi_purerep, omi_mixrep, omi_swi, total_omi_error,...
com_pure, com_mix, com_purerep, com_mixrep, com_swi, total_com_error, com_vs_allerror, all_errors...
swi_cong_case, rt_swi_cong, ...
swi_incong_case, rt_swi_incong...
rep_cong_case, rt_rep_cong...
rep_incong_case, rt_rep_incong...
T2_pure_rt, T3_pure_rt, T4_pure_rt...
T2_mix_rt, T3_mix_rt, T4_mix_rt, rt_pure_incorrect, rt_mix_incorrect, rt_pureRep_incorrect, rt_mixRep_incorrect, precomPure, precomMix};
    
load(result_file);
result(end+1,:)=DATA;
save(result_file, 'result');
end

