hcf = halfcos(15); 

for i = 1:256
    Xf(i,:) = conv(X(i,:), hcf);
end

figure(1)
draw(X) % original 

figure(2)
draw(Xf(:,[1:256]+7)) % filtered

Xrf = convse(X, hcf); % row-filtered with symmetric extension
Xrcf = convse(Xrf', hcf)'; % then column filter - now fully filtered

Xcf = convse(X', hcf)';  % column-filtered first
Xcrf = convse(Xcf, hcf); % then row filter - now fully filtered

figure(3)
draw(Xrf)

figure(4)
draw(Xrcf)

figure(5)
draw(Xcrf)

max_abs_diff = max(max(abs(Xrcf - Xcrf)))


Xh = X - Xrcf;
figure(6)
draw(Xh)
% conv2 does 2-dimensional convolution - can be used to convolve ALL rows
% (unlike conv) when used with the argument 'same'
% convse means convolve symmetric extension 
% conv2se is the symmetric extension version of conv2
% a difference is observed between rc and cr filtering:
    % for N = 15 we get max_abs_diff = 1.1369e-13

