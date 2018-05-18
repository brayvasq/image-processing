%Ecualización Local
%Daniel Vargas Gonzales
%Brayan Vasquez Villa
%Juan Sebastián Marulanda Sánchez

imagenOriginal = (imread('image1.jpg'));
imagenGris = imagenOriginal(:,:,1);
tamanoImagen = size(imagenGris);
filas = tamanoImagen(1);
columnas = tamanoImagen(2);
imagenModificada = imagenGris; 

%Vecindad (siempre es simétrica, 3x3, 5x5, etc.)
%Es importante que la vecindad sea de impares, para obtener un centro
%tamanoVecindad = 3;
%centro = floor(tamanoVecindad/2);

for i = 1: filas-2
    for j = 1: columnas-2
        sub = imagenGris(i:i+2,j:j+2);
        hr = zeros(1,256);
        for k=1:3
            for l=1:3
                hr((sub(k+1)+1))= hr(sub(k+1)+1)+1;
            end
        end
        hr = hr/9;
        hs = zeros(1,256);
        for t=1:256
            hs(t) = sum(hr(1:t));
        end
        imagenModificada(i+1,j+1) = 255*(hr(imagenGris(i+1,j+1))+1); 
    end    
end

figure,imshow(imagenModificada);
figure,
subplot(2,1,1);title('Antes'); imhist(imagenGris);
subplot(2,1,2);title('Después'); imhist(imagenModificada);

