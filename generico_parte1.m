%Parte 1 - Generico

xk = [1 1 -1 -1 -1 1 -1 1]
N = 4
u = 2

col = (length(xk)/N)

xk_paralelo=reshape(xk, N, [])

xk_ifft = ifft(xk_paralelo)

A = xk_paralelo_ifft(3:4, :)

xk_paralelo_ciclico = [A;xk_paralelo_ifft]

xk_paralelo_final = reshape(xk_paralelo_ciclico,1,12)

%%

%% Questão 01
clear all; close all; 
X = [1 1 -1 -1 -1 1 -1 1];
N = 4;
u = 2;

size_pc = (length(X)/N)-1;

x_par = reshape(X, N, u);

x_dft = ifft(x_par);

PC = x_dft(end-size_pc:end,:);

x_n = [PC; x_dft];

x_serial = reshape(x_n, 1, []);

%% Questão 02

h_n = [1];

% y_n = filter(x_serial, h_n);

y_n_par = reshape(y_n,[],u);

y_without_PC = y_n_par(u+1:end,:);

y_fft = fft(y_without_PC);

y_fft_serial = reshape(y_fft,1,[]);

h_fft = fft(h_n);

X_equa = y_fft_serial/h_fft;


%% Truque de ferramentas

repmat(b,1,2)
A = [1 2; 3 4; 5 6]
A ./ repmat(b,1,2)
