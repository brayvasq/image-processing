% Código para crear el efecto WARP en una imagen

% Sección de declaración de variables
imagen_original=imread('../Images/image.jpg'); 

[filas,columnas,z]= size(imagen_original); 

%  Dimensiones de la nueva imagen rotada.

filas_nuevas=filas;                   
columnas_nuevas=columnas;                   

imagen_resultado=uint8(zeros([filas_nuevas columnas_nuevas 3 ]));

% Puntos centrales de la imagen original
xo=ceil(filas/2);                                                            
yo=ceil(columnas/2);
% Puntos centrales de la nueva imagen
mitad_x=ceil(filas_nuevas/2);
mitad_y=ceil(columnas_nuevas/2);

% Calcula los valores u,v para cada punto de la imagen y lo mapea en la imagen resultado.
% En base a las formulas :
%   u(x,y) = (sign(x) * x^2)/(xo+xo) -> para la componente en x
%   v(x,y) = y -> para la componente en y
for x=1:filas_nuevas
    for y=1:columnas_nuevas                                                       

         u = (sign((x-mitad_x)) * ((x-mitad_x))^2)/(xo+xo);                                                                   
         u = round(u)+xo;
         v = y;

         if (u>=1 && v>=1 && u<=filas &&  v<=columnas) 
              imagen_resultado(x,y,:)=imagen_original(u,v,:);  
         end

    end
end

% Visualizando las imagenes
subplot(1,2,1), imshow(imagen_original), title('Original')
subplot(1,2,2), imshow(imagen_resultado), title('Warp')