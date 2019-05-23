Xsym = X - 128; N = 8; CN = dct_ii(N); 

Y = colxfm(colxfm(Xsym,CN)',CN)';

% draw(regroup(Y,N)/N);

step_X = 17;
step = get_optimum_step(17,Xsym,'dct',N,0,0,0,0,0.0001);

Xq = quantise(Xsym, step_X);
Yq = quantise(Y, step); 
Z = colxfm(colxfm(Yq',CN')',CN');

Yr = regroup(Yq,N)/N;
compression_ratio = 1/get_compression_rate(step_X,Xsym,'dct',N,0,0,0,0,0.0001)
num_bits = dctbpp(Yr, N) * 256^2

% compression ratio = 2.9416 for step_X = 17 and N = 8
% while num_bits = 7.7549e+04
% compression ratio = 2.8818 for step_X = 17 and N = 16
% while num_bits = 7.9158e+04 
% compression ratio = 2.6457 for step_X = 17 and N = 4
% while num_bits = 8.6222e+04 



figure(1)
draw(X)

figure(2)
draw(Xq)

figure(3)
draw(Z)
% % N=16 image is still much better visual quality than Xq - there are
% strange visual artefacts around tower though
% N=4 image is also better than Xq though it is grainer than N=16
% N=8 images is best visually - doesn't have N=16's image visual artefacts
% around tower and it offers the best (highest) compression ratio

% in each of the images above the NxN blocks can be seen in the
% reconstructed image - larger blocks for larger N - as opposed to smaller
% blocks after transform

% these images are much better visual quality than Xq even though they have
% the same rms values
% it must mean that quantising the transformed image results in retention
% of more information 
