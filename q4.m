clear all; close all;
pkg load communications

Nb = 100e3;
hn = [2 -0.5 0.5]

xn_original = randi([0 1], 1, Nb);

start = [1 0 0 0 0 0 0]
taps = [7 1]
cn = lfsr(taps, start);

L = length(cn)
N = L;

xn_unipolar = kron(xn_original, repmat([1], 1, N));
cn = repmat(cn, 1, ((Nb*N)/L));

xn = xn_unipolar*2-1;
cn = cn*2-1;

sn = xn.*cn;

sn_filtrado = filter(hn,1,sn);

Eb =  sum(sn_filtrado.^2)/Nb;

for EbNo = 0:10
    n0 = Eb/10^((EbNo)/10);

    w = randn( 1, length(sn_filtrado)).*sqrt(n0/2);
  
    rn = sn_filtrado + w;
    
    yn = (rn.*cn);
    yn = vec2mat(yn,L);
    yn = (sum(yn, 2)./127)>0;
    [num, rec(EbNo+1)] = biterr(xn_original,  yn');
end

figure
semilogy([0:10],rec);
xlabel('EbNo')
ylabel('BER')