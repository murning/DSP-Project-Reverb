
% SCHROEDER REVERB

function [out] = SchroederReverb(in, Fs, delay)

maxDelay = ceil(delay*Fs);

buffer1 = zeros(maxDelay,1);
buffer2 = zeros(maxDelay,1);
buffer3 = zeros(maxDelay,1);
buffer4 = zeros(maxDelay,1);
buffer5 = zeros(maxDelay,1);
buffer6 = zeros(maxDelay,1);

d1 = fix(.0297*Fs); g1 = 0.75;
d2 = fix(.0371*Fs); g2 = -0.75;
d3 = fix(.0411*Fs); g3 = 0.75;
d4 = fix(.0437*Fs); g4 = -0.75;
d5 = fix(.005*Fs);  g5 = 0.7;
d6 = fix(.0017*Fs); g6 = 0.7;


rate1 = 0.6; amp1 = 8;
rate2 = 0.71; amp2 = 8;
rate3 = 0.83; amp3 = 8;
rate4 = 0.95; amp4 = 8;
rate5 = 1.07; amp5 = 8;
rate6 = 1.19; amp6 = 8;


N = length(in);

out = zeros(N,1);


for n = 1:N
[w1,buffer1] = fbcf(in(n,1),buffer1,Fs,n,...
d1,g1,amp1,rate1);
[w2,buffer2] = fbcf(in(n,1),buffer2,Fs,n,...
d2,g2,amp2,rate2);
[w3,buffer3] = fbcf(in(n,1),buffer3,Fs,n,...
d3,g3,amp3,rate3);
[w4,buffer4] = fbcf(in(n,1),buffer4,Fs,n,...
d4,g4,amp4,rate4);

combPar = 0.25*(w1 + w2 + w3 + w4);
[w5,buffer5] = apf(combPar,buffer5,Fs,n,...
d5,g5,amp5,rate5);
[out(n,1),buffer6] = apf(w5,buffer6,Fs,n,...
d6,g6,amp6,rate6);
end


end








