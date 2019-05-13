%
% function to convolve impulse response and anechoic sound 
% allows mixing direct sound back in
%
%

function y = freqconv(sig, ir)

[lenSig, chanSig] = size(sig);
[lenIR, chanIR] = size(ir);
    
sig = [sig; zeros(lenIR - 1, chanSig)];
ir = [ir; zeros(lenSig - 1, chanSig)];

% fast convolution
SIG = fft(sig);             
IR = fft(ir);
y = ifft(SIG .* IR);

% normalizing signal
y = y / max(abs(y));        

% mixes in original signal
y = (0.9 * y) + (0.1 * sig);
y = y / max(abs(y));

end