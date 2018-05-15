%Obtengo la imagen original y la muestro
imagenOriginal = imread('image.jpg');
imshow(imagenOriginal);

%Tomo esa imagen y la normalizo
imagenaModificar = im2double(imagenOriginal);

%Creo una nueva matriz para guardar la imagen nueva en formato CMYK
imgResultadok = zeros(size(imagenOriginal,1),size(imagenOriginal,2),4);
for i = 1:size(imagenOriginal,1)
    for j= 1:size(imagenOriginal,2)
        %Pasando a CMY
        pixelResultado = calcularCMY(imagenaModificar(i,j,:));
        %imgResultado(i,j,:)=(pixelResultado);
        %Pasando a CMYK
        pixelresultadoK= calcularK(pixelResultado);
        imgResultadok(i,j,:)=pixelresultadoK;
    end
end
%figure;
%rgbImage = imgResultadok(:,:,1:3);
%imshow(rgbImage);

imgResultadoRGB=zeros(size(imagenOriginal,1),size(imagenOriginal,2),3);
%Retornarla a su estado original 
for i = 1:size(imagenOriginal,1)
    for j= 1:size(imagenOriginal,2)
        %Pasando a CMY
        pixelResultado = CMYK2CMY(imgResultadok(i,j,:));
        %imgResultadoRGB(i,j,:)=(pixelResultado);
        %Escala de grises
        %imgResultadoRGB(i,j,:)=(1-pixelResultado);
        %Pasando a RGB
        pixelresultadoFinal= CMY2RGB(pixelResultado,imgResultadok(i,j,4));
        imgResultadoRGB(i,j,:)=pixelresultadoFinal;
    end
end
figure;
imshow(imgResultadoRGB);


function cmy = calcularCMY(primo)
    cmy = 1-primo;
end


function cmyk= calcularK(pixelito)
    cmyk=[0,0,0,0];
    if(min(pixelito)==1)
        for i=1:4
            if(i==4)
                cmyk(4)=1;
            else
                cmyk(i)=0;
            end
        end
    else
    cmyk(4)= min(pixelito);
    cmyk(1)=((pixelito(1)-cmyk(4))/(1-min(pixelito)));
    cmyk(2)=((pixelito(2)-cmyk(4))/(1-min(pixelito)));
    cmyk(3)=((pixelito(3)-cmyk(4))/(1-min(pixelito)));
    end
end

function rgbprima=CMYK2CMY(cmysito)
    rgbprima=[0,0,0];
    for i=1:3
        rgbprima(i)=(cmysito(i)*(1-cmysito(4))+cmysito(4));
    end
end

function rgb=CMY2RGB(gris,key)
    rgb=[0,0,0];
    for i=1:3
        rgb(i)=((1-(gris(i)))*(1-key));
    end
end