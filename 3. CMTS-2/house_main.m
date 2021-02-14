close all;
clear all;
sca;
% 
% 
[id,name] = GetKeyboardIndices;
device=max(id);
PsychDefaultSetup(2);
AssertOpenGL;
 
%% get demog
ID = input('Enter Participant ID- ', 's');
age = input('Enter age group(4, 6, A): ','s');
dob = input('Enter DOB (DD-MMM-YYYY) ', 's');
gender = input('Enter gender (m/f) ','s' );
nTrial = 120; %input('No. of Trials: ');
nBreak= 5; %input ('No. of breaks: ');
today=datestr(datetime('today'));

% nTrial=100;
targetset = 1;
CSI = 1;
today=datestr(datetime('today'));
result(1,:)={'ID', ' Age', 'DOB', 'Gender', 'Date','TrialIndex', 'Cue', 'Modality', 'Trial', 'TargetExist', 'TargetName',...
    'TaskSwitch', 'ModalitySwitch', 'Correct', 'RT', 'noHits'};

for i=1:nBreak-1
    break_trial(i)=round(i*nTrial/nBreak);
end
break_trial=break_trial+1;

%% Main Var
ppath=cd; %change the path to the file directory
stimuliTime=4;
incorrectTime=2.5;
correctTime=1;

targetAppearance=round(nTrial*0.6); % 30 trials in each block and 60% target appearances
distractorAppearance=nTrial-targetAppearance;


%% build image sequence for block 1, 2 & 3
cue_sequence=[ones(1,nTrial/2)*2, ones(1,nTrial/2)*3]; % 2-Music, 3-Tree
cue_sequence=Shuffle(cue_sequence);
target_sequence=[randsample(1:10,targetAppearance,1), zeros(1, distractorAppearance)]; % 1-10 for target index, 0 for nontargets
% distractor_sequence=[zeros(1,targetAppearance), randsample(1:10,distractorAppearance,1)];
modality_sequence=randsample(0:1, nTrial, 1); % 0 and 1 sequence: 0-Aud, 1-Vis
trialSequence=[modality_sequence;target_sequence];
k=randperm(nTrial);
trialSequence=trialSequence(:,k);
allSequence=[cue_sequence; trialSequence];

cuePath=strcat(ppath, '/Stimuli/Cue/');
motivePath=strcat(ppath, '/Stimuli/Motivation/');
motiveName=dir(strcat(motivePath, '*.jpg'));
motiveName={motiveName.name};
musicPath=strcat(ppath, '/Stimuli/music hall/');
treePath=strcat(ppath, '/Stimuli/tree house/');

musicVName=dir(strcat(musicPath,'visual/', '*.png'));
musicAName=dir(strcat(musicPath,'sound/', '*.wav'));    
musicVName={musicVName.name};
musicAName={musicAName.name};


treeVName=dir(strcat(treePath,'visual/', '*.png'));
treeAName=dir(strcat(treePath,'sound/', '*.wav'));    
treeVName={treeVName.name};
treeAName={treeAName.name};


% %% -------------------- REMOVE -------------------- 
% % Screen('Preference', 'SkipSyncTests', 1);
% % ------------------------------------------------
[id,name] = GetKeyboardIndices;
device=max(id);
PsychDefaultSetup(2);
AssertOpenGL;

Screen('Preference','SyncTestSettings', 0.01, 100);
screens = Screen('Screens');
screenNumber = max(screens);
white = WhiteIndex(screenNumber);    
black = BlackIndex(screenNumber);

escapeKey = KbName('ESCAPE');
spaceBar = KbName('space');
%% Open an on screen window
%rect=[0, 0, 1000, 1000];
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, white);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);
Screen ('TextSize',window,30);
Screen('TextFont',window, 'Arial');
    
% Set up alpha-blending for smooth (anti-aliased) lines
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

Priority(1);
HideCursor;

%% Play background noise
water=strcat(cuePath,'water.wav');
[waterhandle]=play_Ding(water, 0.6);
%PsychPortAudio('Start', waterhandle, 0, 0, []);
% 
%% Trial begins
counter=0;
houserect=CenterRectOnPointd([0 0 900 900], xCenter, yCenter);
targetrect=CenterRectOnPointd([0 0 300 300], xCenter, yCenter+100);
cuerect=CenterRectOnPointd([0 0 170 150], xCenter, yCenter-220);

cueLoca=strcat(cuePath, 'house.png');
[houseImage, ~, alpha] = imread(cueLoca);
houseImage(:,:,4)=alpha(:,:);


cueLoca=strcat(cuePath, 'tree house.png');
[treeImage, ~, alpha] = imread(cueLoca);
treeImage(:,:,4)=alpha(:,:);

cueLoca=strcat(cuePath, 'music hall.png');
[musicImage, ~, alpha] = imread(cueLoca);
musicImage(:,:,4)=alpha(:,:);

