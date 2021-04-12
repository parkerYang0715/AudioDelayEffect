clear;clc
[x_in,Fs]= audioread('DryGuitar_cut.wav');
info= audioinfo('DryGuitar_cut.wav'); 
%x_in=x_in(44100*15:44100*80,:);
[length,mono_or_stero] = size(x_in);
%sound(x_in,Fs)
%filename = 'DryGuitar_cut.wav';
%audiowrite(filename,x_in,Fs);

delaySec = 0.06; % Delay in seconds
gain = 0.7;

%output_sig = allPassFilter(x_in, Fs, gain, delaySec);
%filename = 'DryGuitar_AllPassDelay_60ms.wav';
%audiowrite(filename,output_sig,Fs);

%output_sig1 = IIR_CombFilter(x_in, Fs, gain, delaySec);
%filename = 'DryGuitar_IIR_CombDelay_60ms.wav';
%audiowrite(filename,output_sig1,Fs);


output_sig = flanging(x_in, Fs, 0.65, 0.015);
filename = 'DryGuitar_flanging.wav';
audiowrite(filename,output_sig,Fs);

output_sig = chorus(x_in, Fs, 0.65, 0.02);
filename = 'DryGuitar_chorus.wav';
audiowrite(filename,output_sig,Fs);