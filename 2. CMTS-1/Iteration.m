counter=1;

frameRect=CenterRectOnPointd([0 0 600 400], xCenter, yCenter);
[waterhandle]=play_Ding(water, 0.43);
y=1;

for cblock = 4:4
    
    stimulusIndex=cblock;
    Screen ('TextSize',window,30);
    Screen('TextFont',window, 'Arial');
    
    if cblock == 1
        Screen('FillRect', window, grey);
        motivImage=strcat(ppath, '/Stimuli/Motivation/', motivationName(1)); 
        themotivImage = imread(cell2mat(motivImage));
        themotivImage=imresize(themotivImage,1.5);
        imageTexture = Screen('MakeTexture', window, themotivImage);
        Screen('DrawTexture', window, imageTexture, [], [], 0);
        Screen('Flip', window); 
        KbStrokeWait(device);
        PsychPortAudio('Start', waterhandle, 0, 0, []);

    end

    Screen('FillRect', window, grey);
    Screen('FillRect', window, white, frameRect);
    DrawFormattedText(window, '+',  'center', 'center', black);
    Screen('Flip', window);
    WaitSecs('YieldSecs', 1);

    
    if cblock<3
        n=1:size(BA(cblock).Sequence,2);
    elseif cblock==3
        n=repmat(1:size(BA(cblock).Sequence,2),1,2);
        n=sort(n);
        n=n(1:length(n)/2);
    else
        n=repmat(1:size(BA(cblock).Sequence,2),1,2);
        n=sort(n);
        n=n(length(n)/2:length(n));
    end
    
   
    
