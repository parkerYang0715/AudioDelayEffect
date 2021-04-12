clear;clc
[x_in,Fs]= audioread('OSR_us_000_0019_8k.wav');
info= audioinfo('OSR_us_000_0019_8k.wav'); 
[length,mono_or_stero] = size(x_in);
t=0:seconds(1/Fs):seconds(info.Duration);
t=t(1:end-1);
gainALLpass=1;
gainComb=0.4;
reverbOutput1=schroederReverb(x_in, Fs, gainALLpass, gainComb);
sound(reverbOutput1,Fs)
filename = 'OSR_us_000_0019_8k_schroederReverb.wav';
audiowrite(filename,reverbOutput1,Fs);