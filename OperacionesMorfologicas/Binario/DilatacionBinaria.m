%Dilatación, presentado por:
%Daniel Vargas Gonzales
%Brayan Stiven Vásquez Villa
%Juan Sebastián Marulanda;

%Limpiar variables y espacio:
clc;
clear all;

%Lectura de imagen y elemento estructurante, ingresar una matriz.
imgOriginal=imread('test.png');
%Pasar mi imagen original a una imagen binaria:
BN=imbinarize(imgOriginal);
%Ingresar la matriz del elemento estructurante:
elementoEstructurante=input('ingrese la matriz del elemento ej: [0,1,0;1,1,1;0,1,0]: ');
resultado= zeros(size(BN,1),size(BN,2));

for i=1:size(BN,1)-2
    for j=1:size(BN,2)-2
        if (BN(i,j)==1)
            for k=1:size(elementoEstructurante,1)
                for l=1:size(elementoEstructurante,2)
                    if(elementoEstructurante(k,l)==1)
                        c=i+k;
                        d=j+l;
                        resultado(c,d)=1;
                    end
                end
            end
        end
   end
end
imshow(imgOriginal);
figure, imshow(resultado);