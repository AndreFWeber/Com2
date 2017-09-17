clear all; close all;

%kron(v, [1 1 1]) para fazer um upsample de 3 vezes do v
Nb = 1000;
L = 200;
N = 10;
fc = 40000;
Spc = 100;
Rb = 1000;

Tb = 1/Rb;
Rc = N*Rb;
Tc = 1/Rc;

xn = randi([0 1], 1, Nb);
xn = xn*2-1;

cn = randi([0 1], 1, L);
cn = cn*2-1;

xn = kron(xn, repmat([1], 1, N));
cn = repmat(cn, 1, ((Nb*N)/L));

sn = xn.*cn;
%%
st = kron(sn, repmat([1], 1, Spc));
xt = kron(xn, repmat([1], 1, Spc));
ct = kron(cn, repmat([1], 1, Spc));
%%
t = ((0:length(st)-1)/length(st));

figure(1)
subplot(3,1,1)
plot(t, xt)
title('x(t)')
xlim([0 10*Tb])
ylim([-1.5 1.5])

subplot(3,1,2)
plot(t, ct)
title('c(t)')
xlim([0 10*Tb])
ylim([-1.5 1.5])

subplot(3,1,3)
plot(t,st)
title('s(t)')
xlim([0 10*Tb])
ylim([-1.5 1.5])

%%
sBPSK = cos(2*pi*fc*t).*st;

fs = N*Spc*Rb; 

f = -fs/2:fs/length(t):fs/2-1;

figure(2)
fft_x = fftshift(20*log10(abs(fft(xt))));
subplot(2,2,1)
plot(f, fft_x)
xlim([-5000 5000])
ylim([0 100])

subplot(2,2,2)
plot(t, xt)
xlim([0 4*Tb])
ylim([-1.5 1.5])

fft_sBPSK = fftshift(20*log10(abs(fft(sBPSK))));
subplot(2,2,3)
plot(f, fft_sBPSK)
xlim([20000 60000])

subplot(2,2,4)
plot(t, sBPSK)
xlim([0 4*Tb])
ylim([-1.5 1.5])
