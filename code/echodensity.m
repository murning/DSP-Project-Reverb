% Echo Density Measurement



function [theta, t] = echodensity(h,fs)


t1 = 100;
t2 = 10E4;
L = round(0.02*fs/2);
w = hann(L*2+1);
w = w/sum(w);
theta = zeros(1,t2);

for n = 1:1:t2-2*L-1
    segma = sqrt(sum(w.*h(n:n+2*L).^2));
    theta(n) = sum(w.*(abs(h(n:n+2*L))>segma));
end

theta = theta/erfc(1/sqrt(2));
theta = [zeros(1,L) theta];
t = t1:t2;

