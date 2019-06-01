function Yq = multilevellbt(step,X,N,s)

    % Returns the multi-level lbt of an image X
    % PARAMETERS: s is assymetry of POT 
    % Note: N must be the same for the forward and reverse multi-level
    % transforms          
    %
    % VARIABLES: Yf is a single matrix that includes the transform of each 
    % sub-image stacked in a staircase (or lopsided pyramid) fashion
    % h, w are the height and width of Yf
    % m is a parameter used to locate each transformed sub-image within
    % Yf
    
    % will this only work on images that are power of 2 in size?
    % perhaps quantise each sub-image using different step 
    % N=4 may give the best lbt
    % or perhaps perform lbt until block size matches image size 
    
    w = length(X); h = 0; % get dimension of image, assumed to be square
    I = w;
    [Pf, ~] = pot_ii(N, s);
    CN = dct_ii(N);
    
%     Yf = X; 
    
    while I>= N
        h = h + I;
        I = I / N;
    end
    I = w; % reset I
    Yf = zeros(h, w); 
    Yr = X;
    m = h - w; 
    
    
    % keep performing lbt as long as smallest transformed image is larger
    % than N i.e. while I >= N 
  
    while I >= N
        
        X_sub = Yr(1:I,1:I); % next sub-image to perform lbt on 
        
        t = [(1+N/2):(I-N/2)];
        Xp = X_sub; % Xp is POT of sub-image 
        Xp(t,:) = colxfm(Xp(t,:), Pf); 
        Xp(:,t) = colxfm(Xp(:,t)', Pf)';

        Y = colxfm(colxfm(Xp,CN)',CN)'; % Y is LBT of sub-image
        Yf(m+1:I,1:I) = Y; % add new transformed sub-image to Yf
        
        % avoid redundant regrouping in final iteration 
        if I/N >= N 
            Yr = regroup(Y, N);
        end  
        
        I = I / N; % update I to reflect size of next sub-image
        m = m - I;
    end
       
    Yq = quantise(Yf, step);
    
    
return 

