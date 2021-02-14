
clear

addpath(genpath('/Users/annapeng/Google Drive/Anna/PhD/Codes/2. CMTS-1/results'));

result={'ID', 'Month', 'age', 'gender', 'targetset', 'accuracy',...
    'MAVaccu',...
     'Paccu', 'P1accu', 'P2accu', 'P3accu', 'P4accu', 'P234accu', 'Maccu', 'M1accu', 'M2accu', 'M3accu', 'M4accu', 'M234accu',...
     'PVaccu', 'PAaccu', 'MVaccu', 'MAaccu'...
     'PVsingAccu', 'PAsingAccu', 'MVsingAccu', 'MAsingAccu', 'PV2Vaccu',...
     'MV2Vaccu', 'PA2Vaccu', 'MA2Vaccu', 'PA2Aaccu', 'MA2Aaccu', 'PV2Aaccu', 'MV2Aaccu',...
     'rtmean', 'Pno', 'Prt', 'Mno', 'Mrt', 'P1no', 'P1rt', 'P2no', 'P2rt', 'P3no', 'P3rt', 'P4no', 'P4rt', 'P234no', 'P234rt',...
     'M1no', 'M1rt', 'M2no', 'M2rt', 'M3no', 'M3rt', 'M4no', 'M4rt', 'M234no', 'M234rt',... 
     'PVno', 'PVrt', 'PAno', 'PArt', 'MVno', 'MVrt', 'MAno', 'MArt', 'MAVno', 'MAVrt',...
     'PV234no', 'PV234rt', 'PA234no', 'PA234rt',...
     'Vsingno', 'Vsingrt', 'Asingno', 'Asingrt', 'V2Ano', 'V2Art', 'A2Vno', 'A2Vrt', 'V2Vno', 'V2Vrt', 'A2Ano', 'A2Art',...
     'PVsingno', 'PVsingrt', 'PAsingno', 'PAsingrt', 'MVsingno', 'MVsingrt', 'MAsingno', 'MAsingrt',...
     'P1Vsingno', 'P1Vsingrt', 'P1Asingno', 'P1Asingrt', 'M1Vsingno', 'M1Vsingrt', 'M1Asingno', 'M1Asingrt',...
     'PV2Ano', 'PV2Art', 'PA2Vno', 'PA2Vrt', 'MV2Ano', 'MV2Art', 'MA2Vno', 'MA2Vrt',...
     'PV2Vno', 'PV2Vrt', 'PA2Ano', 'PA2Art', 'MV2Vno', 'MV2Vrt', 'MA2Ano', 'MA2Art',...
     'P1V2Ano', 'P1V2Art', 'P1A2Vno', 'P1A2Vrt', 'M1V2Ano', 'M1V2Art', 'M1A2Vno', 'M1A2Vrt',...
     'P1V2Vno', 'P1V2Vrt', 'P1A2Ano', 'P1A2Art', 'M1V2Vno', 'M1V2Vrt', 'M1A2Ano', 'M1A2Art',...
     'P1Vno', 'P1Vrt', 'P1Ano', 'P1Art', 'M1Vno', 'M1Vrt', 'M1Ano', 'M1Art',... 
     'PRrno', 'PRrrt', 'PRsno', 'PRsrt',...
     'MRrno', 'MRrrt', 'MRsno', 'MRsrt',...
     'crossno', 'crossrt', 'nocrossno', 'nocrossrt',...
     'T1Vno', 'T1Vrt', 'T1Ano', 'T1Art',...
     'T2Vno', 'T2Vrt', 'T2Ano', 'T2Art'};


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
