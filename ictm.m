% This implements the iterative convolution-thresholding method (ICTM) into
% SSCV.
% Ref:1. Dong Wang and Xiao-Ping Wang, The iterative
% convolution-thresholding method (ICTM) for image segmentation, 2020. 
% 2. Dong Wang, Haohan Li, Xiaoyu Wei, and Xiao-Ping Wang*, An efficient
% iterative thresholding method for image segmentation, J. Comput. Phys.,
% 350, 657-667, 2017.  
function y = ictm(I,lamda,dt,u,T_1,T_2)
change = 1;
iterNum = 50; % maximum number of iterations allowed
M = size(I,1); N = size(I,2);
u1 = u(:,:,1);u2 = u(:,:,2);
if nargin == 6
    u3 = u(:,:,3);
end
for n=1:iterNum
    if nargin == 5 % 2 segments
        %------------------------------------------------------------------
        c1 = sum(u1.*T_1,'all')/sum(u1,'all');
        c2 = sum(u2.*T_1,'all')/sum(u2,'all');
        f1 = (T_1 - c1).^2;f2 = (T_1 - c2).^2;
        [uh1,uh2] = HeatConv(dt,u1,u2);
        index1 = f1+lamda*uh2;
        index2 = f2+lamda*uh1;
        u1_af = double(index1<=index2);
        u2_af = 1-u1_af;
        change = sum(abs(u1_af(:)-u1(:)));
        u1 = u1_af;
        u2 = u2_af;
        % plot
            pause(0.001);
            imagesc(I, [0, 1]);colormap(gray);hold on;
            contour(u1,[0.5 0.5],'r','LineWidth',2);
            axis off; axis equal
            hold off;
        %------------------------------------------------------------------
        
    elseif nargin == 6 % 3 segments
        %------------------------------------------------------------------
        c11 = sum(u1.*T_1,'all')/sum(u1,'all');
        c21 = sum(u2.*T_1,'all')/sum(u2,'all');
        c31 = sum(u3.*T_1,'all')/sum(u3,'all');
        c12 = sum(u1.*T_2,'all')/sum(u1,'all');
        c22 = sum(u2.*T_2,'all')/sum(u2,'all');
        c32 = sum(u3.*T_2,'all')/sum(u3,'all');        
        f11 = (T_1 - c11).^2;f21 = (T_1 - c21).^2;f31 = (T_1 - c31).^2;
        f12 = (T_2 - c12).^2;f22 = (T_2 - c22).^2;f32 = (T_2 - c32).^2;
        [uh1,uh2,uh3] = HeatConv(dt,u1,u2,u3); % heat kernel convolution

        index1 = f11 + f12 -lamda*uh1;
        index2 = f21 + f22-lamda*uh2;
        index3 = f31 + f32-lamda*uh3;

        % -- thresholding: if ui is the largest value then ui=1 and
        % uj=0 for j!=i
        u1_af = double(index1<=index2).*double(index1<=index3);
        u2_af = double(index2<index1).*double(index2<=index3);
        u3_af = 1-u1_af-u2_af;

        change = norm(u1-u1_af) + norm(u2-u2_af);
        u1 = u1_af;
        u2 = u2_af;
        u3 = u3_af;
        
        % plot    
        pause(0.001);
        imagesc(I, [0, 1]);colormap(gray);hold on;
        contour(u1,[0.5 0.5],'r','LineWidth',2);
        contour(u2,[0.5 0.5],'r','LineWidth',2);    
        axis off; axis equal
        hold off;
        %------------------------------------------------------------------
    end
      
  
    if change<=M*N/100000
        break;
    end           
end
y = u;
if nargin == 5
    y(:,:,1) = u1; y(:,:,2) = u2;
elseif nargin == 6
    y(:,:,1) = u1; y(:,:,2) = u2; y(:,:,3) = u3;    
end
