clear

% I = imread('tiger1.jpg');
% scale_factor = 0.5;             % image downscale factor
% area = [100 140 550 300];       % image region to train foreground with
% K = 16;                         % number of mixture components
% alpha = 8;                      % maximum edge cost
% sigma = 10;                     % edge cost decay factor

% I = imread('tiger2.jpg');
% scale_factor = 0.5;             % image downscale factor
% area = [160 80 410 220];        % image region to train foreground with
% K = 16;                          % number of mixture components
% alpha = 16;                    % maximum edge cost
% sigma = 4;                   % edge cost decay factor

I = imread('tiger3.jpg');
scale_factor = 0.5;             % image downscale factor
area = [200 100 450 250];       % image region to train foreground with
K = 16;                         % number of mixture components
alpha = 9;                    % maximum edge cost
sigma = 18;                     % edge cost decay factor


I = imresize(I, scale_factor);
Iback = I;
area = int16(area*scale_factor);
[ segm, prior ] = graphcut_segm(I, area, K, alpha, sigma);


[h,w,c] = size(I);
dw = area(3) - area(1) + 1;
dh = area(4) - area(2) + 1;
mask = uint8([zeros(area(2)-1,w); zeros(dh,area(1)-1), ones(dh,dw), zeros(dh,w-area(3)); zeros(h-area(4),w)]);


Inew = mean_segments(Iback, segm);
Iob = overlay_bounds(Iback, segm);

figure(2)
subplot(2,2,1); imshow(Inew);
subplot(2,2,2); imshow(Iob);
subplot(2,2,3); imshow(prior);
subplot(224); imshow(imoverlay(I, mask));
h = suptitle(sprintf('K=%i, alpha=%.1f, sigma=%.1f', K, alpha, sigma));
set(h, 'FontSize', 12)
