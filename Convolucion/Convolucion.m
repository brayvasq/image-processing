image = imread('Images/image.jpg');
image = double(image(:,:,1));
imshow(uint8(image));
result = double(zeros(size(image)));
mascara = [0 1 0; 1 -4 1; 0 1 0];
[fm cm dm] = size(mascara);

[f, c d] = size(image);
center_image = ceil([f c]/2);
disp(center_image);
start = ceil(fm/2);

for i = start:f-2
    for j = start:c-2
        result(i,j) = convolucion(mascara,image,i,j);
    end
end

figure;
%result = result + image;
imshow(uint8(result));
c = result + image;
figure;
imshow(uint8(c));

function x = convolucion(mascara,img,i,j)
    x = 0;
    fm = size(mascara,1);
    addc = floor(fm/2); 
    modulo = mod(fm,2);
    subm = [];
    resp = [];
    if(modulo ~= 0 )
        if(((i-addc) > 0) && ((j-addc)>0) && ((i+addc)<size(img,1)) && ((j+addc) < size(img,2)))
            subm = img(i-addc:i+addc,j-addc:j+addc);
            prod = subm .* mascara;
            pix = sum(sum(prod));
            x = abs(pix);
        end
    else
        if(((i+addc) < size(img,1)) && ((j+addc) < size(img,2)))
            subm = img(i:i+addc,j:j+addc);
            %resp = abs(double(subm)) .* double(mascara);
            x = 0;
            for k=1:size(mascara,1)
                for l=1:size(mascara,2)
                    x=x+subm(k,l)*mascara(k,l);
                end
            end
        end
    end
    %if(size(subm) ~= 0 )
    %    disp("Inicio")
    %    x = abs(uint8(sum(sum(resp))));
    %end
end