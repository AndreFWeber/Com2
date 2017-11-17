clear all;

n=2;
k=1;
m=2;
r = k/n;

trellis = poly2trellis([3],[7 5]);
msg = [0 1 1 0 0 1 0 0];
code = convenc(msg,trellis) 

b = [1 1 0 1 0 1 1 0 0 0 1 0 1 0 0 0];
tblen = 7;
decoded = vitdec(b,trellis,tblen,'term','hard') 



