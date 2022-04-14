function Y = AWGN(X,SNR)
%%%SNR is in dB
natSNR = 10^(SNR/10);

%natSNR = 1/sigma^2

%%%%%noise sample
n = (1/sqrt(natSNR)).*randn(1);


Y = X + n;








end