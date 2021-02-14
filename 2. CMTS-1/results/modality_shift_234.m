%% Modality Switch Effect

stat=nonzeros(rt(V2A & P234));
PV2A_no=length(stat);
if PV2A_no>2
%stat = bootstrp(iteration, @mean, stat);
end
PV2A_rt=mean(stat);

if isnan(PV2A_rt)
    PV2A_rt=[];
end


stat=nonzeros(rt(A2V & P234));
PA2V_no=length(stat);
if PA2V_no>2
%stat = bootstrp(iteration, @mean, stat);
end

PA2V_rt=mean(stat);   
if isnan(PA2V_rt)
    PA2V_rt=[];
end
 
stat=nonzeros(rt(V2A & M234));
MV2A_no=length(stat);
if MV2A_no>2
%stat = bootstrp(iteration, @mean, stat);
end
MV2A_rt=mean(stat);
if isnan(MV2A_rt)
    MV2A_rt=[];
end

stat=nonzeros(rt(A2V & M234));
MA2V_no=length(stat);
if MA2V_no>2
%stat = bootstrp(iteration, @mean, stat);
end
MA2V_rt=mean(stat); 
if isnan(MA2V_rt)
    MA2V_rt=[];
end

%% Modality repetition effect: P_Vr, P_Ar & M_Vr, M_Ar 
    
stat=nonzeros(rt(V2V & P234));
PV2V_no=length(stat);
if PV2V_no>2
    %stat = bootstrp(iteration, @mean, stat);
end
PV2V_rt=mean(stat);
if isnan(PV2V_rt)
    PV2V_rt=[];
end


stat=nonzeros(rt(A2A & P234));
PA2A_no=length(stat);
if PA2A_no>2
    %stat = bootstrp(iteration, @mean, stat);
end
PA2A_rt=mean(stat);
if isnan(PA2A_rt)
    PA2A_rt=[];
end
    
stat=nonzeros(rt(V2V & M234));
MV2V_no=length(stat);
if MV2V_no>2
%stat = bootstrp(iteration, @mean, stat);
end
MV2V_rt=mean(stat);
if isnan(MV2V_rt)
    MV2V_rt=[];
end


stat=nonzeros(rt(A2A & M234));
MA2A_no=length(stat);
if MA2A_no>2
%stat = bootstrp(iteration, @mean, stat);
end
MA2A_rt=mean(stat);
if isnan(MA2A_rt)
    MA2A_rt=[];
end

%% Modality Single (no response previously) in P234 & M234 blocks
% P234 block
stat=nonzeros(rt(Vsingle & P234));
PVsing_no=length(stat);
if PVsing_no>2
%stat = bootstrp(iteration, @mean, stat);
end
PVsing_rt=mean(stat);
if isnan(PVsing_rt)
    PVsing_rt=[];
end

stat=nonzeros(rt(Asingle & P234));
PAsing_no=length(stat);
if PAsing_no>2
%stat = bootstrp(iteration, @mean, stat);
end
PAsing_rt=mean(stat);
if isnan(PAsing_rt)
    PAsing_rt=[];
end

%M234 block
stat=nonzeros(rt(Vsingle & M234));
MVsing_no=length(stat);
if MVsing_no>2
%stat = bootstrp(iteration, @mean, stat);
end
MVsing_rt=mean(stat);
if isnan(MVsing_rt)
    MVsing_rt=[];
end

stat=nonzeros(rt(Asingle & M234));
MAsing_no=length(stat);
if PAsing_no>2
%stat = bootstrp(iteration, @mean, stat);
end
MAsing_rt=mean(stat);
if isnan(MAsing_rt)
    MAsing_rt=[];
end

%% Modality switch/repetition/Single effect all blocks

stat=nonzeros(rt(V2V));
V2V_no=length(stat);
if V2V_no>2
%stat = bootstrp(iteration, @mean, stat);
end
V2V_rt=mean(stat);
if isnan(V2V_rt)
    V2V_rt=[];
end

stat=nonzeros(rt(A2A));
A2A_no=length(stat);
if A2A_no>2
%stat = bootstrp(iteration, @mean, stat);
end
A2A_rt=mean(stat);
if isnan(A2A_rt)
    A2A_rt=[];
end

stat=nonzeros(rt(V2A));
V2A_no=length(stat);
if V2A_no>2
%stat = bootstrp(iteration, @mean, stat);
end
V2A_rt=mean(stat);
if isnan(V2A_rt)
    V2A_rt=[];
end

stat=nonzeros(rt(A2V));
A2V_no=length(stat);
if A2V_no>2
%stat = bootstrp(iteration, @mean, stat);
end
A2V_rt=mean(stat);
if isnan(A2V_rt)
    A2V_rt=[];
end

stat=nonzeros(rt(Vsingle));
Vsing_no=length(stat);
if Vsing_no>2
%stat = bootstrp(iteration, @mean, stat);
end
Vsing_rt=mean(stat);
if isnan(Vsing_rt)
    Vsing_rt=[];
end

stat=nonzeros(rt(Vsingle));
Asing_no=length(stat);
if Asing_no>2
%stat = bootstrp(iteration, @mean, stat);
end
Asing_rt=mean(stat);
if isnan(Asing_rt)
    Asing_rt=[];
end
