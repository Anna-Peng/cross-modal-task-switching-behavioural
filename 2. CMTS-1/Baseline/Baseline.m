close all;
clearvars -except ID age dob gender targetset today

[id,name] = GetKeyboardIndices;
device=max(id);
% PsychDefaultSetup(2);
% AssertOpenGL;
 
%% get demog
% ID = input('Enter Participant ID- ', 's');
% age = input('Enter age group(4, 6, adult): ','s');
% dob = input('Enter DOB (DD-MMM-YYYY) ', 's');
% gender = input('Enter gender (m/f) ','s' );
% targetset = input('Enter Target Set (1=bird/dog or 2=cat/sheep): ');
version = input('Enter modality order: ');
% today=datestr(datetime('today'));

%%

if targetset==1
    condition=[1,1; 2,1]; % Visual-Condition1; Auditory-Condition1; Visual-Condition2; Auditory-Condition2 (condition1-->target bird or dog; condition2--> target sheep or cat)
    cueFolder='Cue1';
    tarFolder='Condition1';
    disFolder='Condition2';
    target={'bird','dog'};
else
    condition=[1,2; 2,2];
    cueFolder='Cue2';
    tarFolder='Condition2';
    disFolder='Condition1';
    target={'cat','sheep'};
end

%% Main Var
ppath=cd; %change the path to the file directory
results = {'age', 'dob', 'gender', 'date', 'modality', 'targetset', 'counter', 'block', 'trial', 'rule',  'target', 'Visual', 'Sound', 'rt', 'right answer', 'hit', 'no hits'};

trialNo=4;
stimuliTime=4;
cueTime=3;
CSI=1;
incorrectTime=2.5;
correctTime=1;
S(1).targetAppearance=6;
S(1).distractorAppearance=6;
% S(2).targetAppearance=34/2;
% S(2).distractorAppearance=39;

%% prepare presentation sequence
    b1=1:10; % bird first dog second
    b2=11:20;
    xCue=[1,2];
    
if version==1
   order=[1,2];
else
    order=[2,1];
end
%% -------------------- REMOVE -------------------- 
% Screen('Preference', 'SkipSyncTests', 1);
% ------------------------------------------------
Screen('Preference','SyncTestSettings', 0.01, 100);
screens = Screen('Screens');
screenNumber = max(screens);
white = WhiteIndex(screenNumber);    
grey = [0.4,0.4,0.4];
black = BlackIndex(screenNumber);
escapeKey = KbName('ESCAPE');
spaceBar = KbName('space');
nblocks = 3;
%% Open an on screen window
%rect=[100, 100, 1200, 650];
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, white); %, rect);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

% Set up alpha-blending for smooth (anti-aliased) lines
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

%% run Main script
counter=1;
cueName=dir([ppath, '/Stimuli/Visual/', cueFolder, '/*.png']);
cueName={cueName.name};
cueSound=dir([ppath, '/Stimuli/Sound/', cueFolder, '/*.wav']);
cueSound={cueSound.name};
motivationName=dir([ppath, '/Stimuli/Motivation/*.jpg']);
motivationName={motivationName.name};
water=([ppath, '/Stimuli/Sound/water.wav']);
    
for k=1:2
    
    modality=(order(k));
    
    for j=1:2

        if j==2 
            t=b2;
        else
            t=b1;
        end

        if j==1 || j==2
            [BV(j).Name, BV(j).Sequence]=TS_presentation2(ppath, t, S(1), condition(1,:));
            [BA(j).Name, BA(j).Sequence]=TS_presentation2(ppath, t, S(1), condition(2,:));

        end

            k1=randperm(size(BV(j).Sequence,2));
            BV(j).Sequence=BV(j).Sequence(:,k1);
            k2=randperm(size(BA(j).Sequence,2));
            BA(j).Sequence=BA(j).Sequence(:,k2);

            Sequence1=BV(j).Sequence<11;
            Sequence2=BA(j).Sequence<11;  

    end
    Priority(1);
    HideCursor;
    Iteration2;
    
    if keyCode(escapeKey)
        return
    end

end

sca;
clearvars -except results ID;
write_results2(results, ID);
clear all;