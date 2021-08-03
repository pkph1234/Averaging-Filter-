% read me: here I have documented the code as much as I can, Most of the
% part is repeting because I choose 6 different method to represent the
% code . my code is different for odd kernel and even kernel, the chnage in
% both code is choosing the correct pixel to update the value.white giving
% the image name consider the whole image name witht he extention like if
% your image name is cameraman so write cameraman.tiff.I have used 2 images
% ,1)final.jpg 2)final2.jpg.I have included both images. 
% clc;
% close all;
% clear all;
%% Input Paramters

Kernel_size = input('Enter the Kernel Size = ');% giving kernel size
Image_Path = input('Enter Image Name =','s');% giving image name eg. I have usd 2 images 1)final.jpg 2) final2.jpg : so here user has to write final.jpg
if mod(Kernel_size,2) == 0% cheking the kernel size if it is even or odd: my code is different for odd kernel size % even kernel Size
    Enter = 1;
else
    Enter = 0;
end
% Choise the filter techniques
Choise = menu('Choose Filter Technique','1) no processing of border pixels','2) padding with a fixed value','3) padding with image reflection');
% giving fixed value to Pad the image by used
if Choise == 2
 pad= input('Enter the Fix Pad Value (should be between 0 to 1)');
end

%% Analysis of Even Kernel Size with no processing of border pixels technique
if Enter ==1 && Choise ==1
    disp('Analysis of Even Kernel Size with no processing of border pixels technique ')
   ImageA = im2double(imread(Image_Path));% read the Image
[x y z] = size(ImageA);% check if the image is RGB or grey scale if image is RGB this will convert into greyscale.
if z == 1
    ImageA = ImageA;
else
ImageA = rgb2gray(ImageA);
end
% ImageA= imcrop(ImageA,[180,50,208,210]);
ImageA = (imresize(ImageA,[100,100]));% resize the image in 100*100
figure(1)
subplot(1,2,1)% plot the value
imshow(ImageA)
title('Original Image');
% Averaging filter
as = Kernel_size;% for starting the loop
[x,y,z] = size(ImageA);% size of the image
filtered_ImageA = ImageA;% assign this to see the change ater filtered image
[x y z] = size(ImageA);

    for i = (as/2):x-((as/2)+1)% for x cordiinates ; selecting the start x coordinate pixel
        for j = (as/2):y-((as/2)+1) %for y cordiinates ; selecting the start y coordinate pixel
            sum = 0;
            for k = 1:Kernel_size% loop for kernel
                for l = 1:Kernel_size
                    sum = sum + ImageA(k+i-(as/2),l+j-(as/2));% summing all the value in the kernel 
                end
            end
            filtered_ImageA(k+i-as+1,j+l-as+1) = sum/(Kernel_size*Kernel_size);% find the mean & alter the value in the filtered image, here I am changing the value in filtered image so original image remains same.and if the kernel is 10x10 ,it will update the (6,6) value 
        end
    end


subplot(1,2,2)
imshow(filtered_ImageA)
title('Averaging filtered Image with Padding');
% asd = ImageA - filtered_ImageA;
%% choise for part 2
choise = menu('Choose  Transition Technique','1) block updating in a raster fashion','2) Dissolve Transition ');
if choise ==2
    ImageAP = ImageA;
[a b c] = size(ImageAP);

    figure()
[x y z] = size(ImageA);
for a = 1:10% 10 times my loop will iterate
    x1 = 11-a;
    for i =1:x1:x% finding the random values in x coordinate
    for j = 1:x1:y% finding random value in y coordinate; Here basically I am giving line space to the pixels in decending manner So in the 1st loop it 
        % will use linespace of 10 , than 9 and upto 1 so it will update
        % all the value & this is not working linearly so at the last
        % iteration it will change So many points
        ImageAP(i,j) = filtered_ImageA(i,j);
    end
    end
    imshow(ImageAP)
    title('Disolved Averaging filter Image');
