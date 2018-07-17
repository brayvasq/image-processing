function [image]= imDilatacionBinaria(imagen, elemento)
image=zeros(size(imagen,1),size(imagen,2));
for i=1:size(imagen,1)-2
    for j=1:size(imagen,2)-2
        if (imagen(i,j)==1)
            for k=1:size(elemento,1)
                for l=1:size(elemento,2)
                    if(elemento(k,l)==1)
                        c=i+k;
                        d=j+l;
                        image(c,d)=1;
                    end
                end
            end
        end
   end
end
end
