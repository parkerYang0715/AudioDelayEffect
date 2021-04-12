function [output_sig3] = phaser_by3AllPassFilter(x_in, Fs, gainALLpass, delaySec)
% x_in: input Signal
% F_s: sampling frequency of input signal
% gain: the decay of delay signal
% delaySec: delaySec*Fs = delaySamples

[~,mono_or_stero] = size(x_in);
if(mono_or_stero>4)
    x_in = x_in' ;
end

%[length_in,mono_or_stero] = size(x_in);

if abs(gainALLpass) >= 1
    gainALLpass = abs(gainALLpass)/(abs(gainALLpass)+0.5);
end

gain1 = 0.7*gainALLpass;
if(delaySec<=0)
    delaySec = 0.04;
end

% part 1: all pass filters in series
% all pass filters: y[n] = -g x[n] + x[n-M] + g y[n-M] 

output_sig1 = allPass_byMATLABfilter(x_in,Fs, gain1, delaySec);
output_sig2 = allPass_byMATLABfilter(output_sig1,Fs, gain1, delaySec/1.57);
output_sig3 = allPass_byMATLABfilter(output_sig2,Fs, gain1, delaySec/2);


end