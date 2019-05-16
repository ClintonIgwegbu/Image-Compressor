function bpp = dctbpp(Yr, N)

    % Calculate the entropy of regrouped image Yr from its subimages Ys
    [m,n] = size(Yr);
    [p,q] = [m,n] / N;
    fs
    
return 

% each sub-image occupies an N by N square in Yr therefore the number of
% subimages is (no. pixels in Yr) / N^2 
% dimensions of Yr are assumed to be multiples of N for our purposes