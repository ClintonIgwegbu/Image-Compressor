function rms = get_rms_lbt(step,X,N,s)
    
    % Gets root mean squared value of reconstructed image
    
    I = length(X); % get dimension of image, assumed to be square
   
    [Pf, Pr] = pot_ii(N, s);

    t = [(1+N/2):(I-N/2)];
    Xp = X; % copy the non-transformed edges directly from X 
    Xp(t,:) = colxfm(Xp(t,:), Pf); 
    Xp(:,t) = colxfm(Xp(:,t)', Pf)';

    % dct transformation matrix of size N
    CN = dct_ii(N);

    Y = colxfm(colxfm(Xp,CN)',CN)';
    Yq = quantise(Y, step);
   
    Z = colxfm(colxfm(Yq',CN')',CN');
    Zp = Z; % copy the non-transformed edges directly from Z 
    Zp(:,t) = colxfm(Zp(:,t)', Pr')'; 
    Zp(t,:) = colxfm(Zp(t,:), Pr'); 
    
    rms = std(X(:) - Zp(:));
    
return 



