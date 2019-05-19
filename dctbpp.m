function bits = dctbpp(Yr, N)

    % Calculate total number of bits from a regrouped image Yr given that
    % each subimage has dimension N
    
    [m,n] = size(Yr);
    p = m / N;
    q = n / N;
    bpp_Ys = zeros(8,8);
    bits = 0;
    for i = [0:N-1]
        for j = [0:N-1]
            % add entropy of Ys * number of bits in Ys
            bits = bits + bpp(Yr(i*p+1:(i+1)*p, j*q+1:(j+1)*q));
       
            bpp_Ys(i+1,j+1) = bpp(Yr(i*p+1:(i+1)*p, j*q+1:(j+1)*q));
%           bits = bits + bpp(Yr(i*p+1:(i+1)*p, j*q+1:(j+1)*q));
        end 
    end
    bpp_Ys; % show entropy of each sub-image
    % get rid of two lines below if total no. bits is wanted instead
    num_Ys = N^2;
    bits = bits / num_Ys;
return 

% each sub-image occupies an N by N square in Yr therefore the number of
% subimages is (no. pixels in Yr) / N^2 
% dimensions of Yr are assumed to be multiples of N for our purposes

% do they really want us to calculate the total number of bits or the bits
% per pixel?

% bpp(Yr) gives 1.6728
% dctbpp(Yr) ives 1.4872 i.e. lower entropy calculated when we evaluate
% each sub-image individually - this means that pixels within a sub-image
% are more closely correlated than pixels in different sub-images, as
% expected - therefore by evaluating each sub-image indivually there is
% more predictability in the pixel values - in this way DCT allows image
% compression 