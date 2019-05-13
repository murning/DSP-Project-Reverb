

[input,Fs] = audioread('output.wav');
T = 1/Fs;           % Sampling period
L = length(input);          % Length of signal
t = (0:L-1)*T;      % Time vector
in = mean(input,2);


[SchroederResponse,t1] = impulseResponse(in,Fs,"Schroeder",0.07);
[MoorerResponse,t2] = impulseResponse(in,Fs,"Moorer",0.07);
[FDNResponse,t3] = impulseResponse(in,Fs,"FDN",0.07);


[theta,t] = echodensity(SchroederResponse,Fs);

[theta1,t1] = echodensity(FDNResponse,Fs);
[theta2,t2]= echodensity(MoorerResponse,Fs);hold on


plot(t,theta(t));
xlim([300 5E4])
hold on
plot(t1,theta1(t1));
xlim([300 5E4])
hold on
plot(t2,theta2(t2));
xlim([300 5E4])

legend('Schroeder', 'FDN', 'Moorer')
set(gca,'XScale','log')
grid;
