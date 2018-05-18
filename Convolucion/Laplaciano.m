
mascara = [0 1 0; 1 -4 1; 0 1 0];

%mascara2 = [1 1 1; 0 0 0; -1 -1 -1];
disp(mascara);
function imgResultado=aplicarFiltroLineal(filtro,tamF,img)
    
    imgResultado=img;
    [tamX,tamY]=size(img);
    
    
    for i=2:tamX-1
        for j=2:tamY-1
            imgResultado(i,j)=aplicarFiltroRegion(filtro,tamF,img,i,j);
        end
    end
    
end

function valorP=aplicarFiltroRegion(filtro,tamF,img,i,j)
    numPosAdicionales=floor(tamF/2);
    seccionImg=img(i-numPosAdicionales:i+numPosAdicionales,j-numPosAdicionales:j+numPosAdicionales);
    suma=0;
    for i=1:size(filtro,1)
        for j=1:size(filtro,2)
            suma=suma+seccionImg(i,j)*filtro(i,j);
        end
    end
    valorP=suma;
end

a=imread('prueba3.jpg');
a = a(:,:,1);
figure;
imshow(a);

b = aplicarFiltroLineal(mascara,3,a);
c = b - a;
%c=aplicarFiltroLineal(mascara,3,a);
%d = b + c;
figure;
imshow(c);