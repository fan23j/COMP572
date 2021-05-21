%load images
venice2 = im2double(imread("inputs/venice2.jpg"));
snow2 = im2double(imread("inputs/snow2.jpg"));
%web: https://www.summitprintingpro.com/graphic-design/tutorials/white-balance-correction.html
scene = im2double(imread("inputs/scene.jpeg"));
%personal
light = im2double(imread("inputs/light.jpg"));

%white balancing

%separate components
veniceR1 = venice2(:,:,1);
veniceG1 = venice2(:,:,2);
veniceB1 = venice2(:,:,3);
%compute component average
veniceRM = mean2(veniceR1);
veniceGM = mean2(veniceG1);
veniceBM = mean2(veniceB1);
%compute overall average
veniceOA = (veniceRM + veniceGM + veniceBM)/3;
veniceOR = (veniceR1/veniceRM)*veniceOA;
veniceOG = (veniceG1/veniceGM)*veniceOA;
veniceOB = (veniceB1/veniceBM)*veniceOA;
veniceO = cat(3, veniceOR, veniceOG, veniceOB);
A = figure(1);
subplot(1,2,1);
imshow(venice2);
subplot(1,2,2);
imshow(veniceO);
%write image
saveas(A, "outputs/veniceB.jpg");

snowR1 = snow2(:,:,1);
snowG1 = snow2(:,:,2);
snowB1 = snow2(:,:,3);
snowRM = mean2(snowR1);
snowGM = mean2(snowG1);
snowBM = mean2(snowB1);
snowOA = (snowRM + snowGM + snowBM)/3;
snowOR = (snowR1/snowRM)*snowOA;
snowOG = (snowG1/snowGM)*snowOA;
snowOB = (snowB1/snowBM)*snowOA;
snowO = cat(3, snowOR, snowOG, snowOB);
B = figure(2);
subplot(1,2,1);
imshow(snow2);
subplot(1,2,2);
imshow(snowO);
saveas(B, "outputs/snowB.jpg");

sceneR = scene(:,:,1);
sceneG = scene(:,:,2);
sceneB = scene(:,:,3);
sceneRM = mean2(sceneR);
sceneGM = mean2(sceneG);
sceneBM = mean2(sceneB);
sceneOA = (sceneRM + sceneGM + sceneBM)/3;
sceneOR = (sceneR/sceneRM)*sceneOA;
sceneOG = (sceneG/sceneGM)*sceneOA;
sceneOB = (sceneB/sceneBM)*sceneOA;
sceneO = cat(3, sceneOR, sceneOG, sceneOB);
C = figure(3);
subplot(1,2,1);
imshow(scene);
subplot(1,2,2);
imshow(sceneO);
saveas(C, "outputs/sceneB.jpg");

lightR = light(:,:,1);
lightG = light(:,:,2);
lightB = light(:,:,3);
lightRM = mean2(lightR);
lightGM = mean2(lightG);
lightBM = mean2(lightB);
lightOA = (lightRM + lightGM + lightBM)/3;
lightOR = (lightR/lightRM)*lightOA;
lightOG = (lightG/lightGM)*lightOA;
lightOB = (lightB/lightBM)*lightOA;
lightO = cat(3, lightOR, lightOG, lightOB);
D = figure(4);
subplot(1,2,1);
imshow(light);
subplot(1,2,2);
imshow(lightO);
saveas(D, "outputs/lightB.jpg");