clear;clc
[x_in,Fs]= audioread('dryGuitar0407.mp3');
info= audioinfo('dryGuitar0407.mp3'); 
[length,mono_or_stero] = size(x_in);

delaySec = 0.05; % Delay in seconds
gain = 0.7;

%output_sig = allPassFilter(x_in, Fs, gain, delaySec);
%filename = 'DryGuitar_AllPassDelay_70ms.wav';
%audiowrite(filename,output_sig,Fs);

output_sig1 = FIR_CombFilter(x_in, Fs, gain, delaySec);
filename = 'dryGuitar0407_FIR_CombDelay_50ms.wav';
audiowrite(filename,output_sig1,Fs);

gainALLpass=1;
gainComb=0.4;
reverbOutput1=schroederReverb(x_in, Fs, gainALLpass, gainComb);
filename = 'dryGuitar0407_schroederReverb.wav';
audiowrite(filename,reverbOutput1,Fs);

delaySec=0.015;
output_sig = flanging(x_in, Fs, 0.65, delaySec,round(delaySec*Fs*0.4),0.5);
filename = 'dryGuitar0407_flanging.wav';
audiowrite(filename,output_sig,Fs);

output_sig = chorus(x_in, Fs, 0.65, 0.02);
filename = 'dryGuitar0407_chorus.wav';
audiowrite(filename,output_sig,Fs);