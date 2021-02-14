
clear

addpath(genpath('/Users/annapeng/Dropbox/Anna/PhD/Codes/CMTS/Demo/Baseline/results'));

result={'ID', 'Month', 'age', 'gender', 'targetset', 'Accuracy', 'RT', 'VisRt', 'AudRt', 'T1Vrt', 'T2Vrt', 'T1Art', 'T2Art'};

result_file=input('Save File As- ' ,'s');
result_file_mat=[result_file '.mat'];
file_dir=cd; %input('file directory- ' ,'s');
All_files=dir( [file_dir, '/*.csv']);
save(result_file,'result');
Filenames={All_files.name};

nfile=length(Filenames);

for i=1:nfile
    file=char(Filenames(i));
    within_subject_boots(file , result_file_mat)
end

load(result_file_mat)
write_results(result, result_file)
