function rate = get_rate_lbt(step_X, X, N, s, tol)
    
    step = get_optimum_step(step_X, X, 'lbt', N, 0, s, 0, 0, tol);
    h_x = bpp(quantise(X,step_X));
    
    I = length(X); % get dimension of image, assumed to be square
    [Pf, ~] = pot_ii(N, s);
    t = [(1+N/2):(I-N/2)];
    Xp = X; % copy the non-transformed edges directly from X 
    Xp(t,:) = colxfm(Xp(t,:), Pf); 
    Xp(:,t) = colxfm(Xp(:,t)', Pf)';
    
    CN = dct_ii(N);
    Y = colxfm(colxfm(Xp,CN)',CN)';
    Yq = quantise(Y, step);
    % DOES the two lines below apply to lbt?
    Yr = regroup(Yq,N)/N;
    
%     rate = dctbpp(Yr, N) / h_x;
    rate = dctbpp(Yr, 16) / h_x; % always code using 16x16 blocks 
        
return
