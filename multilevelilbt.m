function Zf = multilevelilbt(Yq,N,s)

    % Returns the multi-level lbt of an image X
    % PARAMETERS: s is assymetry of POT 
    % Note: N must be the same for the forward and reverse multi-level
    % transforms 
    
    L = length(Yq);
    I = L;
    
    % set the initial value of I 
    while I > N
        I = I/N;
    end
    
    if I < N
        I = I*N;  
    end
    I
    CN = dct_ii(N);
    
    Zf = Yq; % initialise Zf, the final transform
    
    % perform ilbt until the result of the last stage is equal to the size
    % of the reconstructed image i.e. loop until I*N = L i.e.
    % loop for I <= L/N i.e. loop for I < L
    while I < L 
        
        Yq_sup = Zf(1:I,1:I); % next super-image to perform ilbt on 
        [~, Pr] = pot_ii(N, s);

        Z = colxfm(colxfm(Yq_sup',CN')',CN');  
        
        t = [(1+N/2):(I-N/2)]; 
        Zp = Z; % Xp is reverse POT of super-image 
        Zp(:,t) = colxfm(Zp(:,t)', Pr')'; 
        Zp(t,:) = colxfm(Zp(t,:), Pr'); % Zp is ILBT of super-image
         
        Zf(1:I,1:I) = Zp; % add new transformed sub-image to Zf 
        I = I * N; % update I to reflect size of next super-image
        
    end
        
    
return 

