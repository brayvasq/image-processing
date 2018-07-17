%Leemos la image
image = imread('image1','jpg');
image = imbinarize(image(:,:,1));
imageSize = size(image);
b = strel('square',3);
figure(1),subplot(2,1,1),imshow(image),title('Región');

[y,x] = getpts;
y = round(y(1));
x = round(x(1));
auxImage = zeros(imageSize);
resultImage = zeros(imageSize);
resultImage(x,y) = image(x,y); 

while(~isequal(resultImage,auxImage))
    auxImage = resultImage;
    dilatedImage = imdilate(resultImage, b);
    resultImage = image .* dilatedImage;  
end 

figure(1),subplot(2,1,2),imshow(resultImage),title('Resultante');