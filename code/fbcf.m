% FBCF
%
%
% Code adapted from "Hack Audio: An Introduction to Computer Programming and Digital Signal Processing in MATLAB" © 2019 Taylor & Francis.
% available: https://www.routledge.com/Hack-Audio-An-Introduction-to-Computer-Programming-and-Digital-Signal/Tarr/p/book/9781138497559
%




function [out,buffer] = fbcf(in,buffer,Fs,n,delay,fbGain,amp,rate)
% Calculate time in seconds for the current sample
t = (n-1)/Fs;
fracDelay = amp * sin(2*pi*rate*t);
intDelay = floor(fracDelay);
frac = fracDelay - intDelay;
% Determine indexes for circular buffer
len = length(buffer);
indexC = mod(n-1,len) + 1; % Current index
indexD = mod(n-delay-1+intDelay,len) + 1; % Delay index


indexF = mod(n-delay-1+intDelay+1,len) + 1; % Fractional index
out = (1-frac)*buffer(indexD,1) + (frac)*buffer(indexF,1);
% Store the current output in appropriate index
buffer(indexC,1) = in + fbGain*out;
end