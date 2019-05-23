C8 = dct_ii(8); 
plot(C8');

Xsym = X - 128; % ensure X has zero-mean otherwise dc coefficients of transform 
             % would be purely positive and others would be symmetrically
             % distributed about 0 - why is this problematic? how does this
             % make X zero mean anyway?
             
          
Y = colxfm(colxfm(Xsym,C8)',C8)';

N = 8; draw(regroup(Y,N)/N); % divide by N to counter gain of DCT transform

Z = colxfm(colxfm(Y',C8')',C8'); draw(Z);
max(abs(Xsym(:)-Z(:))); % gives 6.1107e-13
% 
bases = [zeros(1,8); C8'; zeros(1,8)]; 
draw(255*bases(:)*bases(:)');
% 
% step = 17;
% Yq = quantise(Y, step); 
% Yr = regroup(Yq,N)/N; 
% draw(Yr)
% bpp(Yr); % gives 1.6728 i.e. 1.0963e+05 total bits
% dctbpp(Yr, N); % gives 1.4872 i.e. 9.7467e+04 bits
% bpp(Yr) / dctbpp(Yr, N); % 1.1248
% 
% Z = colxfm(colxfm(Yq',C8')',C8');
% Xq = quantise(Xsym, step);
% std(Xsym(:) - Z(:)); % gives 3.7568
% std(Xsym(:) - Xq(:)); % gives 4.8612 LARGER than that above? why?





% It can be be observed from the saved figure, regroupY, that the energy of
% increasing frequency components is lower i.e. there is less content in
% the images. Distribution in images: lower frequency images have less
% content (i.e. grey for the most part) so higher prob. mass for this grey
% background colour i.e. it is expected that the entropy decreases with
% increasing frequency so shorter code lengths for sub-images of high freq. images
% this can be verified by displaying bpp_Ys given in dct_bpp
% note that inverse transform is performed on Y not the regrouped Y 

