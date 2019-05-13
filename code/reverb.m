%
% EEE4114F PROJECT
% Artificial Reverberation
% 
% Kevin Murning
% Kelsey Kaplan
%
% May 2019
%
%
% RIR: Room impulse response
% EDC: Energy decay curve
% RT: Reverberation decay time
% EDR: Energy decay relief
%

% LOAD RIR
a = audioinfo("GalbraithHall.wav");
[rir,fs] = audioread("GalbraithHall.wav");
rir = mean(rir, 2);

% LOAD ANECHOIC SOUND
[input,Fs] = audioread('drySpeech.wav');
T = 1/Fs;                                       % Sampling period
L = length(input);                              % Length of signal
t = (0:L-1)*T;                                  % Time vector
in = mean(input,2);

% CONVOLUTION WITH ROOM IMPULSE RESPONSE
y2 = freqconv(in, rir);

% IMPULSE RESPONSE OF ALLPASS
y3 = allpass(in);

% IMPLEMENT ALGORITHMS WITH DIRAC
% [SchroederResponse,t1] = impulseResponse(in,Fs,"Schroeder",0.07);
% [MoorerResponse,t2] = impulseResponse(in,Fs,"Moorer",0.07);
% [FDNHouseResponse,t3] = impulseResponse(in,Fs,"FDN",0.07,"house");
% [FDNFunkResponse,t3] = impulseResponse(in,Fs,"FDN",0.07,"funk");
% [FDNHadaResponse,t3] = impulseResponse(in,Fs,"FDN",0.07,"hada");
% [FDNStautnerResponse,t3] = impulseResponse(in,Fs,"FDN",0.07,"stautner");

% IMPLEMENT ALGORITHMS WITH INPUT
[SchroederResponse] = SchroederReverb(in,Fs,0.07);
[MoorerResponse] = MoorerReverb(in,Fs,0.07);
[FDNHouseResponse] = FDNReverb(in,Fs,0.07,"house");
[FDNFunkResponse] = FDNReverb(in,Fs,0.07,"funk");
[FDNHadaResponse] = FDNReverb(in,Fs,0.07,"hada");
[FDNStautnerResponse] = FDNReverb(in,Fs,0.07,"stautner");

% AUDIO OUT
% audiowrite('outputs/convolution-reverb.wav', y2, fs)
% audiowrite('outputs/allpass-reverb.wav',y3, fs)
% audiowrite('outputs/schroeder-reverb.wav',SchroederResponse, fs)
% audiowrite('outputs/moorer-reverb.wav',MoorerResponse, fs)
% audiowrite('outputs/fdnHouse-reverb.wav',FDNHouseResponse, fs)
% audiowrite('outputs/fdnCustom-reverb.wav',FDNFunkResponse, fs)
% audiowrite('outputs/fdnHada-reverb.wav',FDNHadaResponse, fs)
% audiowrite('outputs/fdnOriginal-reverb.wav',FDNStautnerResponse, fs)

% EDC AND RT 
[RTir, EDCir] = edc(rir); 
[RTschroeder, EDCschroeder] = edc(SchroederResponse);
[RTmoorer, EDCmoorer] = edc(MoorerResponse);
[RTHousefdn, EDCHousefdn] = edc(FDNHouseResponse);
[RTFunkfdn, EDCFunkfdn] = edc(FDNFunkResponse);
[RTHadafdn, EDCHadafdn] = edc(FDNHadaResponse);
[RTStautnerfdn, EDCStautnerfdn] = edc(FDNStautnerResponse);

% EDR
edr(rir, Fs)
edr(SchroederResponse, Fs)
edr(MoorerResponse, Fs)
edr(FDNHouseResponse, Fs)
edr(FDNFunkResponse, Fs)
edr(FDNHadaResponse, Fs)
edr(FDNStautnerResponse, Fs)

% ECHO DENSITY
[theta,t] = echodensity(rir,Fs);
[theta,t] = echodensity(SchroederResponse,Fs);
[theta2,t2]= echodensity(MoorerResponse,Fs);
[thetaHouse,tHouse] = echodensity(FDNHouseResponse,Fs);
[thetaFunk,tFunk] = echodensity(FDNFunkResponse,Fs);
[thetaHada,tHada] = echodensity(FDNHadaResponse,Fs);
[thetaStautner,tStautner] = echodensity(FDNStautnerResponse,Fs);

%% PLOTS

% RIR PLOT
% hold on;
% plot(t,theta(t));
% dt = 1/fs;
% t = 0:dt:(length(in)*dt)-dt;
% plot(t, in, 'black')
% ylim([-1 1])
% xlabel('Time [s]'), ylabel('Amplitude'), grid();

% ALLPASS RESPONSE
% dt = 1/fs;
% t = 0:dt:(length(y3)*dt)-dt;
% figure(1);
% plot(t, y3)
% %title('Impulse Response of Allpass Filter');
% xlabel('Time [s]')
% axis([0 inf, -0.6 0.6])

