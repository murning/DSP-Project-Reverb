% 
% function to implement algorithms 
% with an impulse
% returns the result
%

function [out, time] = impulseResponse(input, Fs, func, delay, matrix)

T = 1/Fs;                       % Sampling period
L = length(input);              % Length of signal
t = (0:L-1)*T;
in = mean(input,2);

impulse = dirac(t);
idx = impulse == Inf;           % find Inf
impulse(idx) = 1;               % set Inf to finite value

if func == "Schroeder"
    impulseResponse = SchroederReverb(impulse.', Fs, delay);
elseif func == "Moorer"
    impulseResponse = MoorerReverb(impulse.', Fs, delay);
elseif func  == "FDN"
    impulseResponse = FDNReverb(impulse.', Fs, delay, matrix);
end

L = length(impulseResponse);    % Length of signal
time = (0:L-1)*T;               % Time vector
out = impulseResponse;

end




