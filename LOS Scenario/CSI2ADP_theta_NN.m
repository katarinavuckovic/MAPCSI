function [ADP] = CSI2ADP_theta_NN(H,Ntt,Ncc,Nt,Nc)
%%
V = zeros(Nt,Ntt);
%theta = linspace(0,pi,Ntt);
for i = 1 : Nt
    for j = 1 : Ntt
        V(i,j) = exp(-1i * pi * (i) * cos(j*pi/Ntt));
    end 
end 

% Constructing F
F = zeros(Nc,Ncc);
%theta = linspace(0,1,Ncc);
for i = 1 : Nc
    for j = 1 : Ncc
        F(i,j) = exp(1i * 2 * pi * i * j / Ncc );
    end 
end 

ADP = V' * (H) * F ;
end