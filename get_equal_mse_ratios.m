function ratios = get_equal_mse_ratios(num_stages, X)
    X_test = zeros(size(X)); 
                             
    h = [0.25 0.5 0.25];
    
    impulse = 100; 
    [x1,x2,x3,x4,y0,y1,y2,y3] = pyenc(X_test, h);
    
    
    y0_impulse = y0; dim0 = floor(size(y0)/2); y0_impulse(dim0(1),dim0(1)) = impulse;
    y1_impulse = y1; dim1 = floor(size(y1)/2); y1_impulse(dim1(1),dim1(1)) = impulse;
    y2_impulse = y2; dim2 = floor(size(y2)/2); y2_impulse(dim2(1),dim2(1)) = impulse;
    y3_impulse = y3; dim3 = floor(size(y3)/2); y3_impulse(dim3(1),dim3(1)) = impulse;
    
            
%     % choose layer to place impulse
%     switch layer
%         case 0 
%             [r0,c0] = size(y0);
%             [r0,c0] = floor([r0,c0]/2);
%             y0(r0,c0) = impulse;
%             
%         case 1    
%             [r1,c1] = size(y1);
%             [r1,c1] = floor([r1,c1]/2);
%             y1(r1,c1) = impulse;
%             
%         case 2
%             [r2,c2] = size(y2);
%             [r2,c2] = floor([r2,c2]/2);
%             y2(r2,c2) =impulse;
%             
%         case 3
%             [r3,c3] = size(y3);
%             [r3,c3] = floor([r3,c3]/2);
%             y3(r3,c3) = impulse;
%             
%         otherwise
%             
%     end 
    
    % reconstruction algorithm depends on size of pyramid 
    switch num_stages
        case 0 
            ratios = 1;
        case 1
            z0 = py1dec(x1,y0_impulse,h);
            energy0 = sum(z0(:).^2);
            ratios = 1;
            
        case 2
            z0 = py2dec(x2,y0_impulse,y1,h);
            z1 = py2dec(x2,y0,y1_impulse,h);
            energy0 = sum(z0(:).^2);
            energy1 = sum(z1(:).^2);
            ratios = 1./sqrt([energy0 energy1]./energy0);
            
        case 3
            z0 = py3dec(x3,y0_impulse,y1,y2,h);
            z1 = py3dec(x3,y0,y1_impulse,y2,h);
            z2 = py3dec(x3,y0,y1,y2_impulse,h);
            energy0 = sum(z0(:).^2);
            energy1 = sum(z1(:).^2);
            energy2 = sum(z2(:).^2);
            ratios = 1./sqrt([energy0 energy1 energy2]./energy0);
          
        case 4
            z0 = py4dec(x4,y0_impulse,y1,y2,y3,h);
            z1 = py4dec(x4,y0,y1_impulse,y2,y3,h);
            z2 = py4dec(x4,y0,y1,y2_impulse,y3,h);
            z3 = py4dec(x4,y0,y1,y2,y3_impulse,h);
            energy0 = sum(z0(:).^2);
            energy1 = sum(z1(:).^2);
            energy2 = sum(z2(:).^2);
            energy3 = sum(z3(:).^2);
            ratios = 1./sqrt([energy0 energy1 energy2 energy3]./energy0);
            
        otherwise
    end 

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

