function [finalOutput] = schroederReverb(x_in, Fs, gainALLpass, gainComb)
% x_in: input Signal
% F_s: sampling frequency of input signal
% gain: the decay of delay signal
% delaySec: delaySec*Fs = delaySamples

[~,mono_or_stero] = size(x_in);
if(mono_or_stero>4)
    x_in = x_in' ;
end

[length_in,mono_or_stero] = size(x_in);

if abs(gainALLpass) >= 1
    gainALLpass = abs(gainALLpass)/(abs(gainALLpass)+0.5);
end

if abs(gainComb) >= 1
    gainComb = abs(gainComb)/(abs(gainComb)+0.5);
end

delaySec = 0.099; %347/Fs; % Delay in seconds
gain1 = 0.7*gainALLpass;
if(delaySec<=0)
    delaySec = 0.04;
end

%---------schroeder Reverb starts-----------
% part 1: all pass filters in series
% all pass filters: y[n] = -g x[n] + x[n-M] + g y[n-M] 

output_sig1 = allPass_byMATLABfilter(x_in,Fs, gain1, delaySec);
output_sig2 = allPass_byMATLABfilter(output_sig1,Fs, gain1, delaySec/3.07);
output_sig3 = allPass_byMATLABfilter(output_sig2,Fs, gain1, delaySec/3.07/3.05);


% 4 feedback Comb filters 

gain2 = 0.773*gainComb;
gain3 = 0.802*gainComb;
delaySec2 = 0.486;
delaySec3 = 0.461;
outputComb1 = feedBackCombFilter(output_sig3, Fs, gain2, delaySec2);
outputComb2 = feedBackCombFilter(output_sig3, Fs, gain3, delaySec3);

gain4 = 0.753*gainComb;
gain5 = 0.733*gainComb;
delaySec4 = 0.5916;
delaySec5 = 0.6487;
outputComb3 = feedBackCombFilter(output_sig3, Fs, gain4, delaySec4);
outputComb4 = feedBackCombFilter(output_sig3, Fs, gain5, delaySec5);
if(mono_or_stero == 1)
    %s1 = outputComb1+outputComb3;
    %s2 = outputComb2+outputComb4;
    %outA = s1+s2;
    %outB = s1-s2;
    outA = outputComb1+outputComb3;
    outB = outputComb2+outputComb4;
end
if(mono_or_stero == 2)
outA = outputComb1(:,1)+outputComb2(:,2) + outputComb3(:,2) + outputComb4(:,1);

outB = outputComb1(:,2)+outputComb2(:,1) + outputComb3(:,1) + outputComb4(:,2);
end
outA = outA / max(abs(outA));
outB = outB / max(abs(outB));
finalOutput = zeros(length_in,2);
finalOutput(:,1) = outA;
finalOutput(:,2) = outB;

%---------schroeder Reverb finishes--------
end