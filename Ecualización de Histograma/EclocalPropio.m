%Ecualización Local
%Daniel Vargas Gonzales
%Brayan Vasquez Villa
%Juan Sebastián Marulanda Sánchez

imagenOriginal = double(imread('../Images/cuadro.png'));
imagenGris = imagenOriginal(:,:,1);
tamanoImagen = size(imagenGris);
filas = tamanoImagen(1);
columnas = tamanoImagen(2);
imagenModificada = imagenGris; 

%Vecindad (siempre es simétrica, 3x3, 5x5, etc.)
%Es importante que la vecindad sea de impares, para obtener un centro
tamanoVecindad = 3;
centro = floor(tamanoVecindad/2);

for i = 1 + 1 : filas-1
    for j = 1 + 1 : columnas-1
        vecindad = getVecindad(imagenGris,i,j,tamanoVecindad);
        valores = getHistogram(vecindad);        
        probabilidad = valores/(tamanoVecindad*tamanoVecindad);
        valoresNuevos = zeros([256,1]);
        ultimaCantidad = 0;
        for k = 1:256
            valoresNuevos(k) = ultimaCantidad + (255 * probabilidad(k));
            ultimaCantidad = valoresNuevos(k);
        end        
        valoresNuevos = round(valoresNuevos);
        
        valorCentral = valoresNuevos(vecindad(2, 2) + 1);
        imagenModificada(i, j) = valorCentral;
    end
end

figure,imshow(imagenModificada/255);
figure,
subplot(2,1,1);title('Antes'); imhist(imagenGris/255);
subplot(2,1,2);title('Después'); imhist(imagenModificada/255);

function [vecindad] = getVecindad(imagen,posX,posY,tamano)
    centro = floor(tamano/2);    
    vecindad = imagen(posX - centro : posX + centro, posY - centro: posY + centro);
end
 
function[valores] = getHistogram(imagen)
    valores = zeros([256,1]);
    for i=0:255
        cantidad = size(find(imagen == i));
        valores(i + 1) = cantidad(1);
    end
end


