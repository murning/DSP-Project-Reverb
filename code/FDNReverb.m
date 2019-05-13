% FDN

function [out] = FDNReverb(in, Fs, delay, matrix)


in = [in;zeros(Fs*3,1)];

% Max delay of 70 ms
maxDelay = ceil(delay*Fs);  

buffer1 = zeros(maxDelay,1); buffer2 = zeros(maxDelay,1); 
buffer3 = zeros(maxDelay,1); buffer4 = zeros(maxDelay,1);  

d1 = fix(.0297*Fs);
d2 = fix(.0371*Fs);
d3 = fix(.0411*Fs);
d4 = fix(.0437*Fs);


if matrix == "house"
    g11 = 0.5; g12 = -0.5; g13 = -0.5; g14 =-0.5;  % Householder-reflection
    g21 = -0.5; g22 = 0.5; g23 = -0.5; g24 =-0.5;  % Feed-back Matrix
    g31 = -0.5; g32 = -0.5; g33 = 0.5; g34 =-0.5;
    g41 = -0.5 ; g42 = -0.5; g43 =-0.5; g44 = 0.5;

elseif matrix == "funk"
    g11 = 0.5; g12 = -0.5; g13 = -0.5; g14 =-0.5;  % funkhouser-reflection
    g21 = -0.5; g22 = 0.5; g23 = -0.5; g24 =-0.5;  % Feed-back Matrix
    g31 = -0.5; g32 = -0.5; g33 = 0.5; g34 =-0.5;
    g41 = -0.5 ; g42 = -0.5; g43 =2; g44 = 0.5;

elseif matrix == "hada"
    g11 = 0.5; g12 = 0.5; g13 = 0.5; g14 = 0.5;  % Hadamard  
    g21 =0.5; g22 = -0.5; g23 = 0.5; g24 =-0.5;  % Feed-back Matrix
    g31 = 0.5; g32 = 0.5; g33 = -0.5; g34 =-0.5;
    g41 = 0.5 ; g42 = -0.5; g43 =-0.5; g44 = 0.5;

elseif matrix == "stautner"
    g11 = 0; g12 = 1; g13 = 1; g14 = 0;  % Stautner and Puckette
    g21 =-1; g22 = 0; g23 = 0; g24 =-1;  % Feed-back Matrix
    g31 = 1; g32 = 0; g33 = 0; g34 =-1;
    g41 = 0; g42 = 1; g43 =-1; g44 = 0;
end




rate1 = 0.6; amp1 = 5; 
rate2 = 0.71; amp2 = 5;
rate3 = 0.83; amp3 = 5; 
rate4 = 0.95; amp4 = 5;

N = length(in);
out = zeros(N,1);

fb1 = 0; fb2 = 0; fb3 = 0; fb4 = 0;

g = .67;
for n = 1:N
    inDL1 = in(n,1) + fb1;
    inDL2 = in(n,1) + fb2;
    inDL3 = in(n,1) + fb3;
    inDL4 = in(n,1) + fb4;

    [outDL1,buffer1] = modDelay(inDL1,buffer1,Fs,n,...
    d1,amp1,rate1);
    [outDL2,buffer2] = modDelay(inDL2,buffer2,Fs,n,...
    d2,amp2,rate2);
    [outDL3,buffer3] = modDelay(inDL3,buffer3,Fs,n,...
    d3,amp3,rate3);
    [outDL4,buffer4] = modDelay(inDL4,buffer4,Fs,n,...
    d4,amp4,rate4);

    out(n,1) = 0.25*(outDL1 + outDL2 + outDL3 + outDL4);

    fb1 = g*(g11*outDL1 + g21*outDL2 + g31*outDL3 + g41*outDL4);
    fb2 = g*(g12*outDL1 + g22*outDL2 + g32*outDL3 + g42*outDL4);
    fb3 = g*(g13*outDL1 + g23*outDL2 + g33*outDL3 + g43*outDL4);
    fb4 = g*(g14*outDL1 + g24*outDL2 + g34*outDL3 + g44*outDL4);
end


end
