%% Modality Switch Effect

stat=nonzeros(rt(V2A & P1));
P1V2A_no=length(stat);
if P1V2A_no>2
%stat = bootstrp(iteration, @mean, stat);
end
P1V2A_rt=mean(stat);

if isnan(P1V2A_rt)
    P1V2A_rt=[];
end


stat=nonzeros(rt(A2V & P1));
P1A2V_no=length(stat);
if P1A2V_no>2
%stat = bootstrp(iteration, @mean, stat);
end

P1A2V_rt=mean(stat);   
if isnan(P1A2V_rt)
    P1A2V_rt=[];
end
 
stat=nonzeros(rt(V2A & M1));
M1V2A_no=length(stat);
if M1V2A_no>2
%stat = bootstrp(iteration, @mean, stat);
end
M1V2A_rt=mean(stat);
if isnan(M1V2A_rt)
    M1V2A_rt=[];
end

stat=nonzeros(rt(A2V & M1));
M1A2V_no=length(stat);
if M1A2V_no>2
%stat = bootstrp(iteration, @mean, stat);
end
M1A2V_rt=mean(stat); 
if isnan(M1A2V_rt)
    M1A2V_rt=[];
end

%% Modality repetition effect: P_Vr, P_Ar & M_Vr, M_Ar 
    
stat=nonzeros(rt(V2V & P1));
P1V2V_no=length(stat);
if P1V2V_no>2
    %stat = bootstrp(iteration, @mean, stat);
end
P1V2V_rt=mean(stat);
if isnan(P1V2V_rt)
    P1V2V_rt=[];
end


stat=nonzeros(rt(A2A & P1));
P1A2A_no=length(stat);
if P1A2A_no>2
    %stat = bootstrp(iteration, @mean, stat);
end
P1A2A_rt=mean(stat);
if isnan(P1A2A_rt)
    P1A2A_rt=[];
end
    
stat=nonzeros(rt(V2V & M1));
M1V2V_no=length(stat);
if M1V2V_no>2
%stat = bootstrp(iteration, @mean, stat);
end
M1V2V_rt=mean(stat);
if isnan(M1V2V_rt)
    M1V2V_rt=[];
end


stat=nonzeros(rt(A2A & M1));
M1A2A_no=length(stat);
if M1A2A_no>2
%stat = bootstrp(iteration, @mean, stat);
end
M1A2A_rt=mean(stat);
if isnan(M1A2A_rt)
    M1A2A_rt=[];
end

%% Modality Single (no response previously) in P1 & M1 blocks
% P1 block
stat=nonzeros(rt(Vsingle & P1));
P1Vsing_no=length(stat);
if P1Vsing_no>2
%stat = bootstrp(iteration, @mean, stat);
end
P1Vsing_rt=mean(stat);
if isnan(P1Vsing_rt)
    P1Vsing_rt=[];
end

stat=nonzeros(rt(Asingle & P1));
P1Asing_no=length(stat);
if P1Asing_no>2
%stat = bootstrp(iteration, @mean, stat);
end
P1Asing_rt=mean(stat);
if isnan(P1Asing_rt)
    P1Asing_rt=[];
end

%M1 block
stat=nonzeros(rt(Vsingle & M1));
M1Vsing_no=length(stat);
if M1Vsing_no>2
%stat = bootstrp(iteration, @mean, stat);
end
M1Vsing_rt=mean(stat);
if isnan(M1Vsing_rt)
    M1Vsing_rt=[];
end

stat=nonzeros(rt(Asingle & M1));
M1Asing_no=length(stat);
if P1Asing_no>2
%stat = bootstrp(iteration, @mean, stat);
end
M1Asing_rt=mean(stat);
if isnan(M1Asing_rt)
    M1Asing_rt=[];
end
