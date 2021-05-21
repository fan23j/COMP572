camel = im2double(imread("./inputs/camel.jpg"));
cathedral = im2double(imread("./inputs/cathedral.jpg"));
chapel = im2double(imread("./inputs/chapel.jpg"));
courtyard = im2double(imread("./inputs/courtyard.jpg"));
emir = im2double(imread("./inputs/emir.jpg"));
gruppa = im2double(imread("./inputs/gruppa.jpg"));
khan = im2double(imread("./inputs/khan.jpg"));
monastery = im2double(imread("./inputs/monastery.jpg"));
nativity = im2double(imread("./inputs/nativity.jpg"));
railroad = im2double(imread("./inputs/railroad.jpg"));
settlers = im2double(imread("./inputs/settlers.jpg"));
urn = im2double(imread("./inputs/urn.jpg"));
%{
inputs = [camel,cathedral,chapel,courtyard,emir,gruppa,khan,monastery,nativity,railroad,settlers,urn];
sinputs = ["camel","cathedral","chapel","courtyard","emir","gruppa","khan","monastery","nativity","railroad","settlers","urn"];

for i = 1:12
    x = align_basic(inputs(i));
    figure; imshow(x)
    saveas(x, sprintf('./part1/%s.png',sinputs(i)));
end

for i = 1:12
    x = align_basic(inputs(i));
    figure; imshow(x)
    saveas(x, sprintf('./part2/%s.png',sinputs(i)));
end
%}
%{
camel1 = align_basic(camel);
A = figure; imshow(camel1)
saveas(A, "./part1/camel.jpg");

cathedral1 = align_basic(cathedral);
A = figure; imshow(cathedral1)
saveas(A, "./part1/cathedral.jpg");

chapel1 = align_basic(chapel);
A = figure; imshow(chapel1)
saveas(A, "./part1/chapel.jpg");

courtyard1 = align_basic(courtyard);
A = figure; imshow(courtyard1)
saveas(A, "./part1/courtyard.jpg");

emir1 = align_basic(emir);
A = figure; imshow(emir1)
saveas(A, "./part1/emir.jpg");

gruppa1 = align_basic(gruppa);
A = figure; imshow(gruppa1)
saveas(A, "./part1/gruppa.jpg");

khan1 = align_basic(khan);
A = figure; imshow(khan1)
saveas(A, "./part1/khan.jpg");

monastery1 = align_basic(monastery);
A = figure; imshow(monastery1)
saveas(A, "./part1/monastery.jpg");

nativity1 = align_basic(nativity);
A = figure; imshow(nativity1)
saveas(A, "./part1/nativity.jpg");

railroad1 = align_basic(railroad);
A = figure; imshow(railroad1)
saveas(A, "./part1/railroad.jpg");

settlers1 = align_basic(settlers);
A = figure; imshow(settlers1)
saveas(A, "./part1/settlers.jpg");

urn1 = align_basic(urn);
A = figure; imshow(urn1)
saveas(A, "./part1/urn.jpg");

camel2 = align_better(camel);
A = figure; imshow(camel2)
saveas(A, "./part2/camel.jpg");

cathedral2 = align_better(cathedral);
A = figure; imshow(cathedral2)
saveas(A, "./part2/cathedral.jpg");

chapel2 = align_better(chapel);
A = figure; imshow(chapel2)
saveas(A, "./part2/chapel.jpg");

courtyard2 = align_better(courtyard);
A = figure; imshow(courtyard2)
saveas(A, "./part2/courtyard.jpg");

emir2 = align_better(emir);
A = figure; imshow(emir2)
saveas(A, "./part2/emir.jpg");

gruppa2 = align_better(gruppa);
A = figure; imshow(gruppa2)
saveas(A, "./part2/gruppa.jpg");

khan2 = align_better(khan);
A = figure; imshow(khan2)
saveas(A, "./part2/khan.jpg");

monastery2 = align_better(monastery);
A = figure; imshow(monastery2)
saveas(A, "./part2/monastery.jpg");

nativity2 = align_better(nativity);
A = figure; imshow(nativity2)
saveas(A, "./part2/nativity.jpg");

railroad2 = align_better(railroad);
A = figure; imshow(railroad2)
saveas(A, "./part2/railroad.jpg");

settlers2 = align_better(settlers);
A = figure; imshow(settlers2)
saveas(A, "./part2/settlers.jpg");

urn2 = align_better(urn);
A = figure; imshow(urn2)
saveas(A, "./part2/urn.jpg");
%}
camel3 = align_final(camel);
A = figure; imshow(camel3)
saveas(A, "./part3/camel.jpg");

cathedral3 = align_final(cathedral);
A = figure; imshow(cathedral3)
saveas(A, "./part3/cathedral.jpg");

chapel3 = align_final(chapel);
A = figure; imshow(chapel3)
saveas(A, "./part3/chapel.jpg");

courtyard3 = align_final(courtyard);
A = figure; imshow(courtyard3)
saveas(A, "./part3/courtyard.jpg");

emir3 = align_final(emir);
A = figure; imshow(emir3)
saveas(A, "./part3/emir.jpg");

gruppa3 = align_final(gruppa);
A = figure; imshow(gruppa3)
saveas(A, "./part3/gruppa.jpg");

khan3 = align_final(khan);
A = figure; imshow(khan3)
saveas(A, "./part3/khan.jpg");

monastery3 = align_final(monastery);
A = figure; imshow(monastery3)
saveas(A, "./part3/monastery.jpg");

nativity3 = align_final(nativity);
A = figure; imshow(nativity3)
saveas(A, "./part3/nativity.jpg");

