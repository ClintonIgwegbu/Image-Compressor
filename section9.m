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





