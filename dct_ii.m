function C = dct_ii(N)

% DCT_II Discrete Cosine Transform matrix
%
%  C = DCT_II(N) Generates the 1-D DCT transform matrix of size N,
%  such that Y = C * X transforms N-vector X into Y.
%  Uses an orthogonal Type-II DCT 

C = ones(N,N) / sqrt(N);
theta = ([1:N] - 0.5) * (pi/N);
g = sqrt(2/N);
for i=2:N,
  C(i,:) = g * cos((i-1) * theta);
end

return

% compare this implementation to handout on pgs. 14 and 15
% n is defined from 0 to N-1 meanwhile in theta assignment we have items
% from 1 to N. Call this p. So note that n + 0.5 = p - 0.5 where p = n+1
% i-1 and i=2:N gives the range of values of k.