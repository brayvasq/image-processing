a = imread('image.jpg');
b=im2double(a);

figure;
imshow(b);

imgResultado=b;
for i = 1:size(a,1)
    for j= 1:size(a,2)
        pixelResultado=calcularYUV(b(i,j,:));
        imgResultado(i,j,:)=(pixelResultado);
    end
end

figure;
imshow(imgResultado);

for i = 1:size(a,1)
    for j= 1:size(a,2)
        pixelResultado=calcularRGB(imgResultado(i,j,:));
        imgResultado(i,j,:)=(pixelResultado);
    end
end

figure;
imshow(imgResultado);

function ysv=calcularYUV(bPrima)
    valoresM=[0.299,0.587,0.114;-0.147,-0.289,0.436;0.615,-0.515,-0.100];
    valoresRGB=[bPrima(1);bPrima(2);bPrima(3)];
    resultado=valoresM*valoresRGB;
    ysv=[resultado(1),resultado(2),resultado(3)];
end


function rgb=calcularRGB(bPrima)
    valoresM=[1,0,1.140;1,-0.395,-0.581;1,2.032,0];
    valoresYUV=[bPrima(1);bPrima(2);bPrima(3)];
    resultado=valoresM*valoresYUV;
    rgb=[resultado(1),resultado(2),resultado(3)];
end
