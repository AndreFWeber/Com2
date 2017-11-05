clear all; close all;

code.k = 4;
code.n = 7;
code.R = code.k/code.n;

code.u = dec2bin([0:2^code.k-1]);
code.G = [1 0 0 0 1 1 0; 0 1 0 0 1 0 1; 0 0 1 0 0 1 1; 0 0 0 1 1 1 1];
code.c = mod(code.u(1:size(code.u,1),:)*code.G,2);
code.cMod = code.c*2-1;


r = awgn([0 1 1 1 0 0 1], 50);
r_polar = r*2-1;
recebido = decodificadorSDD(r_polar, code)