

% load anechoic (echoless) sound
[input,Fs] = audioread('output.wav');
T = 1/Fs;           % Sampling period
L = length(input);          % Length of signal
t = (0:L-1)*T;      % Time vector
in = mean(input,2);




house = FDNReverb(in,Fs,0.07,"house");
funk = FDNReverb(in,Fs,0.07,"funk");
hada = FDNReverb(in,Fs,0.07,"hada");
stautner = FDNReverb(in,Fs,0.07,"stautner");


[theta1, t1] = echodensity()



sound(out, Fs);