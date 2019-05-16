function [x1,x2,x3,x4,y0,y1,y2,y3] = pyenc(X, h)
    
    % encodes an image into a set of 4 high-pass images and 
    % a 1/256 size low-pass image 
    
    x1 = rowdec(rowdec(X, h)', h)';
    x2 = rowdec(rowdec(x1, h)', h)';
    x3 = rowdec(rowdec(x2, h)', h)';
    x4 = rowdec(rowdec(x3, h)', h)';

    y0 = X - rowint(rowint(x1, 2*h)', 2*h)';
    y1 = x1 - rowint(rowint(x2, 2*h)', 2*h)';
    y2 = x2 - rowint(rowint(x3, 2*h)', 2*h)';
    y3 = x3 - rowint(rowint(x4, 2*h)', 2*h)';
    
%     step = 17;
    
    % we quantise first then find the entropy 
%     h_x = bpp(quantise(X,step))
%     h_x1 = bpp(quantise(x1,step))
%     h_x2 = bpp(quantise(x2,step))
%     h_x3 = bpp(quantise(x3,step))
%     h_x4 = bpp(quantise(x4,step))
%     h_y0 = bpp(quantise(y0,step))
%     h_y1 = bpp(quantise(y1,step))
%     h_y2 = bpp(quantise(y2,step))
%     h_y3 = bpp(quantise(y3,step))
%     
%     x_bits = h_x * length(X(:));
%     x1_bits = h_x1 * length(x1(:));
%     x2_bits = h_x2 * length(x2(:));
%     x3_bits = h_x3 * length(x3(:));
%     x4_bits = h_x4 * length(x4(:));
%     y0_bits = h_y0 * length(y0(:));
%     y1_bits = h_y1 * length(y1(:));
%     y2_bits = h_y2 * length(y2(:));
%     y3_bits = h_y3 * length(y3(:));
%     

%     % compression ratio for single stage pyramid 
%     compression1 = (x1_bits + y0_bits) / x_bits
%     % 70.79% compression rate
%     
%     compression2 = (x2_bits + y0_bits + y1_bits) / x_bits
%     % 62.31 % compression rate
%     
%     compression3 = (x3_bits + y0_bits + y1_bits + y2_bits) / x_bits
%     % 60.41% compression rate
%     
%     compression4 = (x4_bits + y0_bits + y1_bits + y2_bits + y3_bits) ...
%         / x_bits
%     % 60.03% compression rate
    
    
    % There is a great improvement in compression rate between first and
    % second states (8%) but afterwards improvements diminish quickly 
    
return 