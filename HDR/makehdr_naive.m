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

memorial_avg = makehdr_naive_simple_averaging(ldrs, exposures);
A = figure;imshow(memorial_avg);
saveas(A,'./outputs/naive_HDR_avg.jpg');

memorial_weighted_average = makehdr_naive_weighted_averaging(ldrs, exposures);
B = figure;imshow(memorial_weighted_average);
saveas(B,'./outputs/naive_HDR_weighted_avg.jpg');

memorial_median_value = makehdr_naive_median_value(ldrs, exposures);
C = figure; imshow(memorial_median_value);
saveas(C,'./outputs/naive_HDR_median.jpg');

memorial_non_saturating_exposure = makehdr_naive_non_saturating_exposure(ldrs, exposures);
D = figure; imshow(memorial_non_saturating_exposure);
saveas(D,'./outputs/naive_HDR_highest.jpg');

function hdr = makehdr_naive_simple_averaging(ldrs, exposures)
    % ldrs is an m x n x 3 x k matrix which can be created with ldrs = cat(4, ldr1, ldr2, ...);
    % exposures is a vector of exposure times (in seconds) corresponding to ldrs
    [exposures,sortexp] = sort(reshape(exposures,1,1,1,[]));
    ldrs = ldrs(:,:,:,sortexp); %Sort exposures from dark to light
    %Create naive HDR here
    for i=1:16
        ldrs(:,:,:,i) = ldrs(:,:,:,i) ./ exposures(i);
    end
    base = ldrs(:,:,:,1);
    for i=2:16
        base = base + ldrs(:,:,:,i);
    end
    base = base ./ length(ldrs);
    hdr = tonemap(base, 'AdjustSaturation',3.0);
end

function hdr = makehdr_naive_weighted_averaging(ldrs, exposures)
    % ldrs is an m x n x 3 x k matrix which can be created with ldrs = cat(4, ldr1, ldr2, ...);
    % exposures is a vector of exposure times (in seconds) corresponding to ldrs
    [exposures,sortexp] = sort(reshape(exposures,1,1,1,[]));
    ldrs = ldrs(:,:,:,sortexp); %Sort exposures from dark to light
    %Create naive HDR here
    grayscale = zeros(768, 512, 16);
    for i=1:16
        ldrs(:,:,:,i) = im2uint8(ldrs(:,:,:,i));
    end
    for i = 1:16
        grayscale(:, :, i) = im2gray(ldrs(:, :, :, i));
    end
    
    weights = ones(size(ldrs));
    
    RC = weights(:, :, 1, :);
    RC(grayscale > 230) = 0;
    RC(grayscale < 26) = 0;
    weights(:, :, 1, :) = RC;
    
    GC = weights(:, :, 2, :);
    GC(grayscale > 230) = 0;
    GC(grayscale < 26) = 0;
    weights(:, :, 2, :) = GC;
    
    BC = weights(:, :, 3, :);
    BC(grayscale > 230) = 0;
    BC(grayscale < 26) = 0;
    weights(:, :, 3, :) = BC;
    
    hdr = mean(ldrs .* weights, 4);
    hdr = tonemap(hdr, 'AdjustSaturation', 3.0);
end

function hdr = makehdr_naive_median_value(ldrs, exposures)
    % ldrs is an m x n x 3 x k matrix which can be created with ldrs = cat(4, ldr1, ldr2, ...);
    % exposures is a vector of exposure times (in seconds) corresponding to ldrs
    [exposures,sortexp] = sort(reshape(exposures,1,1,1,[]));
    ldrs = ldrs(:,:,:,sortexp); %Sort exposures from dark to light
    %Create naive HDR here
     for i=1:16
        ldrs(:,:,:,i) = im2uint8(ldrs(:,:,:,i));
    end
    grayscales = zeros(768,512,16);
    for i=1:16
        grayscales(:,:,i) = rgb2gray(ldrs(:,:,:,i));
    end
    n_exposures = zeros(16,1);
    base = zeros(768,512,3);
    for i=1:768
        for j=1:512
            index = 1;
            for k=1:16
                w = double(128-abs(grayscales(i,j,k)-128));
                if w > 0.1
                    n_exposures(index) = k;
                    index = index+1;
                end
            end
            index = floor(index/2) + 1;
            tuple = n_exposures(index);
            base(i,j,1) = ldrs(i,j,1,tuple(1))/tuple(1);
            base(i,j,2) = ldrs(i,j,2,tuple(1))/tuple(1);
            base(i,j,3) = ldrs(i,j,3,tuple(1))/tuple(1);
        end
    end
    hdr = tonemap(base, 'AdjustSaturation',3.0);
end

function hdr = makehdr_naive_non_saturating_exposure(ldrs, exposures)
    % ldrs is an m x n x 3 x k matrix which can be created with ldrs = cat(4, ldr1, ldr2, ...);
    % exposures is a vector of exposure times (in seconds) corresponding to ldrs
    [exposures,sortexp] = sort(reshape(exposures,1,1,1,[]));
    ldrs = ldrs(:,:,:,sortexp); %Sort exposures from dark to light
    %Create naive HDR here
     final = zeros(768,512, 3);
    %convert to uint8
    for i=1:16
        ldrs(:,:,:,i) = im2uint8(ldrs(:,:,:,i));
    end
    %initalize empty vector
    hdrs = zeros(768, 512, 16);   
    %create "masks"
    for i = 1:3
        for j = 1:16
            hdr = ldrs(:, :, i, j);
            for k=1:768
                for l=1:512
                    if hdr(k,l) > 230
                        hdr(k,l) = NaN;
                    end
                end
            end
            hdrs(:, :, j) = hdrs(:, :, j) + hdr;
        end
    end
    
    for i = 1:16
        ldrs(:, :, :, i) = ldrs(:, :, :, i) ./ exposures(i);
    end
    [M,idx] = max(hdrs, [], 3, 'omitnan');

    for i = 1:768
        for j = 1:512
            final(i, j, :) = ldrs(i, j, :, idx(i, j));
        end
    end
    hdr = tonemap(final, 'AdjustSaturation',3.0); 
end