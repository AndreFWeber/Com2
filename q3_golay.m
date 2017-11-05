clear all; close all;

Ncw = 100000;

codeGolay.k = 12;
codeGolay.n = 23;
codeGolay.R = codeGolay.k/codeGolay.n;


codeGolay.u = de2bi([0:2^codeGolay.k-1]);
M=[1 0 0 1 1 1 0 0 0 1 1 1; 1 0 1 0 1 1 0 1 1 0 0 1; 1 0 1 1 0 1 1 0 1 0 1 0; 1 0 1 1 1 0 1 1 0 1 0 0; 1 1 0 0 1 1 1 0 1 1 0 0; 1 1 0 1 0 1 1 1 0 0 0 1; 1 1 0 1 1 0 0 1 1 0 1 0; 1 1 1 0 0 1 0 1 0 1 1 0; 1 1 1 0 1 0 1 0 0 0 1 1; 1 1 1 1 0 0 0 0 1 1 0 1; 0 1 1 1 1 1 1 1 1 1 1 1];
codeGolay.p = M';
codeGolay.G = [eye(codeGolay.k) codeGolay.p];
codeGolay.H = [codeGolay.p' eye(codeGolay.n-codeGolay.k)];
codeGolay.e = syndtable(codeGolay.H);
codeGolay.c = mod(codeGolay.u(1:size(codeGolay.u,1),:)*codeGolay.G,2);
codeGolay.cMod = codeGolay.c*2-1;
codeGolay.sindromes = mod(codeGolay.e * codeGolay.H', 2);

EscolhePalavrasRandom = randi([1 size(codeGolay.c,1)],1,Ncw);
palavrasEnviadas = codeGolay.c(EscolhePalavrasRandom(1:end),:);
palavrasEnviadas = palavrasEnviadas*2-1;

Eb = sum(sum(palavrasEnviadas.^2))/(Ncw*codeGolay.k);
%%
for Eb_No = -1:7
    norm = Eb/10^((Eb_No)/10);
    ruido = randn(length(palavrasEnviadas),codeGolay.n).*sqrt(norm/2);
    y_n = palavrasEnviadas + ruido;
    
    b_polar = y_n;
    b = b_polar > 0;
    
     for i = 1:1:size(palavrasEnviadas, 1)
       recebidoHDD(i,:) = decodificador(b(i,:), codeGolay);
       recebidoSDD(i,:) = decodificadorSDD(b_polar(i,:), codeGolay);
    end

    [num, recHDD(Eb_No+2)] = biterr(codeGolay.u(EscolhePalavrasRandom(1:end),:), recebidoHDD);
    [num, recSDD(Eb_No+2)] = biterr(codeGolay.u(EscolhePalavrasRandom(1:end),:), recebidoSDD);  
end

terminou=1
%% Fig1
for Eb_No = -1:7
    Eb_No_lin = 10^(Eb_No/10);
    Eb_No_Bruta = codeGolay.R * Eb_No_lin;
    p = qfunc(sqrt(2*Eb_No_Bruta));
    pc(Eb_No+2) = 1 - ( (1-p)^23 + 23*p*(1-p)^22 + 253*p^2*(1-p)^21 + 1771*p^3*(1-p)^20);
end

figure
semilogy([-1:7], pc)
hold on
semilogy([-1:7], pc/codeGolay.k)
hold on
semilogy([-1:7], recHDD);
title('HDD - simulado, e limitantes superior e inferior teóricos')
legend('ub', 'lb','simulado' )
xlabel('Eb/N0')
ylabel('Pb')
grid on

%% Fig2
% So usei esse codigo para achar os pesos das palavras...
for i=1:length(codeGolay.c)
   pesosGolay(:,i) = sum(codeGolay.c(i,:));
end
for w=1:max(pesosGolay)
    Aw(:,w)=sum(find(pesosGolay==w)>=0);
end

for Eb_No = -1:7
    Eb_No_lin = 10^(Eb_No/10);
    pc_ssd(Eb_No+2) = 253*qfunc(sqrt(2*7*codeGolay.R*Eb_No_lin)) + 506*qfunc(sqrt(2*8*codeGolay.R*Eb_No_lin)) + 1288*qfunc(sqrt(2*11*codeGolay.R*Eb_No_lin)) + 1288*qfunc(sqrt(2*12*codeGolay.R*Eb_No_lin)) + 506*qfunc(sqrt(2*15*codeGolay.R*Eb_No_lin)) + 253*qfunc(sqrt(2*16*codeGolay.R*Eb_No_lin)) + 1*qfunc(sqrt(2*23*codeGolay.R*Eb_No_lin));
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
