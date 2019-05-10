function h = halfcos(N)

%HALFCOS  Half cosine function.
%  HALFCOS(N) is a half-cosine of length N samples. The amplitude
%  gives unit gain at zero frequency.

h = cos(([1:N]'/(N+1) - 0.5) * pi);
h = h / sum(h);
% for example if N=7, we want h to go from Gcos(-3pi/8), Gcos(-2pi/8,....,
% Gcos(2pi/8), Gcos(3pi/8).
% (1/8-1/2)pi = -3pi/8 etc....

return
% same eqn. given on pg. 6 of handout - just written differently 
% when the input is dc i.e. pixel value does not change spatially then the
% dc gain of the filter is given as the sum of filter coefficients. Say we
% take the fourier transform of the pixel array and the filter then instead
% of a convolution we have freq. domain pixel array times the filter in
% freq. domain. If pixel stuff has mag. of 0.2 for e.g. and output also has
% amp. of 0.2 then we know dc gain is 1 as given by sum of filter coeffs. 
