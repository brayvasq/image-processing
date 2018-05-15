% Resolución : Intensidad
% Sebastian Marulanda
% Daniel Vargas
% Brayan Vasquez

% Importando paquete para las funciones de imagenes
%pkg load image;

% Cargando la imagen
imagen_original = imread('2.jpg');
imagen_gris = imagen_original(:,:,1);

num_bits = input('Ingrese numero de bits : '); % Entrada por parte del usuario
num_colores = 2^num_bits;
fprintf("Numero de Colores : %i \n\n",num_colores);

imshow(imagen_gris);

%vector_valores = [0:255];
vector_colores = []; % Vector que contiente los colores a aplicar
vector_limites = []; % Vector que contiene los limites o rangos donde se aplicará cada color
fprintf("Creando vector de colores \n");



%% Creando vector de colores
if num_colores == 2
    vector_colores = [vector_colores,0,255];
else
    i = 1; % Para vector colores empieza en 1 por que añadimos el valor 0 antes de llamar la funcion
    vector_colores = [vector_colores,0];
    p = crearvector(i,num_colores);
    vector_colores = [vector_colores,p];
end
fprintf("Creando vector de limites \n");
%% Creando vector de limites
i = 0; % Para vector colores empieza en 0 por que no vamos a incluir el 0 en el vector, 
       % la existencia de este estará implicita en el condicional del bucle principal.
x = crearvector(i,num_colores);
vector_limites = x;
fprintf("Termina vector de limites \n");
%% Reemplazando colores
limite_x = size(imagen_gris,2);
limite_y = size(imagen_gris,1);
limite = limite_x * limite_y;
%display(imagen_gris);
limite_vector = size(vector_limites,2);
fprintf("Limite Vector : %i \n",limite_vector);
for i = 1:limite
  cambia = 0;
  j = 1;
  while(j <= limite_vector && cambia==0)
    if imagen_gris(i) < vector_limites(j)
      cambia=1;
      imagen_gris(i) = vector_colores(j);
    end
    j=j+1;
  end
end
figure;
imshow(imagen_gris);

function x = crearvector(i,num_colores)
    valor = ceil(255 / (num_colores)); %% Valor escala para dividir el vector
    valor_anadir = 0;
    vector = [];
    limite = 255 - valor_anadir;
    while(i<num_colores-1 && valor_anadir < limite) % Hasta numero de colores -1 por que el valor final se añade después del ciclo y es 255
      valor_anadir =valor_anadir+ valor;
      if(valor_anadir<limite)
        vector = [vector,valor_anadir];
      end
      i=i+1;
    end
    vector = [vector,255];
    x = vector;
end

