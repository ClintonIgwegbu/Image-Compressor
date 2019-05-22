function ratios = equal_mse_ratios_dwt(X, num_stages)
    X_test = zeros(size(X)); 
    n = num_stages;                     
    impulse = 100; 
    Y = nleveldwt(X_test, n);
    energy = ones(3,n+1); % make ones instead of zeros so that we don't 
                           % divide by zero in empty slots when calculating
                           % ratios
    % number of sub-images is 3n+1
    m = length(Y)/2;
    for i = 1:n
        Y(0.5*m, 1.5*m) = impulse;
        Z = nlevelidwt(Y, n); 
        energy(1,i) = sum(Z(:).^2); 
        Y(0.5*m, 1.5*m) = 0; 
        
        Y(1.5*m, 0.5*m) = impulse;
        Z = nlevelidwt(Y, n); 
        energy(2,i) = sum(Z(:).^2); 
        Y(1.5*m, 0.5*m) = 0;
        
        Y(1.5*m, 1.5*m) = impulse;
        Z = nlevelidwt(Y, n); 
        energy(3,i) = sum(Z(:).^2); 
        Y(1.5*m, 1.5*m) = 0;
        m=m/2; 
    end
    Y(m,m) = impulse;
    Z = nlevelidwt(Y, n);
    energy(1,n+1) = sum(Z(:).^2);
    Y(m,m) = 0;
    
    % arbitrarily take all ratios relative to final low pass image
    ratios = 1 ./ sqrt(energy./energy(1,n+1)); 

    return 
    
    
% ideally we expect that layer < num_stages
% I assume we let the impulse equal step size so that after quantisation
% the impulse has size of 1

% it seems that we are assuming the proportionality constant between the
% impulse size in a layer and the energy of the filtered pulse in the
% reconstructed image is the same regardless of the layer the pulse is
% placed in - but perhaps not necessarily the same across different pyramid
% sizes -  maybe the ratios between layers is different across pyramid
% sizes 
% I am treating y0 and x1 as the same layer, y1 and x2, etc. 

% apparently impulses in higher stages contribute more to energy in
% reconstruction - hence require smaller impulses for equal MSE - i.e. -
% the elements of the ratios matrix get progressively smaller 

