%
% function to plot the edr
%
% EDR: energy decay relief
%

function edr(signal, fs)

% settings
frameSize = 30;
overlap = 0.75;
windowType = 'hann';

% calculating STFT frames
minFrameLen = fs*frameSize/1000; 
frameLenPow = nextpow2(minFrameLen);
frameLen = 2^frameLenPow; % frame length = fft size
eval(['frameWindow = ' windowType '(frameLen);']);
[B,F,T] = spectrogram(signal,frameWindow,overlap*frameLen,[],fs);

[nBins,nFrames] = size(B);
energy = B.*conj(B);
EDR = zeros(nBins,nFrames);

for i=1:nBins
    EDR(i,:) = fliplr(cumsum(fliplr(energy(i,:))));
end
EDRdB = 10*log10(abs(EDR));

% normalizing EDR to 0 dB
% truncating the plot to dB threshold -70
offset = max(max(EDRdB));
EDRdBN = EDRdB-offset;
EDRdBN_trunc = EDRdBN;
for i=1:nFrames
  I = find(EDRdBN(:,i) < -70);
  if (I)
    EDRdBN_trunc(I,i) = -70;
  end
end

% plotting results
figure(3);clf;
mesh(T,F/1000,EDRdBN_trunc);
view(130,30);
xlabel('Time [s]');ylabel('Frequency (kHz)'); zlabel('Magnitude (dB)');
axis([0 2 -inf inf -inf inf]);

end







