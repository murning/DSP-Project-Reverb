%
% function to get the EDC
% and the RT 
%
% EDC: energy decay curve
% RT: reverberation time
%

function [RT, EDC] = edc(ir)

fs = 1/44100;

% smoothing with hilbert transform
irHilbert = abs(hilbert(ir));

% schroeder integral
td = 30e3; % value chosen to match envelope
EDC(td:-1:1)=(cumsum(irHilbert(td:-1:1))/sum(irHilbert(1:td)));
EDC = 10*log(EDC);

% getting RT
dt=1/fs;
t = 0:dt:(length(EDC)*dt)-dt;
slope = polyfit(t,EDC,1);
slope = slope(1);
RT = -60/slope(1);

end








