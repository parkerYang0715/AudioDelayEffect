function [output] = allPass_byMATLABfilter(x_in, Fs, gain, delaySec)
% x_in: input Signal
% F_s: sampling frequency of input signal
% gain: the decay of delay signal
% delaySec: delaySec*Fs = delaySamples

[~,mono_or_stero] = size(x_in);
if(mono_or_stero>4)
    x_in = x_in' ;
end

[length_in,mono_or_stero] = size(x_in);

if abs(gain) >= 1
    gain = abs(gain)/(abs(gain)+0.5);
end

if(delaySec<=0)
    delaySec = 0.04;
end
delaySamples = round(delaySec*Fs); % Delay in samples

b1 = [-gain zeros(1,delaySamples-2) 1];
a1 = [1 zeros(1,delaySamples-2) -gain];
output = zeros(length_in,mono_or_stero);
if(mono_or_stero==2)
    % all pass filter (by MATLAB filter function
    output(:,1) = filter(b1,a1,x_in(:,1));
    output(:,2) = filter(b1,a1,x_in(:,2));
end

if(mono_or_stero==1)
    % all pass filter (by MATLAB filter function
    output(:,1) = filter(b1,a1,x_in(:,1));
end
output = output / max(max(abs(output)));
end