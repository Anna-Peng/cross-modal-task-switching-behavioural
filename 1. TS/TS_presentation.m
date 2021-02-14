function [ allName, Sequence ] = TS_presentation(ppath, t, S )
% 6 targets after cues (out of 10)
% 18 targets in the repetition sites (out of 30 sites)
targetAppearance=S.targetAppearance;
distractorAppearance=S.distractorAppearance;
targetLocation=dir([ppath, '/Stimuli/Target/*.jpg']);
distractorLocation=dir([ppath, '/Stimuli/Distractor/*.jpg']);
targetName={targetLocation.name};
distractorName={distractorLocation.name};
N=(targetAppearance+distractorAppearance)/4;

if isempty(t)~=1
    allName=[targetName(t),distractorName];
    targetPresLocation=datasample(1:10, targetAppearance, 'Replace',true);
    distractorPresLocation=datasample(11:length(allName), distractorAppearance, 'Replace', true);
    for i=1:N
        if i<7
            Sequence(1,i)=targetPresLocation(i);
        else
            Sequence(1,i)=distractorPresLocation(i-6);
        end
    end

remainPresentation=[targetPresLocation((6+1):end), distractorPresLocation((i-6+1):end)];
remainPresentation=Shuffle(remainPresentation);
Sequence(2:4,:)=reshape(remainPresentation, [3,N]);
k=randperm(size(Sequence,2));
Sequence=Sequence(:,k);

else
allName=distractorName;
distractorPresLocation=datasample(1:length(allName), distractorAppearance, 'Replace', true);
distractorPresLocation=Shuffle(distractorPresLocation);
Sequence(1:4,:)=reshape(distractorPresLocation, [4,N]);
end

end

