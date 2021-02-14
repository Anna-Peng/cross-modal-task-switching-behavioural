counter=1;
play_Ding(Ding, 0);

for cblock = 1:3
    
    
    Screen('FillRect', window, white);
    Screen ('TextSize',window,30);
    Screen('TextFont',window, 'Arial');
    Screen('Flip', window);
    WaitSecs(1);
    
    if cblock == 1
        DrawFormattedText(window, 'Press Any Key To Begin', 'center', 'center', black);
        Screen('Flip', window);        
        KbStrokeWait(device);
        Screen('FillRect', window, white);
        DrawFormattedText(window, '+',  'center', 'center', black);
        Screen('Flip', window);
        WaitSecs('YieldSecs', 1);
    end
    
    if cblock==1 || cblock==2
        n=10;
    else
        n=20;
    end
    
   
    
for cue=1:n
    if cblock==3
    x=rem(cue,2);
        if x==0
            x=x+2;
        end
    cueLocation=strcat(ppath, '/Stimuli/Cue/', cueName(x));
    cueLocation2=strcat(ppath, '/Stimuli/Cue2/', cueName(x));
    
        if cue==11
            breakImage=strcat(ppath, '/Stimuli/Motivation/', motivationName(cblock+1)); 
            thebreakImage = imread(cell2mat(breakImage));
            imageTexture = Screen('MakeTexture', window, thebreakImage);
            Screen('DrawTexture', window, imageTexture, [], [], 0);
            Screen('Flip', window);
            KbStrokeWait(device);
            Screen('FillRect', window, white);
            Screen('Flip', window);
            WaitSecs('YieldSecs', 1);
        end
    
    else
    x=xCue(cblock);
    cueLocation=strcat(ppath, '/Stimuli/Cue/', cueName(x));    
    cueLocation2=strcat(ppath, '/Stimuli/Cue2/', cueName(x));    
    end
    
    theCue= imread(cell2mat(cueLocation));
    cueTexture = Screen('MakeTexture', window, theCue); 
    Screen('DrawTexture', window, cueTexture, [],[], 0);
    Screen('Flip', window); 
    WaitSecs('YieldSecs', cueTime); 
    Screen('FillRect', window, white);
    DrawFormattedText(window, '+',  'center', 'center', black);
    Screen('Flip', window);  
    WaitSecs('YieldSecs', CSI); 
    
    
    for ntrial=1:4
        k=block(cblock).Sequence(ntrial,cue);
        g=stimuli(cblock).Sequence(ntrial,cue);
        element_d=stimuli(cblock).Name(g); % element at location 2 (distractors only)
        element=block(cblock).Name(k); % element at location 1 (can be target or non-target)
        while isequal(element_d, element) % if the elements at location 2 and location 1 are the same (ie. two identical cats)
            if cblock==1 || cblock==2
            a=1:length(stimuli(cblock).Name); 
            a(g)=[]; % take the identical element out from the non-target set)
            g=a(randperm(length(a),1)); % replace the element_d with another randomly selected set excluding the identical element)
            element_d=stimuli(cblock).Name(g);
            else
            a=1:length(stimuli(cblock).Name); 
            if k<11
                a(1:10)=[];
                if g>10
                    a(g-10)=[];
                end
            elseif k>10 && k<21
                a(11:20)=[];
                if g<10
                    a(g)=[];
                elseif g>20
                    a(g-20)=[];
                end
            end
            % take the identical element out from the non-target set)
            g=a(randperm(length(a),1)); % replace the element_d with another randomly selected set excluding the identical element)
            element_d=stimuli(cblock).Name(g);
            end
        end % target image name 

        if isempty(cell2mat(strfind(element, 'car'))) && isempty(cell2mat(strfind(element, 'dog'))) ; % if the read image in location 1 is not from target set
            imageLocation = strcat(ppath, '/Stimuli/Distractor/', element);
        else
            imageLocation = strcat(ppath, '/Stimuli/Target/', element);
        end

        if isempty(cell2mat(strfind(element_d, 'car'))) && isempty(cell2mat(strfind(element_d, 'dog'))) ; % if the read image is from target set
            distractorLocation = strcat(ppath, '/Stimuli/Distractor/', element_d);
        else
            distractorLocation = strcat(ppath, '/Stimuli/Target/', element_d);
        end

        %distractorLocation=strcat(ppath, '/Distractor/', element_d);
        theDistractor=imread(cell2mat(distractorLocation));
        theImage = imread(cell2mat(imageLocation));
        imageTexture = Screen('MakeTexture', window, theImage);
        distractorTexture = Screen('MakeTexture', window, theDistractor);
        theCue2= imread(cell2mat(cueLocation2));
        cueTexture2 = Screen('MakeTexture', window, theCue2); 
        stimulusRect = [0 0 198 170]; % this is an area smaller than the full screen in which to present stimuli
        cueRect=CenterRectOnPointd([0 0 170 140], xCenter, screenYpixels/2-270);
        BackRect(1,:) = CenterRectOnPointd(stimulusRect, screenXpixels/2-110, yCenter); % Left
        BackRect(2,:) = CenterRectOnPointd(stimulusRect, screenXpixels/2+110, yCenter); % Right
        h=randperm(2);
        frameRect=CenterRectOnPointd([0 0 460 230], xCenter, yCenter);
        Screen('FrameRect',window, [0 0 0],frameRect,2);
        Screen('DrawTexture', window, cueTexture2, [], cueRect, 0);
        Screen('DrawTexture', window, imageTexture, [], BackRect(h(1),:), 0); %stimulusRect, leftBackRect, 0);
        Screen('DrawTexture', window, distractorTexture, [], BackRect(h(2),:), 0);
       
        if h(1)==1
            Left=element;
            Right =element_d;
        else
            Left=element_d;
            Right=element;
        end
        
        %% Initialising key press and RT recording
        
        answer = 1;       % valid(1) or invalid(0) answer
        hit = 0;
       
        takingTime = true; % whether to record RT or not (in my experiment if there is no target present I do not record RT)
        tEnd = 0; % reset time to zero after each trial
        kdown = false; % before any key is pressed
        [~,NAME,~] = fileparts(cell2mat(cueName(x)));
        
        if ~isempty(cell2mat(strfind(element, NAME)))
            target=1;
        else
            target=0;
        end
        
        tStart =  Screen('Flip', window); % trial starting time
        Screen('FillRect', window, white);
        DrawFormattedText(window, '+',  'center', 'center', black);

        %% Checking key press
        
        while true 
            
            [keyIsDown, secs, keyCode] = KbCheck(device);
            
            ctime = GetSecs - tStart;     % is current time after stimulus presentation
            
            % Time out trials
            if ctime >= stimuliTime-0.3 % my exclusion is set at <300ms, Simulus time=4sec
                takingTime = false;
                if hit == 0 && ~isempty(cell2mat(strfind(element, NAME))) %if there is target but no key pressed
                   answer=0;
                   WaitSecs(0.3); 
                else
                    play_Ding(Ding,0.7) % else it is correct
                end 
                break; % break while loop
            end
            
            % escape experiment
            if keyCode(escapeKey)
                ShowCursor;
                sca;
                return % escape the experiment
            elseif keyCode(spaceBar) && hit==0 % spacebar is my experimental button
                tEnd = secs; % secs is the time at key press
                if takingTime
                    if ~isempty(cell2mat(strfind(element, NAME))) % if target is present and key pressed
                        play_Ding(Ding, 0.7);
                        answer = 1;
                    else
                        answer = 0; % if target is not present and key pressed
                    
                    end
                    takingTime = false;
                end
                hit = 1;
                break                 
            end
            WaitSecs(0.01);
        end 
        
        if tEnd > 0
            rt = tEnd - tStart; % calculate rt
        else
            rt = 0;
        end
        Screen('Flip', window); 
        
        if answer==0,
            wtime=incorrectTime; % I have different Response-Stimulus interval depending on whether the response was correct (correct RSI=1000ms, incorrect RSI=2500ms)
        else
            wtime=correctTime;
        end
        
        t=GetSecs+wtime; % t is the onset for the next trial
        hits=hit;

        
        while GetSecs < t % check if the participant was pressing the buttom during RSI and how many times (this is sanitary check to make sure they are not pressing randomly when there is no stimulus)
        [keyIsDown, secs, keyCode] = KbCheck(device);
         	
            if ~keyIsDown
            kdown = false; 
            end
        
            if keyCode(spaceBar) && kdown==false
            hits=hits+1;
            kdown=true;
            end
        end

        results((counter + 1),:) = {age, dob, gender, version, counter, cblock, ntrial, cueName(x), target, Right, Left, rt, answer, hit, hits};
        counter=counter+1;

    end

end % end of cue set
        motivImage=strcat(ppath, '/Stimuli/Motivation/', motivationName(cblock)); 
        themotivImage = imread(cell2mat(motivImage));
        imageTexture = Screen('MakeTexture', window, themotivImage);
        Screen('DrawTexture', window, imageTexture, [], [], 0);
        Screen('Flip', window);
        KbStrokeWait(device);
        Screen('FillRect', window, white);
        Screen('Flip', window);
        WaitSecs('YieldSecs', 1);

end % end of block

