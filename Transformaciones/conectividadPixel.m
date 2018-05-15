
a=imread('1.bmp');
% X = input('Ingrese posición en X del pixel : ');
% Y = input('Ingrese posición en Y del pixel : ');
% flag=input('Ingrese 1 o 2 : ');
b=a(:,:,:);


% b=conectividad(flag,X,Y,b);
% 
% figure;
% imshow(b);

figure;
pintarClick(b);

function i=pintarClick(img)
    i=img;
    imshow(i);
    hold on;
    while 1
        [x,y,but]=ginput(1); 
        if ~isequal(but, 1)             % stop if not button 1
            break
        end
        %i(x,y,:)=[255,0,0];
        plot(x,y,'rs');
        xV=[x,x-1];
        yV=[y+1,y];
        plot(xV,yV,'bs');
    end
    hold off;
end

function i=conectividad(bandera,posX,posY,img)
    i=Conectividad4(posX,posY,img);                        
    if bandera==2
        i=Conectividad4Diag(posX,posY,i);
    end
end

function i=Conectividad4(posX,posY,img)
    valorP=img(posX,posY,1);
    img(posX,posY,:)=[255,0,0];
    
    if img(posX,posY+1,1)==valorP
        img(posX,posY+1,:)=[0,0,255];
    end
    if img(posX+1,posY,1)==valorP
        img(posX+1,posY,:)=[0,0,255];
    end
    if img(posX,posY-1,1)==valorP
        img(posX,posY-1,:)=[0,0,255];
    end
    if img(posX-1,posY,1)==valorP
       img(posX-1,posY,:)=[0,0,255]; 
    end  
    
    i=img;
end

function i=Conectividad4Diag(posX,posY,img)
    valorP=img(posX,posY,1);
    img(posX,posY,:)=[255,0,0];
    
    if img(posX+1,posY+1,1)==valorP
        img(posX+1,posY+1,:)=[0,0,255];
    end
    if img(posX+1,posY-1,1)==valorP
        img(posX+1,posY-1,:)=[0,0,255];
    end
    if img(posX-1,posY-1,1)==valorP
        img(posX-1,posY-1,:)=[0,0,255];
    end
    if img(posX-1,posY+1,1)==valorP
        img(posX-1,posY+1,:)=[0,0,255];
    end
    i=img;
end


