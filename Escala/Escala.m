%Cargando la imagen
imagen_original = imread('image.jpg');
%Usar solo una matriz de colo para la imagen
imagen_gris = imagen_original(:,:,1);

%Entrada de la escala por parte del usuario
escala = input('Ingrese escala : ');
disp(escala);
%Tamaño inicial de la imagen
tamano = size(imagen_gris);

%Modulos para saber si la escala ingresada se puede usar directamente en la imagen
modulo_uno = mod(tamano(1),escala);
modulo_dos = mod(tamano(2),escala);

%Variable que contiene la imagen con la que se hara todo el proceso
imagen_procesar = imagen_gris;

%Sección Escalar de acuerdo a el valor ingresado
if modulo_uno ~= 0
  tamano_dos = size(imagen_procesar,2);
  valor_anadir = escala - modulo_uno;
  imagen_procesar = [imagen_procesar;zeros(valor_anadir,tamano_dos)];
end

if modulo_dos ~= 0
  tamano_uno = size(imagen_procesar,1);
  valor_anadir = escala - modulo_dos;
  imagen_procesar = [imagen_procesar,zeros(tamano_uno,valor_anadir)];
end

tamano_nuevo = size(imagen_procesar);

%Sección imagen cuadrada
if(tamano_nuevo(1) > tamano_nuevo(2))
  valor = tamano_nuevo(1) - tamano_nuevo(2);
  imagen_procesar = [imagen_procesar,zeros(tamano_nuevo(1),valor)];
elseif (tamano_nuevo(1) < tamano_nuevo(2))
  valor = tamano_nuevo(2) - tamano_nuevo(1);
  imagen_procesar = [imagen_procesar;zeros(valor,tamano_nuevo(2))];
end

%Seccion principal
tamano_nuevo = size(imagen_procesar);

limite_y = tamano_nuevo(1);
limite_x = tamano_nuevo(2);

posicion_x = 1;
posicion_y = 1;
while(posicion_y <= limite_y)
  %Variable que contiene el area temporal a modificar
  submatriz = imagen_procesar(posicion_x:posicion_x+(escala-1),posicion_y:posicion_y+(escala-1));
  suma = sum(submatriz);
  suma =suma/(escala*escala);
  promedio = sum(suma);
  imagen_procesar(posicion_x:posicion_x+(escala-1),posicion_y:posicion_y+(escala-1)) = promedio; 
  posicion_x =posicion_x+escala;
  
  if(posicion_x >limite_x)
    posicion_x = 1;
    posicion_y=posicion_y+escala;
  end
end


disp(tamano_nuevo);
%Recortando la imagen al tamaño inicial
imagen_procesar = imagen_procesar(1:tamano(1),1:tamano(2));

%Mostrando resultados
imshow(imagen_gris);
figure;
imshow(imagen_procesar);
