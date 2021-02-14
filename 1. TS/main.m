close all;
clear all;
sca;


[id,name] = GetKeyboardIndices;
device=max(id);
PsychDefaultSetup(2);
AssertOpenGL;

%% get demog
ID = input('Enter Participant ID- ', 's');
age = input('Enter age group(4, 6, adult): ','s');
dob = input('Enter DOB (DD/MM/YYYY) ','s');
gender = input('Enter gender (m/f) ','s' );
version = input('Enter Task version (1 or 2)');

%% Main Var
ppath=cd; %change the path to the file directory
results = {'age', 'dob', 'gender', 'version', 'counter', 'block', 'trial', 'rule',  'target', 'Right', 'Left', 'rt', 'right answer', 'hit', 'no hits'};
trialNo=4;
stimuliTime= 4;
cueTime= 3;
CSI=1;
incorrectTime=2.5;
correctTime=1;
S(1).targetAppearance=24;
S(1).distractorAppearance=16;
S(2).targetAppearance=0;
S(2).distractorAppearance=40;
S(3).targetAppearance=48;
S(3).distractorAppearance=32;
% S(4).targetAppearance=40;
% S(4).distractorAppearance=40;
% S(4).targetAppearance=0;
% S(4).distractorAppearance=80;
%% prepare presentation sequence

if version==1
    b1=1:10; % car first dog second
    b2=11:20;
    xCue=[1,2];
else
    b1=11:20; % dog first car second
    b2=1:10;
    xCue=[2,1];
end

%% build image sequence for block 1, 2 & 3
[block(1).Name, block(1).Sequence]=TS_presentation(ppath, b1, S(1));
[stimuli(1).Name, stimuli(1).Sequence]=TS_presentation(ppath, [], S(2)); 
[block(2).Name, block(2).Sequence]=TS_presentation(ppath, b2, S(1));
[stimuli(2).Name, stimuli(2).Sequence]=TS_presentation(ppath, [], S(2)); 
[block(3).Name, block(3).Sequence ] = block3_presentation(ppath, S(3));
[stimuli(3).Name, sequence1]=block3_presentation(ppath, S(3));
%[stimuli(3).Name, sequence1]=block3_distractor(ppath, S(4));%used for non-target 2nd image for dual display
k=[1:2:19];
g=[2:2:20];
stimuli(3).Sequence=zeros(4,20);
stimuli(3).Sequence(:,g)=sequence1(:,k);
stimuli(3).Sequence(:,k)=sequence1(:,g);
cueName=dir([ppath, '/Stimuli/Cue/*.jpg']);
cueName={cueName.name};
motivationName=dir([ppath, '/Stimuli/Motivation/*.jpg']);
motivationName={motivationName.name};
Ding=([ppath, '/Stimuli/ding.wav']);

%% -------------------- REMOVE -------------------- 
% Screen('Preference', 'SkipSyncTests', 1);
% ------------------------------------------------
Screen('Preference','SyncTestSettings', 0.01, 100);
screens = Screen('Screens');
screenNumber = max(screens);
white = WhiteIndex(screenNumber);
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

Priority(1);
HideCursor;
Iteration;

write_results(results, ID);

sca;