pause(0.5)
hold on
end
else
figure()
ImageAP = ImageA;
[a b c] = size(ImageAP);
figure()
for i = 1:a
    for  j = 1:b
        ImageAP(i,j) = filtered_ImageA(i,j);% update each Image; this loop is slow working so be patient it will complete the task. for this case if the kernel size is higher , some of the starting pixels are the same so you may not see the traslation but after some time you will see when the raster will reach to the updated pixel
        imshow(ImageAP)
        title('Raster Fashion Averaging Filter Image')
        pause(0.0000001)
        hold on
    end
end

end

%%Analysis of Even Kernel Size with padding with a fixed value technique
else if Enter ==1 && Choise ==2
        disp('Analysis of Even Kernel Size with padding with a fixed value technique ')
        ImageA = im2double(imread(Image_Path));
%         
[x y z] = size(ImageA);
if z == 1
    ImageA = ImageA;
else
ImageA = rgb2gray(ImageA);
end
% ImageA= imcrop(ImageA,[180,50,208,210]);
ImageA = (imresize(ImageA,[100,100]));
figure(1)
subplot(1,3,1)
imshow(ImageA)
title('Original Image');
% Averaging filter


% start = (round(Kernel_size/2));
% ImageA = padarray(ImageA,[(start-1) (start-1)],0,'both');
as = Kernel_size;
[x,y,z] = size(ImageA);
 %% Padding with constant value
ImageP = ones(size(ImageA)+as);% making the matrix of oneswith whole padded dimention

ImageP = ImageP.*pad;% multiply the oce matrix with pad value
ImageP(((as/2)+1):end-(as/2),((as/2)+1):end-(as/2)) = ImageA;% Placing the original Image in the center of the padded matrix
ImageA = ImageP;
filtered_ImageA = ImageP;% assigning the padded matrix to the filtered matrix so we can see the updated value
[x y z] = size(ImageA);
subplot(1,3,2)
imshow(filtered_ImageA);% plotting padded value
title('Padded Image');
[x y] = size(ImageA);

    for i = (as/2):x-((as/2)+1)
        for j = (as/2):y-((as/2)+1) 
            sum = 0;
            for k = 1:Kernel_size
                for l = 1:Kernel_size
                    sum = sum + ImageA(k+i-(as/2),l+j-(as/2));
                end
            end
            filtered_ImageA(k+i-as+1,j+l-as+1) = sum/(Kernel_size*Kernel_size);
        end
    end

filtered_ImageA = filtered_ImageA(((as/2)+1):end-(as/2),((as/2)+1):end-(as/2));% visulize the original image after filtering not include the padded part
subplot(1,3,3)
imshow(filtered_ImageA)
title('Averaging filter Image')
%% 
        choise = menu('Choose  Transition Technique','1) block updating in a rasterfashion','2) Dissolve Transition ');
if choise ==2
    ImageAP = ImageA(((as/2)+1):end-(as/2),((as/2)+1):end-(as/2));% chossing the original image after filtering not include the padded part
[a b c] = size(ImageAP);

    figure()
[x y z] = size(ImageA(((as/2)+1):end-(as/2),((as/2)+1):end-(as/2)));
for a = 1:10
    x1 = 11-a;
    for i =1:x1:x
    for j = 1:x1:y
        ImageAP(i,j) = filtered_ImageA(i,j);
    end
    end
    imshow(ImageAP)
    title('Disolved Averaging filter Image');
pause(0.5)
hold on
end
else
figure()
ImageAP = ImageA(((as/2)+1):end-(as/2),((as/2)+1):end-(as/2));% chossing the original image after filtering not include the padded part
[a b c] = size(ImageAP);
figure()
for i = 1:a
    for  j = 1:b
        ImageAP(i,j) = filtered_ImageA(i,j);
        imshow(ImageAP)
        title('Raster Fashion Averaging Filter Image')
        pause(0.0000001)
        hold on
    end
end

