function T = texture(I,u,r,th,b_w)
% Input: I --- image;
%        u --- characteristic function of different regions;
%        r --- radius of Kernel K;
%        th --- threshold; 
%
% Output: T_1 if b_w == 1; otherwise, T_2

% 
if b_w == 1
    I = double(I/max(I,[],'all')>th);
else
    I = double(I/max(I,[],'all')<th);
end

e = edge(I,'log');% find the edges
K = ones(2*r+1); %generate kernel
%compute T_1 or T_2
T = (conv2(u.*e,K,'same')+0.001)./(conv2(u.*I,K,'same')+0.001);
end