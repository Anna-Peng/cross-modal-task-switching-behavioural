
clear

addpath(genpath('/Users/annapeng/Dropbox/Anna/PhD Year 1/Codes/CMTS/results'));

result={'ID', 'Month', 'age', 'gender','overallRT', 'overallAccu'...
'aTRno', 'aTSno', 'aMRno', 'aMSno', 'aMRTRno', 'aMRTSno', 'aCMTRno', 'aCMTSno',...
'MRTRRsNo', 'MRTRRs', 'MRTRRrNo', 'MRTRRr',...
'MRTSRsNo', 'MRTSRs', 'MRTSRrNo', 'MRTSRr',...
'MSTRRsNo', 'MSTRRs', 'MSTRRrNo', 'MSTRRr',...
'MSTSRsNo', 'MSTSRs', 'MSTSRrNo', 'MSTSRr',...
'TRRsNo', 'TRRs', 'TRRrNo', 'TRRr', 'TSRsNo', 'TSRs', 'TSRrNo', 'TSRr',...
'MRRsno', 'MRRs', 'MRRrno', 'MRRr', 'MSRsno', 'MSRs', 'MSRrno', 'MSRr'};
%     'visNo','visRT', 'audNo','audRT',...
%     'mrtrNo','mrtrRT', 'cmtrNo','cmtrRT', 'mrtsNo', 'mrtsRT', 'cmtsNo','cmtsRT',...
%     'visAccu', 'audAccu', 'mrtrAccu', 'cmtrAccu', 'mrtsAccu', 'cmtsAccu',...
%     'v2vAccu', 'a2vAccu', 'a2aAccu', 'v2aAccu', 'VSingleAccu', 'ASingleAccu'...
%     'mrtrVNo','mrtrV','mrtrANo','mrtrA','mrtsVNo','mrtsV','mrtsANo','mrtsA',...
%     'cmtrVNo','cmtrV','cmtrANo','cmtrA','cmtsVNo','cmtsV','cmtsANo','cmtsA',...
%     'trVsingleNo','trVsingleRT', 'trAsingleNo','trAsingleRT'};


result_file=input('Save File As- ' ,'s');
result_file_mat=[result_file '.mat'];
file_dir=cd; %input('file directory- ' ,'s');
All_files=dir( [file_dir, '/*.csv']);
save(result_file,'result');
Filenames={All_files.name};

whichfile=input('Which participant do you wish to analyse? (''ID''/ or ''All'')', 's');
if strcmpi(whichfile, 'all')
    endfile=length(Filenames);
    startfile=1;
else
    endfile=strmatch(whichfile,Filenames);
    startfile=endfile;
end


for i=startfile:endfile
    file=char(Filenames(i));
    within_subject_boots(file , result_file_mat)
end

load(result_file_mat)
write_results(result, result_file)
