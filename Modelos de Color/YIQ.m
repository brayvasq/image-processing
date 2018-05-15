a = imread('image.jpg');
imshow(a);

%c = rgb2ntsc(a);
%figure;
%imshow(c);
b = start(a,1);
figure;
imshow(b);
d = start(b,2);
figure;
imshow(d);

function result = start(image,option)
  image_resp = double(image);
  if option == 1 || option == 2 
    for i = 1:size(image,1)
      for j = 1:size(image,2)
        if option == 1
          image_resp(i,j,:) = convert_rgb_yiq(image_resp(i,j,:));
        elseif option == 2
          image_resp(i,j,:) = convert_yiq_rgb(image_resp(i,j,:));
        end  
      end
    end
  end
  result = image_resp;
end

function yiq = convert_rgb_yiq(position)
  yiq_val = position/255;
  yiq_val = [0.299 0.587 0.114; 0.595716 -0.274453 -0.321263; 0.211456 -0.522591 0.311135] * [yiq_val(1); yiq_val(2); yiq_val(3)];
  yiq = yiq_val;
end

function rgb = convert_yiq_rgb(position)
  rgb_val = position;
  rgb_val = [1 0.9563 0.6210; 1 -0.2721 -0.6474; 1 -1.1070 1.7046] * [rgb_val(1); rgb_val(2); rgb_val(3)];
  rgb = rgb_val; 
end