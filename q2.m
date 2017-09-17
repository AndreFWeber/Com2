clear all; close all;

Nb = 2;
L = 4;
N = 4;
Spc = 50;
Rb = 200e3;

Tb = 1/Rb;
Rc = N*Rb;
Tc = 1/Rc;

xn_1 = [0 0];
xn_2 = [1 0];
xn_3 = [0.5 0.5];
xn_4 = [0 1];

xn_1 = xn_1*2-1;
xn_2 = xn_2*2-1;
xn_3 = xn_3*2-1;
xn_4 = xn_4*2-1;

hadamardt = hadamard(4);

cn_1 = hadamardt(1,:);
cn_2 = hadamardt(2,:);
cn_3 = hadamardt(3,:);
cn_4 = hadamardt(4,:);

cn_1 = repmat(cn_1, 1, ((Nb*N)/L));
cn_2 = repmat(cn_2, 1, ((Nb*N)/L));
cn_3 = repmat(cn_3, 1, ((Nb*N)/L));
cn_4 = repmat(cn_4, 1, ((Nb*N)/L));

xn_1 = kron(xn_1, repmat([1], 1, N));
xn_2 = kron(xn_2, repmat([1], 1, N));
xn_3 = kron(xn_3, repmat([1], 1, N));
xn_4 = kron(xn_4, repmat([1], 1, N));

sn_1 = xn_1.*cn_1;
sn_2 = xn_2.*cn_2;
sn_3 = xn_3.*cn_3;
sn_4 = xn_4.*cn_4;

xt_1 = kron(xn_1, repmat([1], 1, Spc));
xt_2 = kron(xn_2, repmat([1], 1, Spc));
xt_3 = kron(xn_3, repmat([1], 1, Spc));
xt_4 = kron(xn_4, repmat([1], 1, Spc));

ct_1 = kron(cn_1, repmat([1], 1, Spc));
ct_2 = kron(cn_2, repmat([1], 1, Spc));
ct_3 = kron(cn_3, repmat([1], 1, Spc));
ct_4 = kron(cn_4, repmat([1], 1, Spc));

st_1 = kron(sn_1, repmat([1], 1, Spc));
st_2 = kron(sn_2, repmat([1], 1, Spc));
st_3 = kron(sn_3, repmat([1], 1, Spc));
st_4 = kron(sn_4, repmat([1], 1, Spc));

t = Nb*Tb*((0:length(st_1)-1)/length(st_1));

rt = st_1 + st_2 + st_3 + st_4;

yt_1 = rt .* ct_1;
yt_2 = rt .* ct_2;
yt_3 = rt .* ct_3;
yt_4 = rt .* ct_4;

niveis_yt_1 = yt_1(Spc/2+1:Spc:size(yt_1,2));
niveis_yt_2 = yt_2(Spc/2+1:Spc:size(yt_1,2));
niveis_yt_3 = yt_3(Spc/2+1:Spc:size(yt_1,2));
niveis_yt_4 = yt_4(Spc/2+1:Spc:size(yt_1,2));

d1(1) = sum(niveis_yt_1(1:size(niveis_yt_1,2)/2)*Tc) / Tb;
d1(2) = sum(niveis_yt_1(size(niveis_yt_1,2)/2+1:size(niveis_yt_1,2))*Tc) / Tb

d2(1) = sum(niveis_yt_2(1:size(niveis_yt_2,2)/2)*Tc) / Tb;
d2(2) = sum(niveis_yt_2(size(niveis_yt_2,2)/2+1:size(niveis_yt_2,2))*Tc) / Tb

d3(1) = sum(niveis_yt_3(1:size(niveis_yt_3,2)/2)*Tc) / Tb;
d3(2) = floor(sum(niveis_yt_3(size(niveis_yt_3,2)/2+1:size(niveis_yt_3,2))*Tc) / Tb)

d4(1) = sum(niveis_yt_4(1:size(niveis_yt_4,2)/2)*Tc) / Tb;
d4(2) = sum(niveis_yt_4(size(niveis_yt_4,2)/2+1:size(niveis_yt_4,2))*Tc) / Tb

%% Figura 1 - x(t)
figure
subplot(4,1,1)
plot(t, xt_1)
title('x1(t)')
ylim([-1.5 1.5])

subplot(4,1,2)
plot(t, xt_2)
title('x2(t)')
ylim([-1.5 1.5])

subplot(4,1,3)
plot(t, xt_3)
title('x3(t)')
ylim([-1.5 1.5])

subplot(4,1,4)
plot(t, xt_4)
title('x4(t)')
ylim([-1.5 1.5])

%% Figura 2 - s(t)
figure
subplot(4,1,1)
plot(t, st_1)
title('s1(t)')
ylim([-1.5 1.5])

subplot(4,1,2)
plot(t, st_2)
title('s2(t)')
ylim([-1.5 1.5])

subplot(4,1,3)
plot(t, st_3)
title('s3(t)')
ylim([-1.5 1.5])

subplot(4,1,4)
plot(t, st_4)
title('s4(t)')
ylim([-1.5 1.5])

%% Figura 3 - r(t)

figure
plot(t, rt)
title('r(t)')
ylim([-3.5 3.5])

%% Figura 4 - y(t)
figure
subplot(4,1,1)
plot(t, yt_1)
title('y1(t)')
ylim([-3.5 3.5])

subplot(4,1,2)
plot(t, yt_2)
title('y2(t)')
ylim([-3.5 3.5])

subplot(4,1,3)
plot(t, yt_3)
title('y3(t)')
ylim([-3.5 3.5])

subplot(4,1,4)
plot(t, yt_4)
title('y4(t)')
ylim([-3.5 3.5])



%% Figura 5 - d
figure
subplot(4,1,1)
stem(d1)
title('d')
xlim([0 3])
ylim([-1.5 1.5])

subplot(4,1,2)
stem(d2)
ylim([-1.5 1.5])
xlim([0 3])

subplot(4,1,3)
stem(d3)
ylim([-1.5 1.5])
xlim([0 3])

subplot(4,1,4)
stem(d4)
ylim([-1.5 1.5])
xlim([0 3])
