clc; clear; close all;
addpath('./image');
flag = 3;
%-------------------------------------------------------------------------------
switch flag
    case 1
        NS = 2; % number of segments
        I = imread('d1.jpg');Img = I;
        P = rgb2gray(uint8(I));% transfer the given RGB image to gray image
        P = double(P);
        M = size(I,1); N = size(I,2);
        P = P./max(max(abs(P)));% normalization
        I = P;
        % set parameters
        dt = 0.01;  % time step
        lambda = 0.0001;
        lamda = lambda * sqrt(pi)/sqrt(dt);
        %compute T_1 or T_2
        T = texture(I,ones(M,N),40,0.3,1);
        % select initial contour
        u = zeros(M,N,NS);
        u(100:600,100:600,1) = 1;
        u(:,:,2) = 1- u(:,:,1);
    case 2   
        NS = 2; % number of segments
        I = imread('d2.jpg');Img = I;
        P = rgb2gray(uint8(I));% transfer the given RGB image to gray image
        P = double(P);
        M = size(I,1); N = size(I,2);
        P = P./max(max(abs(P)));% normalization
        I = P;
        % set parameters
        dt = 0.01;  % time step
        lambda = 0.0005;
        lamda = lambda * sqrt(pi)/sqrt(dt);
        %compute T_1 or T_2
        T = texture(I,ones(M,N),50,0.3,0);
        % select initial contour
        u = zeros(M,N,NS);
        u(100:600,100:600,1) = 1;
        u(:,:,2) = 1- u(:,:,1);
    case 3   
        NS = 3; % number of segments
        I = imread('d3.png');Img = I;
        P = rgb2gray(uint8(I));% transfer the given RGB image to gray image
        P = double(P);
        M = size(I,1); N = size(I,2);
        P = P./max(max(abs(P)));% normalization
        I = P;
        % set parameters
        dt = 0.01;  % time step
        lambda = 0.0001;
        lamda = lambda * sqrt(pi)/sqrt(dt);
        %compute T_1 and T_2
        T_1 = texture(I,ones(M,N),40,0.3,1);T_2 = texture(I,ones(M,N),80,0.3,0);
        % select initial contour    
        u = zeros(M,N,NS);
        u(1:M,1:300,1) = 1;
        u(1:M,301:600,2) = 1;
        u(:,:,3) = 1 - u(:,:,1) - u(:,:,2);  
end
%--------------------------------------------------------------------------

% employ ICTM to partition the given image
if NS == 2
    u = ictm(I,lamda,dt,u,T);
elseif NS == 3
    u = ictm(I,lamda,dt,u,T_1,T_2);
end

% plot 
if NS == 2
    imagesc(Img, [0, 255]);colormap(gray);hold on; axis off; axis image
    [c,h] = contour(u(:,:,1),[0.5 0.5],'r','LineWidth',2);
    figure;imagesc(I, [0, 1]);hold on;axis off;
    contourf(u(:,:,1)*0 + u(:,:,2));
elseif NS == 3
    imagesc(Img, [0, 255]);colormap(gray);hold on; axis off; axis image
    [c,h] = contour(u(:,:,1),[0.5 0.5],'r','LineWidth',2);
    [c,h] = contour(u(:,:,2),[0.5 0.5],'r','LineWidth',2);
    figure;imagesc(I, [0, 1]);hold on;axis off;
    contourf(u(:,:,1)*0 + u(:,:,2)*0.5 + u(:,:,3));
end
