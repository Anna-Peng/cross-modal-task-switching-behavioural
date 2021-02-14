        takingTime = true;
        tEnd = 0;
        kdown = false;
        hit=0;
        while true
            
            
            [keyIsDown, secs, keyCode] = KbCheck(device);
            [~,~,buttons,~,valuators,~] = GetMouse(screenNumber);
            %[clicks,~, ~, whichbuttons] = GetClicks(screenNumber, 0);
            
            ctime = GetSecs - tStart;     % is current time after stimulus presentation
            
            if ctime >= stimuliTime-0.2
                takingTime = false;
                if hit == 0 && targetpresence==1
                   answer=0;
                   WaitSecs(0.2);
                elseif hit == 0 && targetpresence==0
                   answer=1;
                   WaitSecs(0.2);
                end
                
                if dinghandle==1
                    PsychPortAudio('Stop', dinghandle);
                    PsychPortAudio('Close', dinghandle);
                end
                
                break;
            end
            
            if keyCode(escapeKey)
                ShowCursor;
                sca;
                PsychPortAudio('Stop', dinghandle);
                PsychPortAudio('Stop', waterhandle);
                return
            elseif keyCode(spaceBar) && hit==0
                tEnd = secs;
                if takingTime
                    if targetpresence==1
                        answer = 1;
                    else
                        answer = 0;% if target is not present and key pressed
                    end
                    takingTime = false;
                end
                hit = 1;
                if dinghandle==1
                    PsychPortAudio('Stop', dinghandle);
                    PsychPortAudio('Close', dinghandle);
                end
                
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
%          [~,~,buttons,~,valuators,~] = GetMouse(screenNumber);
        [keyIsDown, secs, keyCode] = KbCheck(device);
         	
            if ~keyIsDown
            kdown = false;
            end
        
            if keyCode(spaceBar) && kdown==false
            hits=hits+1;
            kdown=true;
            end
        end
        
        if hits>0
               hits=hits-1;   
        end
        counter=counter+1;

