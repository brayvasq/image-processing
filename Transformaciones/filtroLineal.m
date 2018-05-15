
isPar=1;
while isPar
    tamFiltro=input('Ingrese tamaño en de la máscara (impar) : ');
    if mod(tamFiltro,2)~=0
        isPar=0;
    end
end

disp('Los pesos de la máscara se llenan por columnas empezando por la mas izquierda')
mascara=ones(tamFiltro,tamFiltro);
for i=1:tamFiltro^2
    mascara(i)=input(['Ingrese el peso mascara en pos ' num2str(i) ' : ']);
end

disp(mascara);

a=imread('2.jpg');
figure;
imshow(a);

b=aplicarFiltroLineal(mascara,tamFiltro,a);
figure;
imshow(b);

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