%Erosion, presentado por:
%Daniel Vargas Gonzales
%Brayan Stiven Vásquez Villa
%Juan Sebastián Marulanda;

%Limpiar variables y espacio:
clc;
clear

%Lectura de imagen y elemento estructurante, ingresar una matriz.
imgOriginal=imread('test.png');

%Pasar mi imagen original a una imagen binaria:
BN=imbinarize(imgOriginal);

%Ingresar la matriz del elemento estructurante:
elementoEstructurante=input('ingrese la matriz del elemento ej: [0,1,0;1,1,1;0,1,0]: ');

%centro del elemento 
tamano=size(elementoEstructurante,1);
cantidaddeunos=find(elementoEstructurante>0);

resultado= zeros(size(BN,1),size(BN,2)); 

for i=1+1:size(BN,1)-2
    for j=1+1:size(BN,2)-2
        intersecta=0;
        vecindad = getVecindad(BN,i,j,tamano);
        for k=1:size(elementoEstructurante,1)
            for l=1:size(elementoEstructurante,2)
                pixel = vecindad(k,l)* elementoEstructurante(k,l);
                if (pixel == 1)
                    intersecta=intersecta+1;
                end
            end
        end
        if intersecta==size(cantidaddeunos,1)
            resultado(i,j)=1;
        else
            resultado(i,j)=0;
        end
     end
end
imshow(imgOriginal);
figure, imshow(resultado);


function [vecindad] = getVecindad(img,posX,posY,tamano)
    centro = floor(tamano/2);    
    vecindad = img(posX - centro : posX + centro, posY - centro: posY + centro);
end





