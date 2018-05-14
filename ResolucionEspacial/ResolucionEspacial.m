% --------------- RESOLUCION ESPACIAL ------------------

imagen = imread("../Images/image.jpg");
% Imagen en niveles de gris.
imagen = imagen(:,:,1);

escala = input('Ingrese escala : ');

% Tamano inicial de la imagen
tamano = size(imagen)

% Modulos para saber si la escala ingresada se puede usar directamente en la imagen
modulo_uno = mod(tamano(1),escala);
modulo_dos = mod(tamano(2),escala);

% Imagen en la que se aplicará el proceso de resolución espacial.
imagen_procesar = imagen_gris;

% Calculo de las columnas y filas que se deben añadir para que la imagen se pueda usar con la escala
if modulo_uno != 0
  tamano_dos = size(imagen_procesar,2);
  valor_anadir = escala - modulo_uno;
  imagen_procesar = [imagen_procesar;zeros(valor_anadir,tamano_dos)];
end

if modulo_dos != 0
  tamano_uno = size(imagen_procesar,1);
  valor_anadir = escala - modulo_dos;
  imagen_procesar = [imagen_procesar,zeros(tamano_uno,valor_anadir)];
end

tamano_nuevo = size(imagen_procesar);

limite_y = tamano_nuevo(1);
limite_x = tamano_nuevo(2);

posicion_x = 1;
posicion_y = 1;

while(posicion_y <= limite_y)
  % submatriz que contiene los items a cambiar
  submatriz = imagen_procesar(posicion_x:posicion_x+(escala-1),posicion_y:posicion_y+(escala-1));
  suma = sum(submatriz);
  suma = suma/(escala*escala);
  promedio = sum(suma);
  imagen_procesar(posicion_x:posicion_x+(escala-1),posicion_y:posicion_y+(escala-1)) = promedio; 
  posicion_x += escala;
  
  if(posicion_x >limite_x)
    posicion_x = 1;
    posicion_y += escala;
  end
end

% Recortando la imagen al tamaño inicial
imagen_procesar = imagen_procesar(1:tamano(1),1:tamano(2));

% Mostrando resultados
subplot(1,2,1), imshow(imagen_gris), title("Imagen Original")
subplot(1,2,2), imshow(imagen_procesar), title("Resolucion Espacial")
