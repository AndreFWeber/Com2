%Parte 1:
clear all; close all;

xk = [1 1 -1 -1 -1 1 -1 1]
xk_paralelo=reshape(xk, 4,2)

xk_paralelo_ifft =ifft(xk_paralelo)

A = xk_paralelo_ifft(3:4, :)

xk_paralelo_ciclico = [A;xk_paralelo_ifft]

xn = reshape(xk_paralelo_ciclico,1,[])

%parte 2

received_resh = reshape(xn,[],2)

semPC = received_resh(3:end,:)

fft_semPC = fft(semPC)


