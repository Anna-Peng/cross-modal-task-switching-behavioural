function within_subject_boots( file , result_file)

%% outstanding variable: 
% Mix block crosstalk effect

%% Variable Definition
% 
% clear all
% result={'Month', 'age', 'gender', 'targetset', 'Accuracy', 'RT', 'VisRt', 'AudRt', 'T1Vrt', 'T2Vrt', 'T1Art', 'T2Art'};
% file='A01.csv';

[~,ID,~] = fileparts(file);
[age, dob, gender, date, modality,  targetset, counter, block, trial, rule, targetpresent, V_element, A_element, rt_all, answer, hit, nohits] = importfile(file, 2, 49);

iteration=1000; % iteration for bootstrap
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



omission=([1, 13, 25, 37])';
block(omission)=[];
rt(omission)=[];
answer(omission)=[];
hit(omission)=[];
targetpresent(omission)=[];
trial(omission)=[];
V_element(omission)=[];
A_element(omission)=[];
rule(omission)=[];
counter(omission)=[];
modality(omission)=[];
rt=rt*1000;
% [rt;answer]
%% Auditory Block and Visual Block

Vis=modality==1;
Aud=modality==2;
T1V=modality==1 & block==1;
T2V=modality==1 & block==2;
T1A=modality==2 & block==1;
T2A=modality==2 & block==2;

Accuracy=mean(answer);
%% mean main RTs in blocks (Pure, Mix, P1, P234, M1, M234)
stat=nonzeros(rt);
rt_mean=mean(stat);

stat=nonzeros(rt(Vis));
Vis_rt=mean(stat);

stat=nonzeros(rt(Aud));
Aud_rt=mean(stat);

stat=nonzeros(rt(T1V));
T1V_rt=mean(stat);

stat=nonzeros(rt(T2V));
T2V_rt=mean(stat);

stat=nonzeros(rt(T1A));
T1A_rt=mean(stat);

stat=nonzeros(rt(T2A));
T2A_rt=mean(stat);
%% WRITE RESULT

load(result_file);
result(end+1,:)={ID, Month, age(1,1), gender(1,1), targetset(1,1), Accuracy, rt_mean, Vis_rt, Aud_rt, T1V_rt, T2V_rt, T1A_rt, T2A_rt};
save(result_file, 'result');
    
end

