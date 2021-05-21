close all;    % close all figure windows

I1=im2double(imread('Memorial_SourceImages/memorial0061.png'));
I2=im2double(imread('Memorial_SourceImages/memorial0062.png'));
I3=im2double(imread('Memorial_SourceImages/memorial0063.png'));
I4=im2double(imread('Memorial_SourceImages/memorial0064.png'));
I5=im2double(imread('Memorial_SourceImages/memorial0065.png'));
I6=im2double(imread('Memorial_SourceImages/memorial0066.png'));
I7=im2double(imread('Memorial_SourceImages/memorial0067.png'));
I8=im2double(imread('Memorial_SourceImages/memorial0068.png'));
I9=im2double(imread('Memorial_SourceImages/memorial0069.png'));
I10=im2double(imread('Memorial_SourceImages/memorial0070.png'));
I11=im2double(imread('Memorial_SourceImages/memorial0071.png'));
I12=im2double(imread('Memorial_SourceImages/memorial0072.png'));
I13=im2double(imread('Memorial_SourceImages/memorial0073.png'));
I14=im2double(imread('Memorial_SourceImages/memorial0074.png'));
I15=im2double(imread('Memorial_SourceImages/memorial0075.png'));
I16=im2double(imread('Memorial_SourceImages/memorial0076.png'));

ldrs = cat(4,I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15,I16);
exposures = [1/0.03125,1/0.0625,1/0.125,1/0.25,1/0.5,1,1/2,1/4,1/8,1/16,1/32,1/64,1/128,1/256,1/512,1/1024];

% Given a set of pixel values observed for several pixels in several
% images with different exposure times, this function returns the
% imaging system's response function g as well as the log film irradiance
% values for the observed pixels.
%
% Assumes:
%
% Zmin = 0
% Zmax = 255
%
% Arguments:
%
% Z(i,j) is the pixel values of pixel location number i in image j
% B(j) is the log delta t, or log shutter speed, for image j
% l is lamdba, the constant that determines the amount of smoothness
% w(z) is the weighting function value for pixel value z
% 
% Returns:
%
% g(z) is the log exposure corresponding to pixel value z
% lE(i) is the log film irradiance at pixel location i

%https://www.mathworks.com/matlabcentral/answers/465086-extracting-pixels-from-an-image-random
%random set of pixels
locations = randperm(numel(ldrs(:,:,1,1)),100);

ZR = zeros(100,16);
ZG = zeros(100,16);
ZB = zeros(100,16);

for i=1:16
    A = ldrs(:,:,:,i);
    R = A(:,:,1);
    G = A(:,:,2);
    B = A(:,:,3);
    
    R = R(locations);
    G = G(locations);
    B = B(locations);
    
    ZR(:,i) = R .* 255;
    ZG(:,i) = G .* 255;
    ZB(:,i) = B .* 255; 
end

[Rgs,RlEs] = gsolve_response(ZR,log(exposures),100,@w);
[Ggs,GlEs] = gsolve_response(ZG,log(exposures),100,@w);
[Bgs,BlEs] = gsolve_response(ZB,log(exposures),100,@w);

B = figure;
plot(Rgs,0:255,'--','color','red');
hold on
plot(Ggs,0:255,'-','color','green');
plot(Bgs,0:255,'-.','color','blue');  
hold off
title('Red(dashed),Green(solid),Blue(dash-dotted)');
saveas(B, './outputs/debevec_rf_estimate.jpg');

hdrs = zeros(size(ldrs));

final = gsolve_apply(Rgs,Ggs,Bgs,hdrs,ldrs,exposures,@w);
A = figure; imshow(final);
saveas(A,'./outputs/debevec_HDR_rf.jpg');

function hdr = gsolve_apply(Rgs,Ggs,Bgs,hdrs,ldrs,exposures, w)
    for i=1:16
        ldrs(:,:,:,i) = im2uint8(ldrs(:,:,:,i));
    end
    for i=1:16
        hdrs(:,:,1,i) = Rgs(ldrs(:,:,1,i)+1)- log(exposures(i));
    end
    for i=1:16
        hdrs(:,:,2,i) = Ggs(ldrs(:,:,2,i)+1)- log(exposures(i));
    end
    for i=1:16
        hdrs(:,:,3,i) = Bgs(ldrs(:,:,3,i)+1)- log(exposures(i));
    end
    w = w(ldrs);
    hdr = sum(hdrs .* w, 4) ./ sum(w,4);
    hdr = exp(hdr);
    hdr = tonemap(hdr, 'AdjustSaturation',3.0);
end

function weight = w(i)
    weight = double(128-abs(i-128));
end

function [g,lE] = gsolve_response(Z,B,l,w)
    n = 256;
    A = zeros(size(Z,1)*size(Z,2)+n+1,n+size(Z,1));
    b = zeros(size(A,1),1);
    % Include the data-fitting equations
    k = 1;
    for i=1:size(Z,1)
        for j=1:size(Z,2)
            wij = w(Z(i,j)+1);
            
            A(k,Z(i,j)+1) = wij;
            A(k,n+i) = -wij;
            b(k,1) = wij * B(j);
            k=k+1;
        end
    end
    % Fix the curve by setting its middle value to 0
    A(k,129) = 1;
    k=k+1;
    % Include the smoothness equations
    for i=1:n-2
        A(k,i)=l*w(i+1); A(k,i+1)=-2*l*w(i+1); A(k,i+2)=l*w(i+1);
        k=k+1;
    end
    % Solve the system using SVD
    x = A\b;
    g = x(1:n);
    lE = x(n+1:size(x,1));
end