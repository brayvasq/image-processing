a = imread('image.jpg');
b=double(a);

%figure;
c = double(a);
imshow(a);


imgResultado=c;

for i = 1:size(a,1)
    for j= 1:size(a,2)
        pixelResultado=calcularHSV(imgResultado(i,j,:));
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




function hsvval =calcularHSV(bPrima)
    
    hsv_val = bPrima/255;
    cMax=max(hsv_val);
    cMin=min(hsv_val);
    delta=cMax-cMin;
    h = 0;
    if cMax == cMin
        h = 0;
    elseif (cMax == hsv_val(1)) && (hsv_val(2) >= hsv_val(3))
        h = 60 * ((hsv_val(2) - hsv_val(3))/(cMax - cMin)) + 0;
    elseif (cMax == hsv_val(1)) && (hsv_val(2) < hsv_val(3))
        h = 60 * ((hsv_val(2) - hsv_val(3))/(cMax - cMin)) + 360;
    elseif cMax == hsv_val(2)
        h = 60 * ((hsv_val(3) - hsv_val(1))/(cMax - cMin)) + 120;
    elseif cMax == hsv_val(3)
        h = 60 * ((hsv_val(1) - hsv_val(2))/(cMax - cMin)) + 240;
    end
    %disp(h);
    %calculo de la saturacion
    s=0;
    if cMax==0
        s=0;
    else
        %s=(delta/cMax)*100;
        s = 1 - (cMin/cMax);
    end

    v=cMax;
    
    %hsv=[h,s,v];
    hsv_val(1) = h / 360;
    hsv_val(2) = s;
    hsv_val(3) = v;
    hsvval = hsv_val;
end


function rgbval=calcularRGB(bPrima)
   
    bPrima(1)=bPrima(1)*360;
    
    hi=mod(floor(bPrima(1)/60),6);
    f=(mod(bPrima(1)/60,6))-hi;
    p=bPrima(3)*(1-bPrima(2));
    q=bPrima(3)*(1-bPrima(2)*f);
    t=bPrima(3)*(1-bPrima(2)*(1-f));
    
    
    switch hi
        case 0
            rgbval=[bPrima(3),t,p];
        case 1
            rgbval=[q,bPrima(3),p];
        case 2
            rgbval=[p,bPrima(3),t];
        case 3
            rgbval=[p,q,bPrima(3)];
        case 4
            rgbval=[t,p,bPrima(3)];
        case 5
            rgbval=[bPrima(3),p,q];   
            
    end

end

