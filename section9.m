Xsym =  X - 128;

h1 = [-1 2 6 2 -1]/8; 
h2 = [-1 2 -1]/4;

U = rowdec(X,h1); % decimate and allign with even columns
V = rowdec2(X,h2); % decimate and allign with odd columns

draw([U V])
size(U)
std(V(:) - U(:))

% relative standard deviations (related to relative energies):
% 

UU = rowdec(U',h1)';
UV = rowdec2(U',h2)'; 
VU = rowdec(V',h1)'; 
VV = rowdec2(V',h2)';

draw(1.8*[UU VU; UV VV]);

g1=[1 2 1]/2;
g2=[-1 -2 6 -2 -1]/4;
Ur = rowint(UU',g1)' + rowint2(UV',g2)';
Vr = rowint(VU',g1)' + rowint2(VV',g2)';

Xr = rowint(Ur,g1) + rowint2(Vr,g2);
% 
% Y = dwt(X); figure(1); draw(Y) 
% Xr = idwt(Y); figure(2); draw(Xr)

Y = nleveldwt(Xsym, 4); figure(1); draw(Y);
Z = nlevelidwt(Y, 4); figure(2); draw(Z); 

% constant quantisation step
step_X = 17; N = 8; num_stages = 4; equal_mse = 0; tol = 0.0001; 
step = get_optimum_step(step_X, Xsym, 'dwt', N, 0, 0, num_stages, equal_mse, tol); 

dwtstep = step * ones(3, n+1); 

% equal mse:
energy 







