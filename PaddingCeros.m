%Script para el padding de ceros dependiendo de la vecindad

%Obteniendo la imagen en niveles de gris
imgOriginal=rgb2gray(imread('imagen.jpg'));
figure,imshow(imgOriginal);
imgEcualizar=imgOriginal;

%Tamaño de la vecindad
veci1=3;
veci2=3;
valorCentro=round((veci1*veci2)/2);

%Cantidad de filas y columnas a llenar con 0 (bordes) para no perder
%información
in=0;
for i=1:veci1
    for j=1:veci2
        in=in+1;
        if(in==valorCentro)
            cerosVeci1=i-1;
            cerosVeci2=j-1;
            break;
        end
    end
end

%Colocar ceros en los bordes
imagenBorde=padarray(imgOriginal,[cerosVeci1,cerosVeci2]);

imshow(imagenBorde);
