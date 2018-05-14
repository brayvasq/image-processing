% Código para rotar una imagen con un angulo ingresado por terminal

% Sección de declaración de variables
imagen_original=imread('../Images/image.jpg'); 

[filas,columnas,z]= size(imagen_original); 

angulo = input('Ingrese angulo para rotar la imagen : ');

radianes=2*pi*angulo/360;  

% Calcular las dimensiones de la nueva imagen rotada.
% En base a las formulas :
%   u(x,y) = (x * cos(angulo)) + (y * sin(angulo)) -> para la componente en x
%   v(x,y) = (-x * sin(angulo)) + (y * cos(angulo)) -> para la componente en y
% En este caso x = filas, y = columnas para calcular el tamaño maximo de la imagen.

filas_nuevas=ceil(filas*abs(cos(radianes))+columnas*abs(sin(radianes)));                      
columnas_nuevas=ceil(filas*abs(sin(radianes))+columnas*abs(cos(radianes)));                     

imagen_resultado=uint8(zeros([filas_nuevas columnas_nuevas 3 ]));

% Puntos centrales de la imagen original
xo=ceil(filas/2);                                                            
yo=ceil(columnas/2);
% Puntos centrales de la nueva imagen
mitad_x=ceil(filas_nuevas/2);
mitad_y=ceil(columnas_nuevas/2);

% Calcula los valores u,v para cada punto de la imagen y lo mapea en la imagen resultado.
% En base a las formulas :
%   u(x,y) = (x * cos(angulo)) + (y * sin(angulo)) -> para la componente en x
%   v(x,y) = (-x * sin(angulo)) + (y * cos(angulo)) -> para la componente en y
for x=1:filas_nuevas
    for y=1:columnas_nuevas                                                       

         u= (x-mitad_x)*cos(radianes)+(y-mitad_y)*sin(radianes);                                       
         v= -(x-mitad_x)*sin(radianes)+(y-mitad_y)*cos(radianes);                             
         u=round(u)+xo;
         v=round(v)+yo;

         if (u>=1 && v>=1 && u<=filas &&  v<=columnas) 
              imagen_resultado(x,y,:)=imagen_original(u,v,:);  
         end

    end
end

% Visualizando las imagenes
subplot(1,2,1), imshow(imagen_original)
subplot(1,2,2), imshow(imagen_resultado)