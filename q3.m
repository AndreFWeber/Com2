clear all; close all;

%%Para teste do codigo:

taps72a = [5 2];
taps72b = [5 4 2 1];

start = [1 0 0 0 0];

haykin72a = lfsr(taps72a, start);
haykin72b = lfsr(taps72b, start);

c = haykin72a*2-1;

%% 
pseudo_randi = randi([0 1], 1, 31);
c_pseudo = pseudo_randi*2-1

c = c';
c_pseudo = c_pseudo';

index = 1;

m = length(start);
N = 2^m-1;

for L=-3*N:+3*N
    c_L = circshift(c, L);
    c_L_pseudo = circshift(c_pseudo,L);
    Rc(index) = sum(c.*c_L)/(length(c));
    Rc_pseudo(index) = sum(c_pseudo.*c_L_pseudo)/(length(c_pseudo));
    index++;
end

figure(1)
plot(-3*N:+3*N, Rc)
hold on;
plot(-3*N:+3*N, Rc_pseudo, '-r')