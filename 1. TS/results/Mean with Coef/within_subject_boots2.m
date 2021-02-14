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
stat=rt(rt>minimumRT & rt<maximum & rightanswer==1);
rt_mean=mean(stat);
rt_skew=skewness(stat);
rt_coef=std(stat)/mean(stat);

% mean rt in pure block
stat=nonzeros(rt(pure));
pure_case=length(stat);
rt_pure=mean(stat);
rt_pure_skew=skewness(stat);
rt_pure_coef=std(stat)/mean(stat);

% mean rt in mix block
stat=nonzeros(rt(mix));
mix_case=length(stat);
rt_mix=mean(stat);
rt_mix_skew=skewness(stat);
rt_mix_coef=std(stat)/mean(stat);

% mean rt at cue position in the pure block
stat=nonzeros(rt(pure_cue));
pure_cue_case=length(stat);
rt_pure_cue=mean(stat);
rt_purecue_skew=skewness(stat);
rt_purecue_coef=std(stat)/mean(stat);

% mean rt in repetition position 234 in pure block (for calculating mixing
% cost)
stat=nonzeros(rt(pure_rep));
pure_rep_case=length(stat);
rt_pure_rep=mean(stat);
rt_purerep_skew=skewness(stat);
rt_purerep_coef=std(stat)/mean(stat);

% mean rt in repetition position 234 in mix block (for calculating mixing
% cost)
stat=nonzeros(rt(mix_rep));
mix_rep_case=length(stat);
rt_mix_rep=mean(stat);
rt_mixrep_skew=skewness(stat);
rt_mixrep_coef=std(stat)/mean(stat);

% mean rt in switch position in mix block
stat=nonzeros(rt(mix_swi));
mix_swi_case=length(stat);
rt_mix_swi=mean(stat);
rt_mixswi_skew=skewness(stat);
rt_mixswi_coef=std(stat)/mean(stat);


%% Accuracy Rate
% mean overall accuracy
mean_accuracy=mean(rightanswer);


% storing result
DATA={age(1), Month, ID, gender(1), version(1),...
rt_mean, mean_accuracy,...
pure_case, rt_pure, mix_case, rt_mix,...
pure_rep_case, rt_pure_rep, pure_cue_case, rt_pure_cue...
mix_rep_case, rt_mix_rep, mix_swi_case, rt_mix_swi,...
rt_skew,rt_pure_skew, rt_mix_skew, rt_purecue_skew, rt_purerep_skew,rt_mixrep_skew, rt_mixswi_skew,...
rt_coef,rt_pure_coef, rt_mix_coef, rt_purecue_coef, rt_purerep_coef, rt_mixrep_coef,rt_mixswi_coef};
    
load(result_file);
result(end+1,:)=DATA;
save(result_file, 'result');
end

