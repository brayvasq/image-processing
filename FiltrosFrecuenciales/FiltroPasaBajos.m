% Filtro Pasa Bajos

% Limpiando variables y terminal
clc;
clear;
% Imagen original
imagen_original = imread('../Images/image.jpg');
imagen_original = double(imagen_original(:,:,1));

% Transformada de fourier
imagen_fourier = fft2(imagen_original);
imagen_fourier = fftshift(imagen_fourier);

% Tamaño matriz
filas = size(imagen_original,1);
columnas = size(imagen_original,2);

% Filtro ideal
D0 = filas/8;

% Se construye el filtro
H = zeros(filas,columnas);

for i=1:filas 
  for j=1:columnas
    D = sqrt((i-filas/2)^2+(j-columnas/2)^2);% Se determina la distancia al centro del
                                  % punto (i,j)
    if D < D0
      H(i,j)=1;
    end
  end
end

% Aplicando el filtro
imagen_filtrada = imagen_fourier .* H;

% Aplicando la antitransformada
imagen_resultado = ifft2(imagen_filtrada);
imagen_resultado = abs(imagen_resultado);

%Visualizando las imagenes
subplot(2,2,1), imshow(uint8(imagen_original)), title('imagen original')
subplot(2,2,2), imshow(uint8(imagen_resultado)), title('imagen con filtro pasabajos')
subplot(2,2,3), imshow(log(abs(1-imagen_fourier)),[]), title('transformada de fourier')
subplot(2,2,4), imshow(log(abs(1-imagen_filtrada)),[]), title(strcat('filtro pasa-bajos D0 = ',num2str(D0)))
figure, mesh(H), title("Filtro")