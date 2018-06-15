%Apertura, presentado por:
%Daniel Vargas Gonzales
%Brayan Stiven V�squez Villa
%Juan Sebasti�n Marulanda;

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

resultadoErosion = imErosionBinaria(BN, elementoEstructurante,tamano,cantidaddeunos);
resultadoFinal = imDilatacionBinaria(resultadoErosion, elementoEstructurante);

imshow(imgOriginal);
figure, imshow(resultadoFinal);
