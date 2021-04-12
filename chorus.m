function [output] = chorus(x_in, Fs, gain, delaySec,range,sweep_freq)
% x_in: input Signal
% F_s: sampling frequency of input signal
% gain: the decay of delay signal
% delaySec: delaySec*Fs = delaySamples
% range: excursion
% sweep_freq: sweep frequency
if(nargin<6)
    sweep_freq = 0.4;
end

[~,mono_or_stero] = size(x_in);
if(mono_or_stero>4)
    x_in = x_in' ;
end

[length_in,mono_or_stero] = size(x_in);

if abs(gain) >= 1
    gain = abs(gain)/(abs(gain)+0.5);
end

if(delaySec<=0)
    delaySec = 0.015;
end
delaySamples = round(delaySec*Fs); % Delay in samples
if(nargin<5)
    range =round(delaySamples*0.18);
end
output=x_in;
if(mono_or_stero==2)
    for i=delaySamples+range+1:length_in
        output(i,1) = output(i,1) + gain*x_in(i-delaySamples-round(range*sin(2*pi*i*sweep_freq/Fs)),1);
    end
    for i=delaySamples+range+1:length_in
        output(i,2) = output(i,2) + gain*x_in(i-delaySamples-round(range*sin(2*pi*i*sweep_freq/Fs)),2);
    end
    delaySamples2=round(delaySamples*2.03);
    range=round(range*1.03);
    sweep_freq=sweep_freq*1.05;
    gain=gain*1.05;
    for i=delaySamples2+range+1:length_in
        output(i,1) = output(i,1) + gain*x_in(i-delaySamples2-round(range*sin(2*pi*i*sweep_freq/Fs)),1);
    end    
    for i=delaySamples2+range+1:length_in
        output(i,2) = output(i,2) + gain*x_in(i-delaySamples2-round(range*sin(2*pi*i*sweep_freq/Fs)),2);
    end
    delaySamples3=round(delaySamples*2.97);
    range=round(range*0.85);
    sweep_freq=sweep_freq*0.97;
    gain=gain*0.89;
    for i=delaySamples3+range+1:length_in
        output(i,1) = output(i,1) + gain*x_in(i-delaySamples3-round(range*sin(2*pi*i*sweep_freq/Fs)),1);
    end
    for i=delaySamples3+range+1:length_in
        output(i,2) = output(i,2) + gain*x_in(i-delaySamples3-round(range*sin(2*pi*i*sweep_freq/Fs)),2);
    end
	delaySamples4=round(delaySamples*4.2);
    range=round(range*0.85);
    sweep_freq=sweep_freq*0.97;
    gain=gain*0.8;
    for i=delaySamples4+range+1:length_in
        output(i,1) = output(i,1) + gain*x_in(i-delaySamples4-round(range*sin(2*pi*i*sweep_freq/Fs)),1);
    end
    for i=delaySamples4+range+1:length_in
        output(i,2) = output(i,2) + gain*x_in(i-delaySamples4-round(range*sin(2*pi*i*sweep_freq/Fs)),2);
    end
end

if(mono_or_stero==1)
    for i=delaySamples+range+1:length_in
        output(i,1) = output(i,1) + gain*x_in(i-delaySamples-round(range*sin(2*pi*i*sweep_freq/Fs)),1);
    end
    delaySamples2=round(delaySamples*2.03);
    range=round(range*1.03);
    sweep_freq=sweep_freq*1.05;
    gain=gain*1.05;
    for i=delaySamples2+range+1:length_in
        output(i,1) = output(i,1) + gain*x_in(i-delaySamples2-round(range*sin(2*pi*i*sweep_freq/Fs)),1);
    end    
    delaySamples3=round(delaySamples*2.97);
    range=round(range*0.85);
    sweep_freq=sweep_freq*0.97;
    gain=gain*0.89;
    for i=delaySamples3+range+1:length_in
        output(i,1) = output(i,1) + gain*x_in(i-delaySamples3-round(range*sin(2*pi*i*sweep_freq/Fs)),1);
    end
	delaySamples4=round(delaySamples*4.2);
    range=round(range*0.85);
    sweep_freq=sweep_freq*0.97;
    gain=gain*0.8;
    for i=delaySamples4+range+1:length_in
        output(i,1) = output(i,1) + gain*x_in(i-delaySamples4-round(range*sin(2*pi*i*sweep_freq/Fs)),1);
    end
end
output = output / max(max(abs(output)));
end