end
    else if Enter ==1 && Choise ==3
        disp('Analysis of Even Kernel Size with padding with image reflection technique ')
        ImageA = im2double(imread(Image_Path));
        [x y z] = size(ImageA);
if z == 1
    ImageA = ImageA;
else
ImageA = rgb2gray(ImageA);
end
ImageA = (imresize(ImageA,[100,100]));
figure(1)
subplot(1,3,1)
imshow(ImageA)
title('Original Image');
% Averaging filter
as = Kernel_size;
[x,y] = size(ImageA);
%% Starting the padding
ImageP = ones(size(ImageA)+as);

ImageP(((as/2)+1):end-(as/2),((as/2)+1):end-(as/2)) = ImageA;% place the original image in the center
ImagePA = flipud(ImageP(((as/2)+1):(as),:));% choose the upper edge matrix according to kernel size & flip the matrix
ImageP(1:(as/2),:) = ImagePA;% add to the original Image
ImagePB = flipud(ImageP(end-as+1:end-(as/2),:));% choose the bottom edge matrix according to kernel size & flip the matrix
ImageP(end-(as/2)+1:end,:) = ImagePB;%add to the original Image 
ImagePC = fliplr(ImageP(:,((as/2)+1):(as)));% choose the left edge matrix according to kernel size & flip the matrix
ImageP(:,1:(as/2)) = ImagePC;%add to the original Image
ImagePD = fliplr(ImageP(:,end-as+1:end-(as/2)));% choose the right edge matrix according to kernel size & flip the matrix
ImageP(:,end-(as/2)+1:end) = ImagePD;%add to the original Image
filtered_ImageA = ImageP;% assign the padded image to the filtered image
ImageA = ImageP;
subplot(1,3,2)% plot the padded iamge
imshow(ImageA);
title('Padded Image');
[x y] = size(ImageA);

    for i = (as/2):x-((as/2)+1)
        for j = (as/2):y-((as/2)+1) 
            sum = 0;
            for k = 1:Kernel_size
                for l = 1:Kernel_size
                    sum = sum + ImageA(k+i-(as/2),l+j-(as/2));
                end
            end
            filtered_ImageA(k+i-as+1,j+l-as+1) = sum/(Kernel_size*Kernel_size);
        end
    end

filtered_ImageA = filtered_ImageA(((as/2)+1):end-(as/2),((as/2)+1):end-(as/2));% visulise only the original image not include the padded
subplot(1,3,3)
imshow(filtered_ImageA)
title('Averaging filter Image')
%% 
        choise = menu('Choose  Transition Technique','1) block updating in a rasterfashion','2) Dissolve Transition ');
if choise ==2
    ImageAP = ImageA(((as/2)+1):end-(as/2),((as/2)+1):end-(as/2));
[a b] = size(ImageAP);

    figure()
[x y] = size(ImageA(((as/2)+1):end-(as/2),((as/2)+1):end-(as/2)));
for a = 1:10
    x1 = 11-a;
    for i =1:x1:x
    for j = 1:x1:y
        ImageAP(i,j) = filtered_ImageA(i,j);
    end
    end
    imshow(ImageAP)
    title('Disolved Averaging filter Image');
pause(0.5)
hold on
end
else
figure()
ImageAP = ImageA(((as/2)+1):end-(as/2),((as/2)+1):end-(as/2));
[a b] = size(ImageAP);
figure()
for i = 1:a
    for  j = 1:b
        ImageAP(i,j) = filtered_ImageA(i,j);
        imshow(ImageAP)
        title('Raster Fashion Averaging Filter Image')
        pause(0.0000001)
        hold on
    end
end

end
%% 
        else if Enter ==0 && Choise ==1
    disp('Analysis of odd Kernel Size with no processing of border pixels technique ')
    ImageA = im2double(imread(Image_Path));
    [x y z] = size(ImageA);
if z == 1
    ImageA = ImageA;
