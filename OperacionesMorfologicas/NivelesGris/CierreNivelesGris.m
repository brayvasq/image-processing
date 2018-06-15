
img=imread('prueba.jpg');
img=img(:,:,1);

isPar=1;
while isPar
    tamObj=input('Ingrese tamaño del objeto estructurante (impar) : ');
    if mod(tamObj,2)~=0
        isPar=0;
    end
end

disp('Los valores del objeto estructurante se llenan por columnas empezando por la mas izquierda')
objEstruc=ones(tamObj,tamObj);
for i=1:tamObj^2
    objEstruc(i)=input(['Ingrese el valor del objeto estructurante en pos ' num2str(i) ' : ']);
end

disp(objEstruc);

a=imread('prueba.jpg');
a=a(:,:,1);
figure;
imshow(a);

b=aplicarCierre(objEstruc,tamObj,a);
figure;
imshow(b);

function imgResult=aplicarCierre(objEstruc,tamOb,img)
    i=aplicarDilatacion(objEstruc,tamOb,img);    
    imgResult=aplicarErosion(objEstruc,tamOb,i);
end





function imgResultado=aplicarErosion(objEstruc,tamOb,img)

        imgResultado=img;
        [tamX,tamY]=size(img);


        for i=2:tamX-1
            for j=2:tamY-1
                imgResultado(i,j)=aplicarErosionRegion(objEstruc,tamOb,img,i,j);
            end
        end    
end

function valorP=aplicarErosionRegion(objEstruc,tamOb,img,i,j)
        numPosAdicionales=floor(tamOb/2);
        seccionImg=img(i-numPosAdicionales:i+numPosAdicionales,j-numPosAdicionales:j+numPosAdicionales);
        min=2^30;
        for x=1:size(objEstruc,1)
            for y=1:size(objEstruc,2)
                val=seccionImg(x,y)-objEstruc(x,y);
                if val<min
                    min=val;
                end
            end
        end
        valorP=min;
end
    


function imgResultado=aplicarDilatacion(objEstruc,tamOb,img)
    
    imgResultado=img;
    [tamX,tamY]=size(img);
    
    
    for i=2:tamX-1
        for j=2:tamY-1
            imgResultado(i,j)=aplicarDilatacionRegion(objEstruc,tamOb,img,i,j);
        end
    end    
end

function valorP=aplicarDilatacionRegion(objEstruc,tamOb,img,i,j)
    numPosAdicionales=floor(tamOb/2);
    seccionImg=img(i-numPosAdicionales:i+numPosAdicionales,j-numPosAdicionales:j+numPosAdicionales);
    max=-2^30;
    for x=1:size(objEstruc,1)
        for y=1:size(objEstruc,2)
            val=seccionImg(x,y)+objEstruc(x,y);
            if val>max
                max=val;
            end
        end
    end
    valorP=max;
end