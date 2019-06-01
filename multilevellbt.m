function Yq = multilevellbt(step,X,N,s)

    % Returns the multi-level lbt of an image X
    % PARAMETERS: s is assymetry of POT 
    % Note: N must be the same for the forward and reverse multi-level
    % transforms          
    
    % N=4 may give the best lbt
    % or perhaps perform lbt until block size matches image size 
    
    I = length(X); % get dimension of image, assumed to be square
    CN = dct_ii(N);
    
    Yf = X; % initialise Yf, the final transform 
    
    % perform lbt until the result of the last stage gives sub-image sizes
    % that are greater than or equal to N i.e. I/N >= N 
    while I >= N^2
        
        X_sub = Yf(1:I,1:I); % next sub-image to perform lbt on 
        [Pf, ~] = pot_ii(N, s);

        t = [(1+N/2):(I-N/2)];
        Xp = X_sub; % Xp is POT of sub-image 
        Xp(t,:) = colxfm(Xp(t,:), Pf); 
        Xp(:,t) = colxfm(Xp(:,t)', Pf)';

        Y = colxfm(colxfm(Xp,CN)',CN)'; % Y is LBT of sub-image
        Yr = regroup(Y, N);
        
        Yf(1:I,1:I) = Y; % add new transformed sub-image to Yn 
        I = I / N; % update I to reflect size of next sub-image
        
    end
       I
    Yq = quantise(Yf, step);
    
    
return 

