
Xsym = X-128; 
N=8; s=1.4051; I=256;
CN = dct_ii(N);
% what does scaling factor, s, do?
% s determines the degree of BI-ORTHOGONALITY> If s=1 then Pf=Pr otherwise
% 1<s<2 weights the relative contributions of Pf and Pr un-equally. 

step_X = 17;
step = get_optimum_step(step_X,X,'lbt',N,0,s,0,0,0.0001);
[Pf, Pr] = pot_ii(N, s);

t = [(1+N/2):(I-N/2)]; % N is the DCT size, I is the image size
Xq = quantise(Xsym, step_X); 
Xp = Xsym; % copy the non-transformed edges directly from X 
Xp(t,:) = colxfm(Xp(t,:), Pf); 
Xp(:,t) = colxfm(Xp(:,t)', Pf)'; 

%Xp = 0.5*Xp; %figure(1), draw(Xp);
% bases = [Pf'];
% bases = [zeros(1,8); Pf'; zeros(1,8)];
%figure(1), draw(255*bases);
bases = [zeros(1,N); Pf'; zeros(1,N)]; 
%figure(2), draw(255*bases(:)*bases(:)');

Y = colxfm(colxfm(Xp,CN)',CN)';
Yq = quantise(Y, step); 
Z = colxfm(colxfm(Yq',CN')',CN');

Zp = Z; % copy the non-transformed edges directly from Z 
Zp(:,t) = colxfm(Zp(:,t)', Pr')'; 
Zp(t,:) = colxfm(Zp(t,:), Pr'); 

figure(1); draw(Xsym); figure(2); draw(Xq); figure(3); draw(Zp);
%max(abs(Xsym(:) - Zp(:))); % when Y is not quantised gives 7.6739e-13 
                            % -> images are the same


compression_ratio = 1/get_compression_rate(step_X,Xsym,'lbt',N,0,s,0,0,0.0001)


% find ballpark value of s that maximises step and compression ratio
% for s = [1:0.1:2]
%     s;
%     step = get_optimum_step(step_X,X,'lbt',N,0,s,0,0,0.0001);
%     compression_ratio = 1/get_compression_rate(step_X,Xsym,'lbt',N,0,s,0,0,0.0001);
% end

% for N=8 and step_X=17
% s=1.4051 appears to give the highest compression ratio i.e. 3.1358
% s=1.80202 gives the highest step size i.e. 27.0792

% the line [zeros(1,8); Pf'; zeros(1,8)] lays a row of zeros above and
% below Pf'. Remember that A(:) gives a column vector formed by lining up
% the column vectors of matrix A. Therefore bases(:) gives the column
% vectors of Pf' (row vectors of Pf) separated by 2 zeros in a tall
% vertical stack. We scale up by 255 to display this properly then we take
% the outer product of bases(:) with its tranpose. 

