function Y = convse(X, h)
%CONVSE Convolution with symmetrical extension
%  Y = CONVSE(X, H) Filters the rows of image X using H,
%  with symmetric extension of X.

narginchk(2,2);
nargoutchk(1,1);

[r, c] = size(X);
m = length(h);
m2 = fix((m)/2);

if rem(m,2) > 0
  % if filter is odd length
  xe = [((m2+1):-1:2)  (1:c)  (c-(1:m2))];
  % [m2+1 m2 ... 2  1 2 3 ... c  c-1 c-2 ... c-m2]
  
else
  % if filter is even length 
  xe = [(m2:-1:1) (1:c) (c+1-(1:m2))];
end

% row array of integers ranging from 0 to c-1 included
% t + i therefore gives each element of t with 1 added 
t = 0:(c-1);

Y = zeros(r,c); % same size as input image X initially

% convolve by multiplying filter at point, summing then shifting 
for i=1:m
  Y = Y + h(i) * X(:,xe(t+i));
end

return

% xe means X extended
% narginchk(low, high) gives error if number of input arguments is below 
% low or above high
% first if gives left-handed method (pg 8 handout) i.e. endpoints repeated
  % on left portion of list we are stopping at 2 therefore we count down
  % from m2+1 so that there is m2 elements on left of 1:c. Note that there
  % is also m2 elements on right of 1:c thus making the list symmetric 
% notation 1:2:5 returns [1 3 5]
% fix rounds down towards 0 whereas floor rounds towards negative inf