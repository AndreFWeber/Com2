function u_estimado = decodificador (b, code)


S = mod(b * code.H', 2);

[tf, s_idx] = ismember(S, code.sindromes, 'rows');

e_estimado = code.e(s_idx,:);

c_estimado = mod(b + e_estimado,2);

u_estimado = c_estimado(1:code.k);

end