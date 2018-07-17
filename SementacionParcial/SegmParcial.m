%% Parcial 2 Procesamiento digital de imágenes.
% Nombre : brayan stiven vasquez villa.
% código : 1701313783.

%% Leer imagen y aplicando umbral
img = imread('Images/celula1.bmp');
imshow(img); title('Imagen Original');
umbral=graythresh(img);

%% Convertir la imagen a binaria
imgBW=im2bw(img,umbral);

% mostrando la imagen en niveles de gris
figure;
imshow(imgBW); title('Imagen Niveles de Gris');

%% Definir un objeto estructurante. Para este caso me parece pertinente un disco - ciculo
objEs = strel('disk',3,8);

%% Se hace una apertura y un cierre para identificar de mejor manera las formas, aplicando un filtro morfológico.
imgDilBW = imdilate(imgBW,objEs);
imgCloseBW = imclose(imgDilBW,objEs);

% Mostrando las imagenes de apertura y cierre
figure;
imshow(imgDilBW); title('Imagen Dilatada');
figure;
imshow(imgCloseBW); title('Imagen Aplicando cierre');

%% Se sacan las propiedades de la imagen para identificar las formas y marcarlas con un rectangulo
imgNueva = ~imgCloseBW;
stats = regionprops(imgNueva,'Perimeter','Area','Centroid','BoundingBox');

% Mostrando imagen invertida
figure;
imshow(imgNueva); title('Imagen Invertida');

% Mostrando esqueleto de la imagen
imgEsqueleto = bwmorph(imgNueva,'skel',Inf);
figure;
imshow(imgEsqueleto); title('Imagen Esqueleto');

%% Identificando los objetos de la imagen
imageObjects = bwconncomp(imgNueva, 4)

% Obteniendo el objeto esfecífico
celula = false(size(imgNueva));
celula(imageObjects.PixelIdxList{14}) = true;

% mostrando el objeto específico
figure;
imshow(celula); title('Imagen Célula Específica');

%% Sección que crea y dibuja los rectangulos y los labels
figure;
imshow(img); title('Imagen Objetos');

hold on
for k=1:length(stats)
    thisboundingbox = stats(k).BoundingBox;
    if stats(k).Area > 100
        rectangle('Position',[thisboundingbox(1),thisboundingbox(2),thisboundingbox(3)*0.9,thisboundingbox(4)*0.9],'EdgeColor','r','LineWidth',1,'Curvature',1);
        text(stats(k).Centroid(1)-20,stats(k).Centroid(2),'CÉLULA','Color','b','FontSize',8);
    end
end
hold off
