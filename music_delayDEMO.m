clear;clc
[x_in,Fs]= audioread('eriatarka-riff.mp3');
info= audioinfo('eriatarka-riff.mp3'); 
[length,mono_or_stero] = size(x_in);
t=0:seconds(1/Fs):seconds(info.Duration);
t=t(1:end-1);

delaySec = 0.05; % Delay in seconds
gain = 0.7;

%output_sig = allPassFilter(x_in, Fs, gain, delaySec);
%filename = 'eriatarka-riff_AllPassDelay_60ms.wav';
%audiowrite(filename,output_sig,Fs);

%output_sig1 = IIR_CombFilter(x_in, Fs, gain, delaySec);
%filename = 'eriatarka-riff_IIR_CombDelay_60ms.wav';
%audiowrite(filename,output_sig1,Fs);

%output_sig2 = feedBackCombFilter(x_in, Fs, gain, delaySec);

%output_sig = FIR_CombFilter(x_in, Fs, gain, delaySec);
%filename = 'eriatarka-riff_FIR_CombDelay_60ms.wav';
%audiowrite(filename,output_sig,Fs);

%gainALLpass=1;
%gainComb=0.4;
%reverbOutput1=schroederReverb(x_in, Fs, gainALLpass, gainComb);
%sound(reverbOutput1,Fs)
%filename = 'eriatarka_riff_schroederReverb.wav';
%audiowrite(filename,reverbOutput1,Fs);

%delaySec=0.015;
%output_sig = flanging(x_in, Fs, 0.67, delaySec,round(delaySec*Fs*0.5),0.5);
%filename = 'eriatarka_riff_flanging.wav';
%audiowrite(filename,output_sig,Fs);

%output_sig = chorus(x_in, Fs, 0.67, 0.023);
%filename = 'eriatarka_riff_chorus.wav';
%audiowrite(filename,output_sig,Fs);

output_sig = phaser_by3AllPassFilter(x_in, Fs, 0.8, 0.05);
filename = 'eriatarka_riff_phaser.wav';
audiowrite(filename,output_sig,Fs);