% CONVOLUTIONAL REVERB
% figure(4);
% dt = 1/fs;
% subplot(2,1,1)
% t2 = 0:dt:(length(input)*dt)-dt;
% plot(t2, input,'black');
% xlabel('Time [s]'),ylabel('Amplitude')
% title('Original Anechoic Signal');
% axis([0 7, -1 1])
% subplot(2,1,2)
% t1 = 0:dt:(length(y2)*dt)-dt;
% plot(t1, y2);
% title('Convolved Anechoic Signal');
% xlabel('Time [s]'),ylabel('Amplitude')
% axis([0 7, -1 1])

% ALGORITHMIC REVERB RESPONSES
% subplot(4,1,1);
% figure(1)
% t1 = 0:dt:(length(y2)*dt)-dt;
% plot(t1, y2);
% title("Convolutional Reverb")
% xlabel('Time [s]'), ylabel('Amplitude'),grid;
% xlim([0 7]);
% subplot(4,1,2);
% t1 = 0:dt:(length(SchroederResponse)*dt)-dt;
% plot(t1, SchroederResponse);
% title("Schroeder's Algorithm")
% xlabel('Time [s]'), ylabel('Amplitude'),grid;
% xlim([0 7]);
% subplot(4,1,3);
% t2 = 0:dt:(length(MoorerResponse)*dt)-dt;
% plot(t2, MoorerResponse);
% title("Moorer's Algorithm")
% xlabel('Time [s]'), ylabel('Amplitude'),grid;
% xlim([0 7]);
% subplot(4,1,4);
% t3 = 0:dt:(length(FDNResponse)*dt)-dt;
% plot(t3, FDNResponse);
% title("FDN Algorithm")
% xlabel('Time [s]'), ylabel('Amplitude'),grid;
% xlim([0 7]);

% FDN REVERB RESPONSES
% figure();
% dt = 1/fs;
% subplot(4,1,3);
% t1 = 0:dt:(length(FDNHouseResponse)*dt)-dt;
% plot(t1, FDNHouseResponse);
% title("Householder FDN Algorithm")
% xlabel('Time [s]'), ylabel('Amplitude'),grid;
% xlim([0 7]);
% subplot(4,1,4);
% t2 = 0:dt:(length(FDNFunkResponse)*dt)-dt;
% plot(t2, FDNFunkResponse);
% title("Custom FDN Algorithm")
% xlabel('Time [s]'), ylabel('Amplitude'),grid;
% xlim([0 7]);
% subplot(4,1,2);
% t3 = 0:dt:(length(FDNHadaResponse)*dt)-dt;
% plot(t3, FDNHadaResponse);
% title("Hadamard FDN Algorithm")
% xlabel('Time [s]'), ylabel('Amplitude'),grid;
% xlim([0 7]);
% subplot(4,1,1);
% t3 = 0:dt:(length(FDNStautnerResponse)*dt)-dt;
% plot(t3, FDNStautnerResponse);
% title("Original FDN Algorithm")
% xlabel('Time [s]'), ylabel('Amplitude'),grid;
% xlim([0 7]);

% RIR EDC
% figure(1)
% subplot(3,1,1);
% t = 0:dt:(length(irHilbert)*dt)-dt;
% plot(t, irHilbert)
% xlabel('Time [s]'), ylabel('Amplitude'),grid;
% axis([-inf 0.8, -inf inf]) 
% title('Filtered Impulse Response');
% subplot(3,1,2);
% t = 0:dt:(length(irFiltered)*dt)-dt;
% plot(t, irFiltered)
% xlabel('Time [s]'), ylabel('Amplitude'),grid;
% axis([-inf 0.8, -inf inf]) 
% title('Impulse Response Envelope');
% subplot(3,1,3);
% t = 0:dt:(length(EDCir)*dt)-dt;
% plot(t, EDCir)
% xlabel('Time [s]'), ylabel('Magnitude [dB]'),grid;
% axis([-inf inf, -80 0]) 
% title('Energy Decay Curve');

% ALGORITHMIC EDC
% figure(1)
% hold on;
% dt = 1/fs;
% t = 0:dt:(length(EDCir)*dt)-dt;
% plot(t,EDCir)
% plot(t,EDCschroeder)
% plot(t,EDCmoorer)
% plot(t,EDCStautnerfdn)
% xlabel('Time [s]'), ylabel('Magnitude [dB]'),grid;
% axis([-inf 0.8, -80 0]); 
% legend('Room Impulse Response', 'Schroeder', 'Moorer', 'FDN');

% FDN EDC
% figure(1)
% dt = 1/fs;
% hold on;
% t = 0:dt:(length(EDCHousefdn)*dt)-dt;
% plot(t,EDCHousefdn)
% plot(t,EDCFunkfdn)
% plot(t,EDCHadafdn)
% plot(t,EDCStautnerfdn)
% xlabel('Time [s]'), ylabel('Magnitude [dB]'),grid;
% axis([-inf inf, -60 0]) 
% legend('Householder', 'Custom', 'Hadamard', 'Original');

% ECHO DENSITY
% hold on
% plot(tHouse,thetaHouse(tHouse));
% plot(tFunk,thetaFunk(tFunk));
% plot(tHada,thetaHada(tHada));
% plot(tStautner,thetaStautner(tStautner));
% xlim([300 5E4])
% legend('Householder', 'Custom', 'Hadamard', 'Original')
% set(gca,'XScale','log')
% grid;







