function ratios = get_equal_mse_ratios(X, scheme, num_stages)

   switch scheme
       case 'pyramid'
           ratios = equal_mse_ratios_pyramid(X, num_stages);

       case 'dwt'
           ratios = equal_mse_ratios_dwt(X, num_stages);
   end 
   
   return 