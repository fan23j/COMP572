%load images
venice3 = im2double(imread("../inputs/venice3.jpg"));
snow3 = im2double(imread("../inputs/snow3.jpg"));
%web: https://www.lynda.com/Photoshop-tutorials/Photoshop-Color-Correction-Low-Contrast/137893-2.html
bull = im2double(imread("../inputs/bull.jpg"));
%personal
dogL = im2double(imread("../inputs/dogL.jpg"));

%convert to hsv
venice3HSV = rgb2hsv(venice3);
v3h = venice3HSV(:,:,1);
v3s = venice3HSV(:,:,2);
%adjust value
v3v = imadjust((venice3HSV(:,:,3)-0.2)/0.3);
v3f = hsv2rgb(cat(3,v3h,v3s,v3v));

A = figure(1);
subplot(1,2,1);
imshow(v3f);
subplot(1,2,2);
imhist(v3f);
saveas(A, "outputs/veniceC.jpg");

snow3HSV = rgb2hsv(snow3);
s3h = snow3HSV(:,:,1);
s3s = snow3HSV(:,:,2);
s3v = imadjust((snow3HSV(:,:,3)-.45)/0.5);
s3f = hsv2rgb(cat(3,s3h,s3s,s3v));

B = figure(2);
subplot(1,2,1);
imshow(s3f);
subplot(1,2,2);
imhist(s3f); 
saveas(B, "outputs/snowC.jpg");

bullHSV = rgb2hsv(bull);
h = bullHSV(:,:,1);
s = bullHSV(:,:,2);
v = imadjust((bullHSV(:,:,3)-.2)/0.7);
f = hsv2rgb(cat(3,h,s,v));

C = figure(3);
subplot(1,2,1);
imshow(f);
subplot(1,2,2);
imhist(f);
saveas(C, "outputs/bullC.jpg");

dogLHSV = rgb2hsv(dogL);
dh = dogLHSV(:,:,1);
ds = dogLHSV(:,:,2);
dv = imadjust((dogLHSV(:,:,3)-.05)/2);
df = hsv2rgb(cat(3,dh,ds,dv));

D = figure(4);
subplot(1,2,1);
imshow(df);
subplot(1,2,2);
imhist(df);
saveas(D, "outputs/dogC.jpg");

