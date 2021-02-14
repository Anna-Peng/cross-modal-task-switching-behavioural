
%% Visual RT
% N=rt(targetchannel==1);
% visRT=mean(nonzeros(N));
% visNo=length(nonzeros(N));

stat=nonzeros(rt(targetchannel==1));
visNo=length(stat);
if visNo>2
stat = bootstrp(iteration, @mean, stat);
end
visRT=mean(stat);

if isnan(visRT)
    visRT=[];
end

%% Auditory RT
% N=rt(targetchannel==2);
% audRT=mean(nonzeros(N));
% audNo=length(nonzeros(N));

stat=nonzeros(rt(targetchannel==2));
audNo=length(stat);
if audNo>2
stat = bootstrp(iteration, @mean, stat);
end
audRT=mean(stat);
 
if isnan(audRT)
    audRT=[];
end


%% CMTS RT CROSS-MODAL TASK-SWITCH
% N=rt(CMTS);
% cmtsRT=mean(nonzeros(N));
% cmtsNo=length(nonzeros(N));

stat=nonzeros(rt(CMTS));
cmtsNo=length(stat);
if cmtsNo>2
stat = bootstrp(iteration, @mean, stat);
end
cmtsRT=mean(stat);
 
if isnan(cmtsRT)
    cmtsRT=[];
end

%% MRTR RT MODALITY-REPEAT TASK-REPEAT
% N=rt(MRTR);
% mrtrRT=mean(nonzeros(N));
% mrtrNo=length(nonzeros(N));

stat=nonzeros(rt(MRTR));
mrtrNo=length(stat);
if mrtrNo>2
stat = bootstrp(iteration, @mean, stat);
end
mrtrRT=mean(stat);
 
if isnan(mrtrRT)
    mrtrRT=[];
end

%% CMTR RT CROSS-MODAL TASK-REPEAT
% N=rt(CMTR);
% cmtrRT=mean(nonzeros(N));
% cmtrNo=length(nonzeros(N));

stat=nonzeros(rt(CMTR));
cmtrNo=length(stat);
if cmtrNo>2
stat = bootstrp(iteration, @mean, stat);
end
cmtrRT=mean(stat);
 
if isnan(cmtrRT)
    cmtrRT=[];
end


%% MRTS RT MODALITY-REPEAT TASK-SWITCH
% N=rt(MRTS);
% mrtsRT=mean(nonzeros(N));
% mrtsNo=length(nonzeros(N));

stat=nonzeros(rt(MRTS));
mrtsNo=length(stat);
if mrtsNo>2
stat = bootstrp(iteration, @mean, stat);
end
mrtsRT=mean(stat);
 
if isnan(mrtsRT)
    mrtsRT=[];
end


%% CMTS by Modality 
%% mrtrV
% N=rt(V2V & MRTR);
% mrtrV=mean(nonzeros(N));
% mrtrVNo=length(nonzeros(N));

stat=nonzeros(rt(V2V & MRTR));
mrtrVNo=length(stat);
if mrtrVNo>2
stat = bootstrp(iteration, @mean, stat);
end
mrtrVRT=mean(stat);
 
if isnan(mrtrVRT)
    mrtrVRT=[];
end

%% mrtrA
% N=rt(A2A & MRTR);
% mrtrA=mean(nonzeros(N));
% mrtrANo=length(nonzeros(N));

stat=nonzeros(rt(A2A & MRTR));
mrtrANo=length(stat);
if mrtrANo>2
stat = bootstrp(iteration, @mean, stat);
end
mrtrART=mean(stat);
 
if isnan(mrtrART)
    mrtrART=[];
end

%% mrtsV
% N=rt(V2V & MRTS);
% mrtsV=mean(nonzeros(N));
% mrtsVNo=length(nonzeros(N));

stat=nonzeros(rt(V2V & MRTS));
mrtsVNo=length(stat);
if mrtsVNo>2
stat = bootstrp(iteration, @mean, stat);
end
mrtsVRT=mean(stat);
 
if isnan(mrtsVRT)
    mrtsVRT=[];
end


%% mrtsA
% N=rt(A2A & MRTS);
% mrtsA=mean(nonzeros(N));
% mrtsANo=length(nonzeros(N));

stat=nonzeros(rt(A2A & MRTS));
mrtsANo=length(stat);
if mrtsANo>2
stat = bootstrp(iteration, @mean, stat);
end
mrtsART=mean(stat);
 
if isnan(mrtsART)
    mrtsART=[];
end

%% cmtrV
% N=rt(A2V & CMTR);
% cmtrV=mean(nonzeros(N));
% cmtrVNo=length(nonzeros(N));
stat=nonzeros(rt(A2V & CMTR));
cmtrVNo=length(stat);
if cmtrVNo>2
stat = bootstrp(iteration, @mean, stat);
end
cmtrVRT=mean(stat);
 
if isnan(cmtrVRT)
    cmtrVRT=[];
end


%% cmtrA
% N=rt(V2A & CMTR);
% cmtrA=mean(nonzeros(N));
% cmtrANo=length(nonzeros(N));

stat=nonzeros(rt(V2A & CMTR));
cmtrANo=length(stat);
if cmtrANo>2
stat = bootstrp(iteration, @mean, stat);
end
cmtrART=mean(stat);
 
if isnan(cmtrART)
    cmtrART=[];
end


%% cmtsV
% N=rt(A2V & CMTS);
% cmtsV=mean(nonzeros(N));
% cmtsVNo=length(nonzeros(N));
stat=nonzeros(rt(A2V & CMTS));
cmtsVNo=length(stat);
if cmtsVNo>2
stat = bootstrp(iteration, @mean, stat);
end
cmtsVRT=mean(stat);
 
if isnan(cmtsVRT)
    cmtsVRT=[];
end

%% cmtsA
% N=rt(V2A & CMTS);
% cmtsA=mean(nonzeros(N));
% cmtsANo=length(nonzeros(N));

stat=nonzeros(rt(V2A & CMTS));
cmtsANo=length(stat);
if cmtsANo>2
stat = bootstrp(iteration, @mean, stat);
end
cmtsART=mean(stat);
 
if isnan(cmtsART)
    cmtsART=[];
end

%% trVSingle
% N=rt(VSingle & TS==0);
% VSingleRT=mean(nonzeros(N));
% VSingleNo=length(nonzeros(N));

stat=nonzeros(rt(VSingle & TS==0));
trVsingleNo=length(stat);
if trVsingleNo>2
stat = bootstrp(iteration, @mean, stat);
end
trVsingleRT=mean(stat);
 
if isnan(trVsingleRT)
    trVsingleRT=[];
end

%% trASingle
% N=rt(ASingle & TS==0);
% ASingleRT=mean(nonzeros(N));
% ASingleNo=length(nonzeros(N));

stat=nonzeros(rt(ASingle & TS==0));
trAsingleNo=length(stat);
if trAsingleNo>2
stat = bootstrp(iteration, @mean, stat);
end
trAsingleRT=mean(stat);
 
if isnan(trAsingleRT)
    trAsingleRT=[];
end