function [ allName, Sequence ] = TS_presentation(ppath, t, S, condition )
% 6 targets after cues (out of 10)
% 18 targets in the repetition sites (out of 30 sites)


if isequal(condition, [1,1])    % counter balancing the target/distractors
    output='Visual/';
    folder1='Condition1';
    folder2='Condition2';
    append='/*.jpg';
elseif isequal(condition, [1,2])
    output='Visual/';
    folder1='Condition2';
    folder2='Condition1';
    append='/*.jpg';
elseif isequal(condition, [2,1])
    output='Sound/';
    folder1='Condition1';
    folder2='Condition2';
    append='/*.wav';
else 
    output='Sound/';
    folder1='Condition2';
    folder2='Condition1';
    append='/*.wav';
end

targetAppearance=S.targetAppearance;
% k=rem(targetAppearance,4);
% targetAppearance2=targetAppearance+k;
distractorAppearance=S.distractorAppearance;
targetLocation=dir([ppath, '/Stimuli/', output, folder1, append]);
distractorLocation=dir([ppath, '/Stimuli/', output, folder2, append]);

targetName={targetLocation.name};
distractorName={distractorLocation.name};
N=(targetAppearance+distractorAppearance)/4; % the number of cue occurances
cueTarget=round(targetAppearance/2/2);

allName=[targetName(t),distractorName];
targetPresLocation=datasample(1:10, targetAppearance, 'Replace',true);
distractorPresLocation=datasample(11:length(allName), distractorAppearance, 'Replace', true);
    for i=1:N
        if i<cueTarget+1 % 3 visual or auditory targets appearing at P1 location
            Sequence(1,i)=targetPresLocation(i);
        else
            Sequence(1,i)=distractorPresLocation(i-cueTarget);
        end
    end

remainPresentation=[targetPresLocation((cueTarget+1):end), distractorPresLocation((i-cueTarget+1):end)];
remainPresentation=Shuffle(remainPresentation);
Sequence(2:4,:)=reshape(remainPresentation, [3,N]);


end


