clear all; close all;

Ncw = 10;

codeHamming.k = 4;
codeHamming.n = 7;
codeHamming.R = codeHamming.k/codeHamming.n;


codeHamming.u = de2bi([0:2^codeHamming.k-1]);
codeHamming.G = [1 0 0 0 1 1 0; 0 1 0 0 1 0 1; 0 0 1 0 0 1 1; 0 0 0 1 1 1 1];

codeHamming.H = [1 1 0 1 1 0 0; 1 0 1 1 0 1 0; 0 1 1 1 0 0 1];
codeHamming.e = syndtable(codeHamming.H);%[0 0 0 0 0 0 0; 0 0 0 0 0 0 1; 0 0 0 0 0 1 0; 0 0 0 0 1 0 0; 0 0 0 1 0 0 0; 0 0 1 0 0 0 0; 0 1 0 0 0 0 0; 1 0 0 0 0 0 0];
codeHamming.c = mod(codeHamming.u(1:size(codeHamming.u,1),:)*codeHamming.G,2);
codeHamming.sindromes = mod(codeHamming.e * codeHamming.H', 2);
codeHamming.cMod = codeHamming.c*2-1;

EscolhePalavrasRandom = randi([1 size(codeHamming.c,1)],1,Ncw);
palavrasEnviadas = codeHamming.c(EscolhePalavrasRandom(1:end),:);
palavrasEnviadas = palavrasEnviadas*2-1;

Eb = sum(sum(palavrasEnviadas.^2))/(Ncw*codeHamming.k);

for Eb_No = -1:7
    norm = Eb/10^((Eb_No)/10);
    ruido = randn(length(palavrasEnviadas),codeHamming.n).*sqrt(norm/2);
    y_n = palavrasEnviadas + ruido;
    
    b_polar = y_n;
    b = b_polar > 0;
    
     for i = 1:1:size(palavrasEnviadas, 1)
       recebidoHDD(i,:) = decodificador(b(i,:), codeHamming);
       recebidoSDD(i,:) = decodificadorSDD(b_polar(i,:), codeHamming);
    end

    [num, recHDD(Eb_No+2)] = biterr(codeHamming.u(EscolhePalavrasRandom(1:end),:), recebidoHDD);
    [num, recSDD(Eb_No+2)] = biterr(codeHamming.u(EscolhePalavrasRandom(1:end),:), recebidoSDD);  
end
%% Fig1
for Eb_No = -1:7
    Eb_No_lin = 10^(Eb_No/10);
    Eb_No_Bruta = codeHamming.R * Eb_No_lin;
    p = qfunc(sqrt(2*Eb_No_Bruta));
    pc(Eb_No+2) = 1 - ((1-p)^7 + 7*p*(1-p)^6);
end

figure
semilogy([-1:7], pc)
hold on
semilogy([-1:7], pc/codeHamming.k)
hold on
semilogy([-1:7], recHDD);
title('HDD Hamming - simulado, e limitantes superior e inferior teóricos')
xlabel('Eb/N0')
ylabel('Pb')
legend('ub', 'lb','simulado' )
grid on

%% Fig2
for Eb_No = -1:7
    Eb_No_lin = 10^(Eb_No/10);
    pc_ssd(Eb_No+2) = 7*qfunc(sqrt(2*3*codeHamming.R*Eb_No_lin)) + 7*qfunc(sqrt(2*4*codeHamming.R*Eb_No_lin)) + 1*qfunc(sqrt(2*7*codeHamming.R*Eb_No_lin));
end

figure
semilogy([-1:7], pc_ssd)
hold on
semilogy([-1:7], recSDD);
title('SDD - simulado, e limitante superior teórico')
legend('ub', 'simulado' )
xlabel('Eb/N0')
ylabel('Pb')
grid on

%% Fig3

for Eb_No = -1:7
    Eb_No_lin = 10^(Eb_No/10);
    p(Eb_No+2) = qfunc(sqrt(2*Eb_No_lin));
end

figure
semilogy([-1:7], recHDD)
hold on
semilogy([-1:7], recSDD);
hold on
semilogy([-1:7], p);

title(' HDD (simulado), SDD (simulado) e não-codificado (teórico)')
legend('HDD', 'SDD', 'nao codificado')
xlabel('Eb/N0')
ylabel('Pb')
grid on
