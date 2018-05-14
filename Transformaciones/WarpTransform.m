img=imread("../Images/image.jpg");
[rowsi,colsi,z]= size(img); 

%WAVE 1
rowsf_img1=ceil(rowsi + abs(20*sin((2*pi*colsi)/128)));                    
colsf_img1=colsi;

%WAVE 2
rowsf_img2=ceil(rowsi + abs(20*sin((2*pi*rowsi)/30)));                    
colsf_img2=colsi;

%WRAP
rowsf_img3=rowsi;%ceil(abs(sign(rowsi) * rowsi^2));                    
colsf_img3=colsi;

img1=uint8(zeros([rowsf_img1 colsf_img1 3 ]));
img2=uint8(zeros([rowsf_img2 colsf_img2 3 ]));
img3=uint8(zeros([rowsf_img3 colsf_img3 3 ]));

xo=ceil(rowsi/2);                                                            
yo=ceil(colsi/2);

midx_img1=ceil((size(img1,1))/2);
midy_img1=ceil((size(img1,2))/2);

midx_img2=ceil((size(img2,1))/2);
midy_img2=ceil((size(img2,2))/2);

midx_img3=ceil((size(img3,1))/2);
midy_img3=ceil((size(img3,2))/2);

for i=1:size(img1,1)
    for j=1:size(img1,2)                                                       
          
         %WAVE 1
         x = (i-midx_img1) + (20*sin((2*pi*(j-midy_img1))/128));                                                            
         x = round(x) + midx_img1;
         y = j;
         
         if (x>=1 && y>=1 && x<=size(img,1) &&  y<=size(img,2) ) 
              img1(i,j,:)=img(x,y,:);  
         end

    end
end

for i=1:size(img2,1)
    for j=1:size(img2,2)                                                       

         %WAVE 2
         x = (i-midx_img2) + (20*sin((2*pi*(i-midx_img2))/30));  
         x = round(x) + midx_img2;
         y = j;
         
         if (x>=1 && y>=1 && x<=size(img,1) &&  y<=size(img,2) ) 
              img2(i,j,:)=img(x,y,:);  
         end

    end
end

for i=1:size(img3,1)
    for j=1:size(img3,2)                                                       

         %WRAP
         x = (sign((i-midx_img3)) * ((i-midx_img3))^2)/(xo+xo); 
         x = round(x) + midx_img3;
         y = j;
         
         if (x>=1 && y>=1 && x<=size(img,1) &&  y<=size(img,2) ) 
              img3(i,j,:)=img(x,y,:);  
         end

    end
end
%imshow(img1);figure;imshow(img2);figure;imshow(img3);
subplot(1,3,1), imshow(img1), title('WAVE 1')
subplot(1,3,2), imshow(img2), title('WAVE 2')
subplot(1,3,3), imshow(img3), title('WARP')