else
ImageA = rgb2gray(ImageA);
end
% ImageA= imcrop(ImageA,[180,50,208,210]);
ImageA = (imresize(ImageA,[100 100]));
figure(1)
subplot(1,2,1)
imshow(ImageA)
title('Original Image');
% Averaging filter
start = (round(Kernel_size/2));% for odd kernel my start point is middle pixel of the kernel so this is the adjustmnt to find middele pixel
as = Kernel_size - start+1;% adjustment to find the central pixel
[x,y] = size(ImageA);
filtered_ImageA = ImageA;

    for i = start:x-start+1
        for j = start:y-start+1
            sum = 0;
            for k = 1:Kernel_size
                for l = 1:Kernel_size
                    sum = sum + ImageA(k+i-as,l+j-as);
                end
            end
            filtered_ImageA(k+i-Kernel_size,j+l-Kernel_size) = sum/(Kernel_size*Kernel_size);
        end
    end

subplot(1,2,2)
imshow(filtered_ImageA)
title('Averaging filtered Image');
choise = menu('Choose  Transition Technique','1) block updating in a rasterfashion','2) Dissolve Transition ');
if choise ==2
    ImageAP = ImageA;
[a b c] = size(ImageAP);

    figure()
[x y z] = size(ImageA);
for a = 1:10
    x1 = 11-a;
    for i =1:x1:x
    for j = 1:x1:y
        ImageAP(i,j) = filtered_ImageA(i,j);
    end
    end
    imshow(ImageAP)
    title('Disolved Averaging filter Image');
pause(0.5)
hold on
end
else
figure()
ImageAP = ImageA;
[a b c] = size(ImageAP);
figure()
for i = 1:a
    for  j = 1:b
        ImageAP(i,j) = filtered_ImageA(i,j);
        imshow(ImageAP)
        title('Raster Fashion Averaging Filter Image')
        pause(0.0000001)
        hold on
    end
end

end


            else if Enter ==0 && Choise ==2
        disp('Analysis of odd Kernel Size with padding with a fixed value technique ')
        ImageA = im2double(imread(Image_Path));
        [x y z] = size(ImageA);
if z == 1
    ImageA = ImageA;
else
ImageA = rgb2gray(ImageA);
end
ImageA = (imresize(ImageA,[100,100]));
figure(1)
subplot(1,3,1)
imshow(ImageA)
title('Original Image');
%%
as = Kernel_size -1;
%% Padding
[x,y,z] = size(ImageA);
ImageP = ones(size(ImageA)+as);
ImageP = ImageP.*pad;
ImageP(((as/2)+1):end-(as/2),((as/2)+1):end-(as/2)) = ImageA;
ImageA = ImageP;
subplot(1,3,2)
imshow(ImageP)
title('Padded Image');
filtered_ImageA = ImageA;
[x y] = size(ImageA);
%% Averaging filter 

    for i = (as/2):x-((as/2)+1)
        for j = (as/2):y-((as/2)+1) 
            sum = 0;
            for k = 1:Kernel_size
                for l = 1:Kernel_size
                    sum = sum + ImageA(k+i-(as/2),l+j-(as/2));
                end
            end
            filtered_ImageA(k+i-as,j+l-as) = sum/(Kernel_size*Kernel_size);

           
          
        end
    end

filtered_ImageA =filtered_ImageA(((as/2)+1):end-(as/2),((as/2)+1):end-(as/2));
subplot(1,3,3)
imshow(filtered_ImageA)

title('Averaging filtered Image with Padding')
choise = menu('Choose  Transition Technique','1) block updating in a rasterfashion','2) Dissolve Transition ');
if choise ==2
    ImageAP = ImageA(((as/2)+1):end-(as/2),((as/2)+1):end-(as/2));
[a b c] = size(ImageAP);

    figure()
[x y] = size(ImageA(((as/2)+1):end-(as/2),((as/2)+1):end-(as/2)));
for a = 1:10
    x1 = 11-a;
    for i =1:x1:x
    for j = 1:x1:y
        ImageAP(i,j) = filtered_ImageA(i,j);
    end
    end
    imshow(ImageAP)
    title('Disolved Averaging filter Image');
