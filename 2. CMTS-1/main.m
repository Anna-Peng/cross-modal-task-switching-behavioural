close all;
clear all;
sca;


[id,name] = GetKeyboardIndices;
device=max(id);
PsychDefaultSetup(2);
AssertOpenGL;
 
%% get demog
ID = input('Enter Participant ID- ', 's');
age = input('Enter age group(4, 6, A): ','s');
dob = input('Enter DOB (DD-MMM-YYYY) ', 's');
gender = input('Enter gender (m/f) ','s' );
targetset = input('Enter Target Set (1=bird/dog or 2=cat/sheep)');
version = 1; % input('Enter Order version (1 or 2 for order counterbalance)');
today=datestr(datetime('today'));

if targetset==1
    condition=[1,1; 2,1]; % 1,1-->Visual,Condition1; 2,1-->Auditory,Condition1;  
    cueFolder='Cue1';
    tarFolder='Condition1';
    disFolder='Condition2';
    target={'bird','dog'}; % condition1-->target bird or dog;
else
    condition=[1,2; 2,2]; % 1,2-->Visual,Condition2; 2,2-->Auditory-Condition2 
    cueFolder='Cue2';
    tarFolder='Condition2';
    disFolder='Condition1';
    target={'cat','sheep'}; % condition2--> target sheep or cat
end

%% Main Var
ppath=cd; %change the path to the file directory
results = {'age', 'dob', 'gender', 'date','targetset', 'version','counter', 'block', 'trial', 'rule',  'target', 'targetchannel', 'Visual', 'Sound', 'rt', 'right answer', 'hit', 'no hits'};
% Block 1: 28 trials, Block 2: 28 trials, Block 3: 28 trials, Block 4: 28
% trials, Block
trialNo=4;
stimuliTime=4;
cueTime=3;
CSI=1;
incorrectTime=2.5;
correctTime=1;
congruent=5;
S(1).targetAppearance=20/2; % Total 28 trials in each pure block. Block 1 & 2: 16 targets/28 trials: 57% (13-oct amendment from 16 targets to 20 targets)
S(1).distractorAppearance=18; %(13-oct amendment from 20 to 18)
S(2).targetAppearance=40/2; % Total 56 trials in each 2 mixed blocks. Block 3 & 4: 34 targets/ 56 trials (65%)-->26 unimodal targets (50%), 10 bimodal targets(15%)
S(2).distractorAppearance=36; % 13-Oct amendment from 39 to 36

%% Pure block sequence

if version==1
    b1=1:10; % bird first dog second
    b2=11:20;
    xCue=[1,2];
else
    b1=11:20; % dog first bird second
    b2=1:10;
    xCue=[2,1];
end


%% build image sequence for block 1, 2 & 3

for j=1:4

    if j==2 || j==4
        t=b2;
    else
        t=b1;
    end

    if j==1 || j==2
        [BV(j).Name, BV(j).Sequence]=TS_presentation(ppath, t, S(1), condition(1,:),0);
        [BA(j).Name, BA(j).Sequence]=TS_presentation(ppath, t, S(1), condition(2,:),0);
    else
        [BV(j).Name, BV(j).Sequence]=TS_presentation(ppath, t, S(2), condition(1,:),1);
        [BA(j).Name, BA(j).Sequence]=TS_presentation(ppath, t, S(2), condition(2,:),1);
    end

    redo=1;
    
    while redo==1 % Check if target auditory and target visual are at diff positon index
        k1=randperm(size(BV(j).Sequence,2));
        BV(j).Sequence=BV(j).Sequence(:,k1);
        k2=randperm(size(BA(j).Sequence,2));
        BA(j).Sequence=BA(j).Sequence(:,k2);
        
        Sequence1=BV(j).Sequence<11; % visual target sequence
        Sequence2=BA(j).Sequence<11; % auditory target sequence
        Check=Sequence1+Sequence2; % check if visual and auditory are both from target sets: 1=only one modality, 0=no target, 2=both modalities
        g=find(Check==2);
        if j==1 || j==2
            if isempty(g) % for pure blocks there should be no congruent trial
                redo=0;
                targetcases(j)=sum(sum(Check));
            elseif length(g)<=3 
               for i=1:length(g)
                   if rem(g(i),2)==0
                       BV(j).Sequence(g(i))= BV(j).Sequence(g(i))+randperm(10,1)+10;
                   else
                       BA(j).Sequence(g(i))= BA(j).Sequence(g(i))+randperm(10,1)+10;
                   end
               targetcases(j)=sum(sum(Check));
               redo=0;
               end
            end
            
        else
            if length(g)==5; %(length(g)>= congruent -1) && (length(g)< congruent+2) % for mixed blocks there should be 'congruent' no. of congruent trials
                redo=0;
                congruentcases(j-2)=length(g);
                targetcases(j)=sum(sum(Check));
            end
        end

    end
    
    


end

targetcases
congruentcases

BA(3).Name(31:40)=BA(2).Name(1:10); %2
BA(4).Name(31:40)=BA(1).Name(1:10); %1
BV(3).Name(31:40)=BV(2).Name(1:10); %2
BV(4).Name(31:40)=BV(1).Name(1:10); %1

cueName=dir([ppath, '/Stimuli/Visual/', cueFolder, '/*.png']);
cueName={cueName.name};
cueSound=dir([ppath, '/Stimuli/Sound/', cueFolder, '/*.wav']);
cueSound={cueSound.name};
motivationName=dir([ppath, '/Stimuli/Motivation/*.jpg']);
motivationName={motivationName.name};
water=([ppath, '/Stimuli/Sound/water.wav']);

%% -------------------- REMOVE -------------------- 
% Screen('Preference', 'SkipSyncTests', 1);
% ------------------------------------------------
Screen('Preference','SyncTestSettings', 0.01, 100);
screens = Screen('Screens');
screenNumber = max(screens);
white = WhiteIndex(screenNumber);    
grey = [0.4,0.4,0.4];
black = BlackIndex(screenNumber);
% setting up the keys I will be using in the experiment
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