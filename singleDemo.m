clear;clc
[x_in,Fs]= audioread('cleandiskant-G01.wav');
info= audioinfo('cleandiskant-G01.wav'); 
[length,mono_or_stero] = size(x_in);
t=0:seconds(1/Fs):seconds(info.Duration);
t=t(1:end-1);

delaySec = 0.06; % Delay in seconds
gain = 0.7;

%output_sig = allPassFilter(x_in, Fs, gain, delaySec);
%filename = 'cleandiskant-G01_AllPassDelay_60ms.wav';
%audiowrite(filename,output_sig,Fs);

%output_sig1 = IIR_CombFilter(x_in, Fs, gain, delaySec);
%filename = 'cleandiskant-G01_IIR_CombDelay_60ms.wav';
%audiowrite(filename,output_sig1,Fs);

%output_sig2 = feedBackCombFilter(x_in, Fs, gain, delaySec);

output_sig = FIR_CombFilter(x_in, Fs, gain, delaySec);
filename = 'cleandiskant-G01_FIR_CombDelay_60ms.wav';
audiowrite(filename,output_sig,Fs);

%gainALLpass=1;
%gainComb=0.4;
%reverbOutput1=schroederReverb(x_in, Fs, gainALLpass, gainComb);
%sound(reverbOutput1,Fs)
%filename = 'cleandiskant-G01_schroederReverb.wav';
%audiowrite(filename,reverbOutput1,Fs);

delaySec=0.015;
output_sig = flanging(x_in, Fs, 0.75, delaySec,round(delaySec*Fs*0.6),0.7);
filename = 'cleandiskant-G01_flanging.wav';
audiowrite(filename,output_sig,Fs);

output_sig = chorus(x_in, Fs, 0.75, 0.023);
filename = 'cleandiskant-G01_chorus.wav';
audiowrite(filename,output_sig,Fs);