function [output] = allPassFilter(x_in, Fs, gain, delaySec)
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
output = zeros(length_in,mono_or_stero);
if(mono_or_stero==2)

    % all pass filter
    output(1:delaySamples,:) = -gain * x_in(1:delaySamples,:);
    for i=delaySamples+1:length_in
        output(i,1) = gain * output(i-delaySamples,1) + x_in(i-delaySamples,1);
    end
    for i=delaySamples+1:length_in
        output(i,2) = gain * output(i-delaySamples,2) + x_in(i-delaySamples,2);
    end
end

if(mono_or_stero==1)
 
    % all pass filter
    output(1:delaySamples,:) = -gain * x_in(1:delaySamples,:);
    for i=delaySamples+1:length_in
        output(i,1) = gain * output(i-delaySamples,1) + x_in(i-delaySamples,1);
    end
end

output = output / max(max(output));

end