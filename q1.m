clear all; close all;

codeHamming.k = 4;
codeHamming.n = 7;
codeHamming.R = codeHamming.k/codeHamming.n;

%u = randi([0 1], 1, 4*1000);
%u = vec2mat(u,4);
u = [1 0 1 1]
G = [1 0 0 0 1 1 0; 0 1 0 0 1 0 1; 0 0 1 0 0 1 1; 0 0 0 1 1 1 1];

codeHamming.H = [1 1 0 1 1 0 0; 1 0 1 1 0 1 0; 0 1 1 1 0 0 1];
codeHamming.e = syndtable(codeHamming.H);%[0 0 0 0 0 0 0; 0 0 0 0 0 0 1; 0 0 0 0 0 1 0; 0 0 0 0 1 0 0; 0 0 0 1 0 0 0; 0 0 1 0 0 0 0; 0 1 0 0 0 0 0; 1 0 0 0 0 0 0];
codeHamming.sindromes = mod(codeHamming.e * codeHamming.H', 2);

c = mod(u*G,2);

b = mod(c + codeHamming.e(5,:),2);

recebido = decodificador(b, codeHamming)

