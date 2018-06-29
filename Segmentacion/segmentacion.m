% I = imread('butterfly.jpg');
% 
% imshow(I);
% I = I(:,:,1);
% 
% background = imopen(I,strel('disk',15));
% 
% 
% figure;
% %I2 = imtophat(I,strel('disk',15));
% I2 = I - background;
% imshow(I2);
% 
% figure;
% I3 = imadjust(I2);
% imshow(I3);
% 
% figure;
% bw = imbinarize(I3);
% bw = bwareaopen(bw, 50);
% imshow(bw);


I = imread('butterfly.jpg');
imshow(I);
I=rgb2gray(I);
I=imadjust(I);

figure;
[nroPxl, nivelesGris] = imhist(I);

bar(nroPxl);

xlim([0 nivelesGris(end)]);
grid on;



limite = 105;
imBinaria = I > limite; 

imBinaria = imfill(imBinaria, 'holes');




figure;
imshow(imBinaria); 




imEtiqueta = bwlabel(imBinaria, 8);     


figure;
imshow(imEtiqueta, []);



etiquetClr = label2rgb (imEtiqueta, 'hsv', 'k', 'shuffle'); 


figure;
imshow(etiquetClr);





