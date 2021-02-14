function [ allName, Sequence ] = block3_presentation(ppath, S )
% 12 no. of targets at switch sites (out of 20 switch sites)
% remaining 36 targets at repetition sites (out of 60 repetition sites).
targetAppearance=S.targetAppearance;
distractorAppearance=S.distractorAppearance;
targetLocation=dir([ppath, '/Stimuli/Target/*.jpg']);
distractorLocation=dir([ppath, '/Stimuli/Distractor/*.jpg']);
targetName={targetLocation.name};
distractorName={distractorLocation.name};

allName=[targetName,distractorName];
T1Location=datasample(1:10, targetAppearance/2, 'Replace',true); % car target, 24 target presentations
T2Location=datasample(11:20, targetAppearance/2, 'Replace',true); % dog target, 24 target presentations
distractorPresLocation=datasample(21:40, distractorAppearance, 'Replace',true);

for i=1:20
    if i<7
        Location(1,i)=T1Location(i);
    elseif i>6 && i<11
        Location(1,i)=distractorPresLocation(i-6);
    elseif i>10 && i<17
        Location(1,i)=T2Location(i-10);
    else
        Location(1,i)=distractorPresLocation(i-12);
    end
end
g=i-12;
T1remainPresentation=[T1Location((6+1):end), distractorPresLocation(g+1:(end-g)/2+g)]; % car target not at switch site, total 18
T1remainPresentation=Shuffle(T1remainPresentation);
T2remainPresentation=[T2Location((6+1):end), distractorPresLocation((end-g)/2+g+1:end)]; % dog target not at switch site, total 18
T2remainPresentation=Shuffle(T2remainPresentation);
k=randperm(10);
Location(2:4,1:10)=reshape(T1remainPresentation, [3,10]);
Location(:,1:10)=Location(:,k); % 1 to 10 columns for car trials
k=randperm(10)+10;
Location(2:4,11:20)=reshape(T2remainPresentation, [3,10]);
Location(:,11:20)=Location(:,k); % 11 to 20 columns for car trials
T1=[1:2:19];
T2=[2:2:20];
Sequence=nan(4,10);
Sequence(:,T2)=Location(:,11:20);
Sequence(:,T1)=Location(:,1:10);


end

