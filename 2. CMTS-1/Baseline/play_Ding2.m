function [dinghandle]=play_Ding(dingfile, volumn)

    % Read WAV file from filesystem:
    [y, freq] = audioread(dingfile);
    wavedata = y';
    nrchannels = size(wavedata,1); % Number of rows == number of channels.

% Make sure we have always 2 channels stereo output.
% Why? Because some low-end and embedded soundcards
% only support 2 channels, not 1 channel, and we want
% to be robust in our demos.
if nrchannels < 2
    wavedata = [wavedata ; wavedata];
    nrchannels = 2;
end

% Perform basic initialization of the sound driver:
InitializePsychSound;

% Open the default audio device [], with default mode [] (==Only playback),
% and a required latencyclass of zero 0 == no low-latency mode, as well as
% a frequency of freq and nrchannels sound channels.
% This returns a handle to the audio device:

try
    % Try with the 'freq'uency we wanted:
   dinghandle = PsychPortAudio('Open', [], [], 0, freq, nrchannels);
catch
    
    psychlasterror('reset');
    dinghandle = PsychPortAudio('Open', [], [], 0, [], nrchannels);
end
PsychPortAudio('Volume', dinghandle, volumn);

% Fill the audio playback buffer with the audio data 'wavedata':
PsychPortAudio('FillBuffer', dinghandle, wavedata);

% Start audio playback for 'repetitions' repetitions of the sound data,
% start it immediately (0) and wait for the playback to start, return onset
% timestamp.

end


