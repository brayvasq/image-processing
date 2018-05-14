imgOriginal = imread('../Images/image.jpg');
imshow(imgOriginal);

%matriz transpuesta, rotacion de 90
[filas,columnas,dimensiones] = size(imgOriginal);
img90grados = imgOriginal;

for i=1:size(imgOriginal,2)
    for j=1:size(imgOriginal,1)
       img90grados(i,j,:) = imgOriginal(j,i,:);
    end
end
img90grados = img90grados(1:size(imgOriginal,2),1:size(imgOriginal,1),:);
figure;
imshow(img90grados);

%Espejito
imgespejo = imgOriginal;

for i=1:(size(imgOriginal,1)-1)
    for j=1:(size(imgOriginal,2)-1)
       imgespejo(i,j,:)=imgOriginal(i,columnas-j,:);
    end
end

figure;
imshow(imgespejo);

%Probando con la f�rmula
