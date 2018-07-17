function [image]= imErosionBinaria(imagen, elemento,tamano,unos)
image=zeros(size(imagen,1),size(imagen,2));
for i=1+1:size(imagen,1)-2
    for j=1+1:size(imagen,2)-2
        intersecta=0;
        vecindad = getVecindad(imagen,i,j,tamano);
        for k=1:size(elemento,1)
            for l=1:size(elemento,2)
                pixel = vecindad(k,l)* elemento(k,l);
                if (pixel == 1)
                    intersecta=intersecta+1;
                end
            end
        end
        if intersecta==size(unos,1)
            image(i,j)=1;
        else
            image(i,j)=0;
        end
     end
end
end

function [vecindad] = getVecindad(img,posX,posY,tamano)
    centro = floor(tamano/2);    
    vecindad = img(posX - centro : posX + centro, posY - centro: posY + centro);
end