task_swi=0;
mod_swi=0;
cue_record=[];
mod_record=[];
n=1; % motivation image sequence

    for i=1:nTrial
        dinghandle=0; 
        current_cue=allSequence(1,i);
        current_modality=allSequence(2,i);
        current_trial=allSequence(3,i);

        if current_cue==2
            cueimage=musicImage;
        else
            cueimage=treeImage;
        end

        switch current_cue
            case 2
                targetfolder=musicPath;
                distractfolder=treePath;
                cue='music';
            case 3
                targetfolder=treePath;
                distractfolder=musicPath;
                cue='tree';
        end

        switch current_modality
            case 0
                modality='sound/';
                distractor='visual/';
            case 1
                modality='visual/';
                distractor='sound/';
        end

        targetfolder2=strcat(targetfolder, modality);
        nontargetfolder2=strcat(distractfolder, modality);

        if current_modality==1
            appen='*.png';

        else
            appen='*.wav';
        end

        if current_trial~=0
                targetName=dir(strcat(targetfolder2,appen));
                targetName={targetName(current_trial).name};
                target=strcat(targetfolder2,targetName);
                targetpresence=1;

        else
                replace_trial=randperm(10,1);
                targetName=dir(strcat(nontargetfolder2, appen));
                targetName={targetName(replace_trial).name};
                target=strcat(nontargetfolder2,targetName);
                targetpresence=0;
        end % Switch Current Trial


        %% Present Stimuli
        if i == 1 || any(break_trial==i)
            Screen('FillRect', window, white);
            motivImage=strcat(motivePath, motiveName); 
            themotivImage = imread(cell2mat(motivImage(n)));
            themotivImage=imresize(themotivImage,1.5);
            imageTexture = Screen('MakeTexture', window, themotivImage);
            Screen('DrawTexture', window, imageTexture, [], [], 0);
            Screen('Flip', window); 
            KbStrokeWait(device);
            if i==1
                PsychPortAudio('Start', waterhandle, 0, 0, []);
            end
            WaitSecs('YieldSecs', 1);
            n=n+1;

        end

        Screen('FillRect', window, white);
        houseTexture = Screen('MakeTexture', window, houseImage);
        Screen('DrawTexture', window, houseTexture, [], houserect, 0);
        DrawFormattedText(window, '+',  'center', yCenter+100, black);
        Screen('Flip', window);
        WaitSecs('YieldSecs', 1);


        Screen('DrawTexture', window, houseTexture, [], houserect, 0);
        imageTexture = Screen('MakeTexture', window, cueimage);
        Screen('DrawTexture', window, imageTexture, [], cuerect, 0);

        if current_modality==1
            targetImage=imread(cell2mat(target));
            targetImage=imresize(targetImage,0.8);
            imageTexture = Screen('MakeTexture', window, targetImage);
            Screen('DrawTexture', window, imageTexture, [], targetrect, 0);
        else
            audioLocation=cell2mat(target);
            DrawFormattedText(window, '+',  'center', yCenter+100, black);
            dinghandle=play_Ding(audioLocation, 0.7);

        end

        if dinghandle==1 
           PsychPortAudio('Start', dinghandle, 1, 0, []);
        end   

        tStart=Screen('Flip', window);

        Screen('FillRect', window, white);
        Screen('DrawTexture', window, houseTexture, [], houserect, 0);
        DrawFormattedText(window, '+',  'center', yCenter+100, black);

        check_response

    %     if dinghandle==1
    %         PsychPortAudio('Stop', dinghandle);
    %         PsychPortAudio('Close', dinghandle);
    %     end

    % 
    if i>1
        if isequal(cue, cue_record) % cue name
            task_swi=0;
        else
            task_swi=1;
        end

        if isequal(current_modality, mod_record) %
            mod_swi=0;
        else
            mod_swi=1;
        end

    end

        result(i+1,:)={ID, age, dob, gender, today, counter, cue, current_modality, current_trial, targetpresence, targetName, task_swi, mod_swi, answer, rt, hits};

        cue_record=cue;
        mod_record=current_modality;
        
        if keyCode(escapeKey)
            break;
        end

    end %nTrial
    
if ~keyCode(escapeKey)
    Screen('FillRect', window, white);
    motivImage=strcat(motivePath, motiveName); 
    themotivImage = imread(cell2mat(motivImage(n)));
    themotivImage=imresize(themotivImage,1.5);
    imageTexture = Screen('MakeTexture', window, themotivImage);
    Screen('DrawTexture', window, imageTexture, [], [], 0);
    Screen('Flip', window); 
    KbStrokeWait(device);
    WaitSecs('YieldSecs', 1);
else
    
end

   
    PsychPortAudio('Stop', waterhandle);
    PsychPortAudio('Close', waterhandle);
    write_results(result, ID);

sca;