%addpath('/Users/annapeng/Dropbox/Anna/PhD Year 1/Codes/Task Switch Code/results/resampling_statistical_toolkit/statistics');
clear

addpath(genpath('/Users/annapeng/Dropbox/Anna/PhD Year 1/Codes/TS/results'));

result={'Age','Months', 'ID','Gender','Condition',...
'RT', 'Accuracy',...
'PureCase', 'PureRT', 'MixCase', 'MixRT',...
'PureRepCase' 'PureRepRT', 'PureCueCase', 'PureCueRT',...
'MixRepCase', 'MixRepRT', 'MixSwiCase', 'MixSwiRT',...
'RTskew','PureSkew', 'MixSkew', 'PureCueSkew', 'PureRepSkew','MixRepSkew', 'MixSwiSkew'... 
'RTCoef','PureCoef','MixCoef','PureCueCoef','PureRepCoef','MixRepCoef','MixSwiCoef'};



save_name=input('Save File As- ' ,'s');
result_file=[save_name '.mat'];
file_dir=cd; %input('file directory- ' ,'s');
All_files=dir( [file_dir, '/*.csv']);
save(result_file,'result');
Filenames={All_files.name};

nfile=length(Filenames);

for i=1:nfile
    file=char(Filenames(i));
    within_subject_boots(file , result_file)
end


load(result_file);
write_results(result, save_name)