

% Visual accuracy
N=answer(targetchannel==1);
visAccu=mean(N);

% Auditory accuracy
N=answer(targetchannel==2);
audAccu=mean(N);

% CMTS accuracy CROSS-MODAL TASK-SWITCH
N=answer(CMTS);
cmtsAccu=mean(N);

% MRTR accuracy MODALITY-REPEAT TASK-REPEAT
N=answer(MRTR);
mrtrAccu=mean(N);

% CMTR accuracy CROSS-MODAL TASK-REPEAT
N=answer(CMTR);
cmtrAccu=mean(N);

% MRTS accuracy MODALITY-REPEAT TASK-SWITCH
N=answer(MRTS);
mrtsAccu=mean(N);

% V2V
N=answer(V2V);
v2vAccu=mean(N);

% V2A
N=answer(V2A);
v2aAccu=mean(N);

% A2A
N=answer(A2A);
a2aAccu=mean(N);

% A2V
N=answer(A2V);
a2vAccu=mean(N);

% VSingle
N=answer(VSingle);
VSingleAccu=mean(N);

% VSingle
N=answer(ASingle);
ASingleAccu=mean(N);