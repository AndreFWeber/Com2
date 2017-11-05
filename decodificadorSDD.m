function u_estimado = decodificadorSDD (r, code)

dists = r * code.cMod';

[M, s_idx] = max(dists);

c_estimado = code.c(s_idx,:);

u_estimado = c_estimado(1:code.k);

end