image = imread('Images/Captura5.png');
image_gris = image(:,:,1);

y = input('Ingrese y : ');
x = input('Ingrese x : ');

x1 = 0;
x2 = 0;
y1 = 0;
y2 = 0;

tam = size(image);

if(x ~= 1)
    if(image_gris(x,y) == image_gris(x-1,y))
        image(x-1,y) = 255;
        x2 = 1;
    end
end

if(x ~= tam(2))
    if(image_gris(x,y) == image_gris(x+1,y))
        image(x+1,y) = 255;
        x2 = 1;
    end
end

if(y ~= 1)
    if(image_gris(x,y) == image_gris(x,y-1))
        image(x,y-1) = 255;
        y1 = 1;
    end
end

if(y ~= tam(1))
    if(image_gris(x,y) == image_gris(x,y+1))
        image(x,y+1) = 255;
        y2 = 1;
    end
end

if(y ~= 1 && x ~= 1)
   if(x1==0 && y1==0)
      image(x-1,y+1) = 255;
   end
end

if(y ~= tam(1) && x ~= 1)
   if(x1==0 && y2==0)
      image(x-1,y-1) = 255;
   end
end

if(y ~= tam(1) && x ~= tam(2))
    if(x2==0 && y2==0)
      image(x-1,y-1) = 255;
    end
end

if(y ~= 1 && x ~= tam(2))
    if(x2==0 && y1==0)
      image(x+1,y+1) = 255;
    end
end
imshow(image);