for j=1:length(n)
    cue=n(j);
    
    
    if j==8
        motivImage=strcat(ppath, '/Stimuli/Motivation/', motivationName(5+y)); 
        themotivImage = imread(cell2mat(motivImage));
        themotivImage=imresize(themotivImage,1.5);
        imageTexture = Screen('MakeTexture', window, themotivImage);
        Screen('DrawTexture', window, imageTexture, [], [], 0);
        Screen('Flip', window);
        KbStrokeWait(device);
        y=y+1;
    end
        
    if cblock<3
        x=xCue(cblock);
        cueLocation=strcat(ppath, '/Stimuli/Visual/', cueFolder, '/', cueName(x));    
        cueSLocation=strcat(ppath, '/Stimuli/Sound/', cueFolder, '/', cueSound(x));
        cueSLocation=cell2mat(cueSLocation);
        [cuehandle]=play_Ding(cueSLocation, 0.9);
    else
        x=rem(j,2); % indexing which cue to use, x value either 1 or 2
        if x==0
            x=x+2;
        end
        cueLocation=strcat(ppath, '/Stimuli/Visual/', cueFolder, '/', cueName(x));
        cueSLocation=strcat(ppath, '/Stimuli/Sound/', cueFolder, '/', cueSound(x));
        cueSLocation=cell2mat(cueSLocation);
        [cuehandle]=play_Ding(cueSLocation, 0.7);
        stimulusIndex=x+2;
    end
    
    
    [theCue, ~, alpha]= imread(cell2mat(cueLocation));
    theCue(:,:,4)=alpha(:,:);
    theCue2=imresize(theCue,1.5);
    cueTexture = Screen('MakeTexture', window, theCue);
    cueTexture2 = Screen('MakeTexture', window, theCue2);
    Screen('Fillrect',window, white, frameRect);
    Screen('DrawTexture', window, cueTexture2, [],[], 0);
    PsychPortAudio('Start', cuehandle, 1, 0, []);
    Screen('Flip', window); 
    WaitSecs('YieldSecs', cueTime);
    Screen('Fillrect',window, white, frameRect);
    DrawFormattedText(window, '+',  'center', 'center', black);
    Screen('Flip', window);
    PsychPortAudio('Stop', cuehandle);
    WaitSecs('YieldSecs', CSI); 
    
    
    
    for ntrial=1:4
        V=BV(stimulusIndex).Sequence(ntrial,cue); % visual element
        A=BA(stimulusIndex).Sequence(ntrial,cue); % Auditory element
        
        if (V<21 && V>10) & (A<21 && A>10)
            A=A+10;
            BA(stimulusIndex).Sequence(ntrial,cue)=A;
        elseif (V<31 && V>20) & (A<31 && A>20)
            A=A-10;
            BA(stimulusIndex).Sequence(ntrial,cue)=A;
        else
        end

        V_element=BV(stimulusIndex).Name(V); % Visual file name
        A_element=BA(stimulusIndex).Name(A); % Auditory file name
        

        if isempty(cell2mat(strfind(V_element, cell2mat(target(1)) ))) && isempty(cell2mat(strfind(V_element, cell2mat(target(2)) ))) ; % if the read image in location 1 is not from target set
            imageLocation = strcat(ppath, '/Stimuli/Visual/', disFolder, '/', V_element);
        else
            imageLocation = strcat(ppath, '/Stimuli/Visual/', tarFolder, '/', V_element);
        end

        if isempty(cell2mat(strfind(A_element, cell2mat(target(1)) ))) && isempty(cell2mat(strfind(A_element, cell2mat(target(2)) ))) ; % if the read image in location 1 is not from target set
            audioLocation = strcat(ppath, '/Stimuli/Sound/', disFolder, '/', A_element);
        else
            audioLocation = strcat(ppath, '/Stimuli/Sound/', tarFolder, '/', A_element);
        end
        
        audioLocation=cell2mat(audioLocation);
        
        theImage = imread(cell2mat(imageLocation));
        theImage=imresize(theImage,1.5);
        imageTexture = Screen('MakeTexture', window, theImage);
        cueRect=CenterRectOnPointd([0 0 170 140], xCenter, screenYpixels/2-330);
        Screen('Fillrect',window, white, frameRect);
        %Screen('FrameRect',window, [0 0 0],frameRect,3);
        Screen('DrawTexture', window, cueTexture, [], cueRect, 0);
        Screen('DrawTexture', window, imageTexture, [], [], 0);
        
        answer = 1;       % valid(1) or invalid(0) answer
        hit = 0;
        targetchannel=0;
        takingTime = true;
        tEnd = 0;
        [~,NAME,~] = fileparts(cell2mat(cueName(x)));
        
        if ~isempty(cell2mat(strfind(V_element, NAME))) || ~isempty(cell2mat(strfind(A_element, NAME)))
            targetpresent=1;
        else
            targetpresent=0;
        end
        
        dinghandle=play_Ding(audioLocation, 0.7);
        PsychPortAudio('Start', dinghandle, 1, 0, []);
        tStart =  Screen('Flip', window);      
        Screen('FillRect', window, white, frameRect);
        DrawFormattedText(window, '+',  'center', 'center', black);
        takingTime = true;
        tEnd = 0;
        kdown = false;

        while true
            
            
            [keyIsDown, secs, keyCode] = KbCheck(device);
            [~,~,buttons,~,valuators,~] = GetMouse(screenNumber);
            %[clicks,~, ~, whichbuttons] = GetClicks(screenNumber, 0);
            
            ctime = GetSecs - tStart;     % is current time after stimulus presentation
            
            if ctime >= stimuliTime-0.2
                takingTime = false;
                if hit == 0 && ~isempty(cell2mat(strfind(V_element, NAME))) && isempty(cell2mat(strfind(A_element, NAME))) %if is target but no key pressed
                   answer=0;
                   WaitSecs(0.2);
                   targetchannel=1;
                elseif hit == 0 && ~isempty(cell2mat(strfind(A_element, NAME))) && isempty(cell2mat(strfind(V_element, NAME)))
                   answer=0;
                   WaitSecs(0.2);
                   targetchannel=2;
                elseif hit==0 && ~isempty(cell2mat(strfind(A_element, NAME))) && ~isempty(cell2mat(strfind(V_element, NAME)))
                   answer=0;
                   WaitSecs(0.2);
                   targetchannel=3;
                end

                PsychPortAudio('Stop', dinghandle);
                break;
            end
            
            if keyCode(escapeKey)
                ShowCursor;
                sca;
                PsychPortAudio('Stop', dinghandle);
                PsychPortAudio('Stop', waterhandle);
                PsychPortAudio('Stop', cuehandle);
                return
            elseif any(buttons) && hit==0 %keyCode(spaceBar) && hit==0
                tEnd = secs;
                if takingTime
                    if ~isempty(cell2mat(strfind(V_element, NAME))) && isempty(cell2mat(strfind(A_element, NAME))) % if target is present and key pressed
                        answer = 1;
                        targetchannel=1;
                    elseif ~isempty(cell2mat(strfind(A_element, NAME))) && isempty(cell2mat(strfind(V_element, NAME)))
                        answer = 1;
                        targetchannel=2;
                    elseif ~isempty(cell2mat(strfind(V_element, NAME))) && ~isempty(cell2mat(strfind(A_element, NAME)))
                        answer = 1;
                        targetchannel=3;
                    else
                        answer = 0;% if target is not present and key pressed
                    end
                    takingTime = false;
                end
                hit = 1;
                PsychPortAudio('Stop', dinghandle);
                break                 
            end
            WaitSecs(0.01);
        end 
        
        if tEnd > 0
            rt = tEnd - tStart;
        else
            rt = 0;
        end
        
        Screen('Flip', window);
        
        if answer==0,
            wtime=incorrectTime;
        else
            wtime=correctTime;
        end
        
        t=GetSecs+wtime;
        hits=hit;

        
        while GetSecs < t
         [~,~,buttons,~,valuators,~] = GetMouse(screenNumber);
        %[keyIsDown, secs, keyCode] = KbCheck(device);
         	
            if ~any(buttons) %~keyIsDown
            kdown = false;
            end
        
            if any(buttons) && kdown==false %keyCode(spaceBar) && kdown==false
            hits=hits+1;
            kdown=true;
            end
        end
        
        if hits>0
               hits=hits-1;   
        end

        results((counter + 1),:) = {age, dob, gender, today, targetset, version, counter, cblock, ntrial, cueName(x), targetpresent, targetchannel, V_element, A_element, rt, answer, hit, hits};
        counter=counter+1;

    end % end of 4 trials

end % end of cue set
        motivImage=strcat(ppath, '/Stimuli/Motivation/', motivationName(cblock+1)); 
        themotivImage = imread(cell2mat(motivImage));
        themotivImage=imresize(themotivImage,1.5);
        imageTexture = Screen('MakeTexture', window, themotivImage);
        Screen('DrawTexture', window, imageTexture, [], [], 0);
        Screen('Flip', window);
        KbStrokeWait(device);


end % end of block

PsychPortAudio('Close', dinghandle);
PsychPortAudio('Stop', waterhandle);
PsychPortAudio('Close', waterhandle);
PsychPortAudio('Close', cuehandle);