railroad3 = align_final(railroad);
A = figure; imshow(railroad3)
saveas(A, "./part3/railroad.jpg");

settlers3 = align_final(settlers);
A = figure; imshow(settlers3)
saveas(A, "./part3/settlers.jpg");

urn3 = align_final(urn);
A = figure; imshow(urn3)
saveas(A, "./part3/urn.jpg");

function [I,row_beg,row_end,col_beg,col_end] = align_final(x)
    I = align_better(x);
    Im = mean(x,'all');
    Is = std(x,0,'all');
    row_rm = mean(I(:,:,1),2);
    row_gm = mean(I(:,:,2),2);
    row_bm = mean(I(:,:,3),2);
    col_rm = mean(I(:,:,1));
    col_gm = mean(I(:,:,2));
    col_bm = mean(I(:,:,3));
    low = Im - Is;
    high = Im + Is;
    i = 1;
    while i <= height(I)
        if row_rm(i) <= low || row_rm(i) >= high
            row_rm(i) = 0;
            i=i+1;
        else
            row_rm(i) = 1;
            i=i+1;
        end
    end
    i=1;
    while i <= height(I)
        if row_gm(i) <= low || row_gm(i) >= high
            row_gm(i) = 0;
            i=i+1;
        else
            row_gm(i) = 1;
            i=i+1;
        end
    end
    i=1;
    while i <= height(I)
        if row_bm(i) <= low || row_bm(i) >= high
            row_bm(i) = 0;
            i=i+1;
        else
            row_bm(i) = 1;
            i=i+1;
        end
    end
    i=1;
    while i <= width(I)
        if col_rm(i) <= low || col_rm(i) >= high
            col_rm(i) = 0;
            i=i+1;
        else
            col_rm(i) = 1;
            i=i+1;
        end
    end
    i=1;
    while i <= width(I)
        if col_gm(i) <= low || col_gm(i) >= high
            col_gm(i) = 0;
            i=i+1;
        else
            col_gm(i) = 1;
            i=i+1;
        end
    end
    i=1;
    while i <= width(I)
        if col_bm(i) <= low || col_bm(i) >= high
            col_bm(i) = 0;
            i=i+1;
        else
            col_bm(i) = 1;
            i=i+1;
        end
    end
    row_beg = 0;
    row_end = 0;
    col_beg = 0;
    col_end = 0;
    for i = 1:ceil(height(I)*0.1)
       if row_rm(i) == 0 || row_gm(i) == 0 || row_bm(i) == 0
           row_beg = i;
       end
    end
    for i = 1:ceil(width(I)*0.1)
       if col_rm(i) == 0 || col_gm(i) == 0 || col_bm(i) == 0
           col_beg = i;
       end
    end
    for i = height(I):-1:ceil(height(I)*0.9)
        if row_rm(i) == 0 || row_gm(i) == 0 || row_bm(i) == 0
            row_end = i;
        end
    end
    for i=width(I):-1:ceil(width(I)*0.9)
        if col_rm(i) == 0 || col_gm(i) == 0 || col_bm(i) == 0
            col_end = i;
        end
    end  
    I = imcrop(I,[col_beg,row_beg,col_end-col_beg,row_end-row_beg]);
        
end

function I = align_better(x)
    [b,g,r] = cropBetter(x);
    [b1,g1,r1] = cropImage(x);
    r_g = normxcorr2(r,g);
    [ypeak, xpeak] = find(r_g==max(r_g(:)));
    yoffSet = ypeak-size(g,1);
    yoffSet = max(min(yoffSet,30),-30);
    xoffSet = xpeak-size(g,2);
    xoffSet = max(min(xoffSet,30),-30);
    r1 = imtranslate(r1,[xoffSet,yoffSet]);
    b_g = normxcorr2(b,g);
    [ypeak, xpeak] = find(b_g==max(b_g(:)));
    yoffSet = ypeak-size(g,1);
    yoffSet = max(min(yoffSet,30),-30);
    xoffSet = xpeak-size(g,2);
    xoffSet = max(min(xoffSet,30),-30);
    b1 = imtranslate(b1,[xoffSet,yoffSet]);
    I(:,:,1) = r1;
    I(:,:,2) = g1;
    I(:,:,3) = b1;
end

function [b,g,r] = cropBetter(I)
    ri = imcrop(I,[0 682 width(I) 341]);
    r = imcrop(ri,[80 68 240 204]);
    gi = imcrop(I, [0 341 width(I) 341]);
    g = imcrop(gi,[80 68 240 204]);
    bi = imcrop(I, [0 0 width(I) 342]);
    b = imcrop(bi,[80 68 240 204]);
end

function [b,g,r] = cropImage(I)
    r = imcrop(I,[0 682 width(I) 341]);
    g = imcrop(I, [0 341 width(I) 341]);
    b = imcrop(I, [0 0 width(I) 342]);
end

function I = align_basic(x)
    [b,g,r] = cropImage(x);
    r_g = normxcorr2(g,r);
    [ypeak, xpeak] = find(r_g==max(r_g(:)));
    yoffSet = ypeak-size(r,1);
    xoffSet = xpeak-size(r,2);
    g = imtranslate(g,[xoffSet,yoffSet]);
    r_b = normxcorr2(b,r);
    [ypeak, xpeak] = find(r_b==max(r_b(:)));
    yoffSet = ypeak-size(r,1);
    xoffSet = xpeak-size(r,2);
    b = imtranslate(b,[xoffSet,yoffSet]);
    I(:,:,1) = r;
    I(:,:,2) = g;
    I(:,:,3) = b;
end