pause(0.5)
hold on
end
else
figure()
ImageAP = ImageA(((as/2)+1):end-(as/2),((as/2)+1):end-(as/2));
[a b] = size(ImageAP);
figure()
for i = 1:a
    for  j = 1:b
        ImageAP(i,j) = filtered_ImageA(i,j);
        imshow(ImageAP)
        pause(0.0000001)
        title('Raster Fashion Averaging Filter Image')
        hold on
    end
end
end



                else 
        disp('Analysis of Odd Kernel Size with padding with image reflection technique ')
ImageA = im2double(imread(Image_Path));
[x y z] = size(ImageA);
if z == 1
    ImageA = ImageA;
else
ImageA = rgb2gray(ImageA);
end
ImageA = (imresize(ImageA,[100,100]));
figure(1)
subplot(1,3,1)
imshow(ImageA)
title('Original Image');
% Averaging filter
as = Kernel_size -1;
ImageA = ImageA./max(ImageA(:));
[x,y,z] = size(ImageA);
ImageP = ones(size(ImageA)+as);

ImageP(((as/2)+1):end-(as/2),((as/2)+1):end-(as/2)) = ImageA;
ImagePA = flipud(ImageP(((as/2)+1):(as),:));
ImageP(1:(as/2),:) = ImagePA;
ImagePB = flipud(ImageP(end-as+1:end-(as/2),:));
ImageP(end-(as/2)+1:end,:) = ImagePB;
ImagePC = fliplr(ImageP(:,((as/2)+1):(as)));
ImageP(:,1:(as/2)) = ImagePC;
ImagePD = fliplr(ImageP(:,end-as+1:end-(as/2)));
ImageP(:,end-(as/2)+1:end) = ImagePD;
filtered_ImageA = ImageP;
subplot(1,3,2)
imshow(filtered_ImageA);
title('Padded Image');
ImageA = ImageP;
[x y] = size(ImageA);

    for i = (as/2):x-((as/2)+1)
        for j = (as/2):y-((as/2)+1) 
            sum = 0;
            for k = 1:Kernel_size
                for l = 1:Kernel_size
                    sum = sum + ImageA(k+i-(as/2),l+j-(as/2));
                end
            end
            filtered_ImageA(k+i-as,j+l-as) = sum/(Kernel_size*Kernel_size);
        end
    end

filtered_ImageA = filtered_ImageA(((as/2)+1):end-(as/2),((as/2)+1):end-(as/2));
subplot(1,3,3)
imshow(filtered_ImageA)
title('Averaging filtered Image with Padding');

choise = menu('Choose  Transition Technique','1) block updating in a rasterfashion','2) Dissolve Transition ');
if choise ==2
    ImageAP = ImageA(((as/2)+1):end-(as/2),((as/2)+1):end-(as/2));
ImageAP1 = filtered_ImageA(((as/2)+1):end-(as/2),((as/2)+1):end-(as/2));
[a b c] = size(ImageAP);

    figure()
[x y z] = size(ImageA(((as/2)+1):end-(as/2),((as/2)+1):end-(as/2)));
for a = 1:10
    x1 = 11-a;
    for i =1:x1:x
    for j = 1:x1:y
        ImageAP(i,j) = filtered_ImageA(i,j);
    end
    end
    imshow(ImageAP)
    title('Disolved Averaging filter Image');
pause(0.5)
hold on
end
else
figure()
ImageAP = ImageA(((as/2)+1):end-(as/2),((as/2)+1):end-(as/2));
[a b c] = size(ImageAP);
figure()
for i = 1:a
    for  j = 1:b
        ImageAP(i,j) = filtered_ImageA(i,j);
        imshow(ImageAP)
        title('Raster Fashion Averaging Filter Image')
        pause(0.0000001)
        hold on
    end
end
end
                end
            end
        end
    end
end
         


% asd = ImageA - filtered_ImageA;
