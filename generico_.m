%% Questão 01
clear all; close all; 

X = [1 1 -1 -1 -1 1 -1 1]; %ENTRADA
N = 4;%ENTRADA
u = 2;%ENTRADA

X_par = reshape(X, N, []);
x_dft = ifft(X_par);

PC = x_dft(end-u+1:end,:);

x_n = [PC; x_dft];

x_serial = reshape(x_n, 1, []);

%% Questão 02

y_n = x_serial;%ENTRADA
h_n= [1 0.25];%ENTRADA


y_n_par = reshape(y_n, N+u,[]);

y_without_PC = y_n_par(u+1:end,:);

Y_fft = fft(y_without_PC);

Y_fft_serial = reshape(Y_fft,1,[]);

H_fft = fft(h_n);

X_equa = Y_fft_serial./repmat(H_fft,1,N)