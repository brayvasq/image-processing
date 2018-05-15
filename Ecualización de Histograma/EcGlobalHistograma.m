imgOriginal=(imread('2.jpg'));
imgOriginal=imgOriginal(:,:,1);


imContrasteEc=ecGlobalHistograma(imgOriginal);

figure;
imshow(imgOriginal);
figure;
imshow(imContrasteEc);


function histograma=calcularHistograma(img)
    tam=size(img);
    histograma=zeros(1,256);
    for i=1:tam(1)
        for j=1:tam(2)
            val=(img(i,j))+1;
            histograma(val)=histograma(val)+1;
                      
        end
    end
end



function imgEcualizada=ecGlobalHistograma(img)
    
    imgEcualizada=img;
    h=calcularHistograma(img);
    hProb=h/numel(img);
    probAcumulada=cumsum(hProb);    
    
    for i=1:size(img,1)
        for j=1:size(img,2)
            imgEcualizada(i,j)=probAcumulada(img(i,j)+1)*255;            
        end
    end
    imgEcualizada=uint8(imgEcualizada);
    figure;
    plot(h);
    figure;
    plot(calcularHistograma(imgEcualizada));
end


