function Zf = multilevelilbt(Yq,N,s)

    % Returns the multi-level lbt of an image X
    % PARAMETERS: s is assymetry of POT 
    % Note: N must be the same for the forward and reverse multi-level
    % transforms 
    %     
    % VARIABLES: Yq is a single matrix that includes the transform of each 
    % sub-image stacked in a staircase (or lopsided pyramid) fashion
    % h, w are the height and width of Yq
    % m is a parameter used to locate each transformed sub-image within
    % Yq
    
    [h w] = size(Yq);
    I = w;
    
    % set the initial value of I 
    while I >= N
        I = I/N;
    end
    
    if I < N
        I = I*N;  
    end
    
    CN = dct_ii(N);
    [~, Pr] = pot_ii(N, s);
    
    Zf = Yq(1:I,1:I); % initialise Zf, the final transform
    
    % perform ilbt until the last image is equal to the width of Yq; 
    while I <= w 
        
        
        Yq_sup = Zf(1:I,1:I); % next super-image to perform ilbt on 

        Z = colxfm(colxfm(Yq_sup',CN')',CN');  
        
        t = [(1+N/2):(I-N/2)]; 
        Zp = Z; % Xp is reverse POT of super-image 
        Zp(:,t) = colxfm(Zp(:,t)', Pr')'; 
        Zp(t,:) = colxfm(Zp(t,:), Pr'); % Zp is ILBT of super-image
         
        Zf(1:I,1:I) = Zp; % add new transformed sub-image to Zf
        
        I = I * N; % update I to reflect size of next super-image
    end
        
    
return 

