clear all;

n=2;
k=1;
m=2;
r = k/n;

L = 200;
Nq = 1000;

tblen=15;

trellis = poly2trellis(3,[7 5]);
%msg = [0 1 1 0 0 1 0 0];
msg = randi([0 1],Nq, L*k);
msg_original = msg;
msg = [msg repmat(0, [Nq m*k])];


for i = 1:Nq 
    code(i,:) = convenc(msg(i,:),trellis) ;
end
code_polar = code*(-2)+1;

Eb = sum(sum(code_polar.^2))/(Nq*L);

%%
for Eb_No = -1:7
    norm = Eb/10^((Eb_No)/10)
    ruido = randn(Nq,size(code_polar,2)).*sqrt(norm/2);
    y_n = code_polar + ruido;
    
    b_polar = y_n;
    b = b_polar < 0;
   
    for i = 1:Nq 
        decodedHDD(i,:) = vitdec(b(i,:),trellis,tblen,'term','hard') ;
        decodedSDD(i,:) = vitdec(b_polar(i,:),trellis,tblen,'term','unquant') ;
    end

    [num, recHDD(Eb_No+2)] = biterr(decodedHDD(:,1:end-(k*m)),msg_original);
    [num, recSDD(Eb_No+2)] = biterr(decodedSDD(:,1:end-(k*m)),msg_original);     
end

%% teorico
for Eb_No = -1:7
    Eb_No_lin = 10^(Eb_No/10);
    p(Eb_No+2) = qfunc(sqrt(2*Eb_No_lin));
end
%%
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