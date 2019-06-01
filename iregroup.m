function Y = iregroup(Xr,N)

% IREGROUP change ordering of a matrix
%
%  Y = IREGROUP(X,N) Reverses the regroup function
%
%  If N is a 2-element vector, N(1) is used for the columns
%  and N(2) for the rows.

if length(N) < 2, N = [N; N]; end

[m,n] = size(Xr);

if rem(m,N(1)) ~= 0 | rem(n,N(2)) ~= 0,
  error('Error in iregroup: X dimensions are not multiples of N')
end

% Regroup row and column indices.
tm = reshape(reshape(1:m,m/N(1),N(1))',1,m);
tn = reshape(reshape(1:n,n/N(2),N(2))',1,n);

Y = Xr(tm,tn);

return
