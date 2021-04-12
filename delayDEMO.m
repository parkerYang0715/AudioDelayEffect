clear;clc
[s,Fs]= audioread('OSR_us_000_0019_8k.wav');
info= audioinfo('OSR_us_000_0019_8k.wav'); 
[length,mono_or_stero] = size(s);
t=0:seconds(1/Fs):seconds(info.Duration);
t=t(1:end-1);

delaySec = 0.06; % Delay in seconds
gain = 0.7;

output_sig = allPassFilter(s, Fs, gain, delaySec);
filename = 'OSR_us_000_0019_8k_AllPassDelay_60ms.wav';
audiowrite(filename,output_sig,Fs);

output_sig1 = IIR_CombFilter(s, Fs, gain, delaySec);
filename = 'OSR_us_000_0019_8k_IIR_CombDelay_60ms.wav';
audiowrite(filename,output_sig1,Fs);

output_sig2 = feedBackCombFilter(s, Fs, gain, delaySec);
%plot(t,output_sig1,'k','LineWidth',1.5);hold on;plot(t,output_sig2,'r--');
%xlabel('time (s)','FontSize',14);
%title('comparison time domain vs MATLAB filter','FontSize',18);
%legend({'feedBack 1','feedBack 2'},'FontSize',14);
%axis([0.2 0.8 -1.2 1.2])

output_sig = FIR_CombFilter(s, Fs, gain, delaySec);
filename = 'OSR_us_000_0019_8k_FIR_CombDelay_60ms.wav';
audiowrite(filename,output_sig,Fs);

gainALLpass=1;
gainComb=0.4;
reverbOutput1=schroederReverb(x_in, Fs, gainALLpass, gainComb);
sound(reverbOutput1,Fs)
filename = 'OSR_us_000_0019_8k_schroederReverb.wav';
audiowrite(filename,reverbOutput1,Fs);