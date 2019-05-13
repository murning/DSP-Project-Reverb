% 
% function to implement three cascaded 
% schroeder allpass filters
%
%

function [y] = allpass(signal)

% recommended gain
g = 0.7;

% recommended delay line lengths
M = [113 337 1051];


b = [-g zeros(1,M(1)-1) 1];
a = [1 zeros(1,M(1)-1) -g];

x = [1 zeros(1, 4000)]; % to get imp resp
% x = signal;           % to get reverberated audio

y = x;
for n = 1:length(M),
  b = [-g zeros(1,M(n)-1) 1];
  a = [1 zeros(1,M(n)-1) -g];
  y = filter(b, a, y);
end

end







