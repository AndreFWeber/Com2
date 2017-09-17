function out = lfsr (taps, start)

M = length(start);
t = length(taps);

loop_index = t-2;
tap_index = 3;

atual = start;

out = [];

while true
  out = [out atual(M)];
  xor_result = xor(atual(taps(1)), atual(taps(2)));

  while loop_index > 0
    xor_result = xor(xor_result, atual(taps(tap_index)));
    loop_index--;
    tap_index++;  
  end
  loop_index = t-2;
  tap_index = 3;
  
  atual = [xor_result atual(1:M-1)];
    
  if(atual==start)
    break;
  end
end

endfunction
