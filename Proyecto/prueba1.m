%Proyecto final
%Daniel Vargas Gonzales
%Brayan Stiven Vasquez Villa
%Juan Sebastian Marulanda Sanchez
clasificar('base/Frontal/Capture_00031.jpg');

%------------------------------------------------------------------------
function W = clasificar(archivo)

    % Paso 1: Leer la imagen
    RGB = imread(archivo);
    figure,
    imshow(RGB),
    title('Imagen Original');

    % Paso 2: Convertir la imagen a escala de grises
    %   RGB = rgb2ycbcr(RGB);
    GRAY = rgb2gray(RGB);
    GRAY = imadjust(GRAY);
    
    
    %[pix1] = imhist(GRAY);
    %bar(pix1);
    %fprintf('Val hist %d',pix1);
    %title('Histograma de la img');
    
    
    figure,    
    imshow(GRAY),
    title('Escala Grises');
    
    

    % Paso 3: Binarizar la imagen en escala de grises usando binarizacion adaptativa o mediante calculo
    % del umbral usando el metodo de otsu (funcion graythresh() de matlab). 
    
    threshold = graythresh(GRAY);%calculado con metodo de otsu
    BW = imbinarize(GRAY, threshold);
    
    %BW = imbinarize(GRAY,'adaptive'); 
    
    
    %%Despues de binarizar (mas que todo por metodo adaptativo) hay que
    %%eliminar el ruido, el problema es que el metodo de eliminacion de
    %%ruido debe servir para TODAS (lo ideal) las imagenes de la base
    
    BW = bwareafilt(BW, 50);%Filtrado por tamaï¿½o, elementos con menos de 50 px
        
 
      
       
    objetoEstruc = strel('diamond', 5);
    BW=imerode(BW,objetoEstruc);
        
    
%     objetoEstruc = strel('diamond', 1);
%     BW=imerode(BW,objetoEstruc);
%     objetoEstruc = strel('diamond', 3);
%     BW=imdilate(BW,objetoEstruc);
   
%     objetoEstruc = strel('disk', 5);
%     BW=imdilate(BW,objetoEstruc);
    
  
    %objetoEstruc = strel('disk', 1);
    %BW=imerode(BW,objetoEstruc);
    %objetoEstruc = strel('disk', 3);
    %BW=imdilate(BW,objetoEstruc);

    
    

    BW = imfill(BW,'holes');%Llenar los huecos dentro de las figuras.Principalmente los que quedan cuando se
                            %binariza con el metodo adaptativo

    figure,
    imshow(BW),
    title('Imagen Binaria');
    

    %Paso 4: Invertir la imagen binaria (creo que no se necesita)
%     BW = ~ BW;
%     figure,
%     imshow(BW),
%     title('Inverted Binary Image');


    % Paso 5: Encontrar los bordes de las regiones de la imagen binaria
    % Opcion 'noholes' para solo buscar contornos externos. 
    
    [B,L,N] = bwboundaries(BW, 'noholes');



    % Paso 6: Determinar propiedades de los objetos delimitados usando la
    % funcion regionprops()
    
    STATS = regionprops(L, 'all'); % Todas las caracteristicas posibles, aunque solo se esten utilizando algunas
                                   % (perimetro, area,centroide, etc)

    
    % Paso 7: Clasificar formas segun las propiedades    

    figure,
    imshow(RGB),
    title('Resultado');
    
    metricaCuadrado = zeros(N,1);
    metricaTriangulo = zeros(N,1);
    
    nColors=0;
    
    hold on
    
    for i = 1 : length(STATS)
        boundary = B{i};
        [rx,ry,areaCuadrado] = minboundrect( boundary(:,2), boundary(:,1)); %Metodo para hallar el minimo rectangulo que contiene a la figura
        plot(rx,ry);
        
        %% Secciï¿½n areas
        %Ancho y alto del cuadrado que contiene la figura
        ancho = sqrt( sum( (rx(2)-rx(1)).^2 + (ry(2)-ry(1)).^2));
        alto = sqrt( sum( (rx(2)-rx(3)).^2+ (ry(2)-ry(3)).^2));
        proporcionLados= ancho/alto;
       
        if proporcionLados > 1  
            proporcionLados = alto/ancho;  %proporcion de lados < 1
        end
        metricaCuadrado(i) = proporcionLados;    %proporcion (Aspect ratio)
        metricaTriangulo(i) = STATS(i).Area/areaCuadrado;
      
       
        metricaCirculo=(STATS(i).Perimeter.^2)./(4*pi*STATS(i).Area);
        centroid = STATS(i).Centroid;
        esCirculo =   (metricaCirculo < 1.1);
        
        
        if esCirculo          
            plot(centroid(1),centroid(2),'wO');
            disp(['Circulo']);
        elseif (metricaTriangulo(i) < 0.6)
            plot(centroid(1),centroid(2),'w^');
            disp(['Triangulo']);
        elseif (metricaCuadrado(i) > 0.9)
            plot(centroid(1),centroid(2),'wS');
            disp(['Cuadrado']);
        else
            plot(centroid(1),centroid(2),'wD');
            disp(['Rectangulo']);
        end
        regiones(:,:,i) = roipoly(RGB,rx,ry);
        nColors=nColors+1;
    end
    
    %% Secciï¿½n Color
    % Cargando el paquete a usar para la conversiï¿½n de modelo de color
    load regioncoordinates;
    
    % Paso 1 : Calcular los colores de muesta en el modelo de color L*a*b
    % para cada region donde L = luminosidad, a = cromaticidad que indica
    % donde esta el color entre rojo y verde, b= cromaticidad que indica
    % donde esta el color entre azul y amarillo
    
    %figure;
    %imshow(regiones(:,:,2)),title('sample region for red');
    %convirtiendo a lab
    lab_rgb = rgb2lab(RGB);
        
    a = lab_rgb(:,:,2);
    b = lab_rgb(:,:,3);
    color_markers = zeros([nColors, 2]);

    % guardando los marcadores de a y b en la region
    for cantidad = 1:nColors
        color_markers(cantidad,1) = mean2(a(regiones(:,:,cantidad)));
        color_markers(cantidad,2) = mean2(b(regiones(:,:,cantidad)));
    end
    

    
    % Paso 2: Clasificando cada pixel deacuerdo al vecino mas cercanos
    color_labels = 0:nColors-1;
        
    a = double(a);
    b = double(b);
    distancia_lab = zeros([size(a), nColors]);
        
        
    for cantidad = 1:nColors
        distancia_lab(:,:,cantidad) = ( (a - color_markers(cantidad,1)).^2 + (b - color_markers(cantidad,2)).^2 ).^0.5;
    end
    
    [~, label] = min(distancia_lab,[],3);
    label = color_labels(label);
    clear distancia_lab;
        
    % Paso 3: Mostrando los resultados
    rgb_label = repmat(label,[1 1 3]);
    img_sementada = zeros([size(RGB), nColors],'uint8');

    for cantidad = 1:nColors
        color = RGB;
        color(rgb_label ~= color_labels(cantidad)) = 0;
        img_sementada(:,:,:,cantidad) = color;
    end
    
    for i = 1:nColors
        figure,imshow(img_sementada(:,:,:,i));
        title('Separación por colores');
    end
    
    return
end



function [rectx,recty,area,perimeter] = minboundrect(x,y,metric)
% minboundrect: Compute the minimal bounding rectangle of points in the plane
% usage: [rectx,recty,area,perimeter] = minboundrect(x,y,metric)
%
% arguments: (input)
%  x,y - vectors of points, describing points in the plane as
%        (x,y) pairs. x and y must be the same lengths.
%
%  metric - (OPTIONAL) - single letter character flag which
%        denotes the use of minimal area or perimeter as the
%        metric to be minimized. metric may be either 'a' or 'p',
%        capitalization is ignored. Any other contraction of 'area'
%        or 'perimeter' is also accepted.
%
%        DEFAULT: 'a'    ('area')
%
% arguments: (output)
%  rectx,recty - 5x1 vectors of points that define the minimal
%        bounding rectangle.
%
%  area - (scalar) area of the minimal rect itself.
%
%  perimeter - (scalar) perimeter of the minimal rect as found
%
%
% Note: For those individuals who would prefer the rect with minimum
% perimeter or area, careful testing convinces me that the minimum area
% rect was generally also the minimum perimeter rect on most problems
% (with one class of exceptions). This same testing appeared to verify my
% assumption that the minimum area rect must always contain at least
% one edge of the convex hull. The exception I refer to above is for
% problems when the convex hull is composed of only a few points,
% most likely exactly 3. Here one may see differences between the
% two metrics. My thanks to Roger Stafford for pointing out this
% class of counter-examples.
%
% Thanks are also due to Roger for pointing out a proof that the
% bounding rect must always contain an edge of the convex hull, in
% both the minimal perimeter and area cases.
%
%
% Example usage:
%  x = rand(50000,1);
%  y = rand(50000,1);
%  tic,[rx,ry,area] = minboundrect(x,y);toc
%
%  Elapsed time is 0.105754 seconds.
%
%  [rx,ry]
%  ans =
%      0.99994  -4.2515e-06
%      0.99998      0.99999
%   2.6441e-05            1
%  -5.1673e-06   2.7356e-05
%      0.99994  -4.2515e-06
%
%  area
%  area =
%      0.99994
%
%
% See also: minboundcircle, minboundtri, minboundsphere
%
%
% Author: John D'Errico
% E-mail: woodchips@rochester.rr.com
% Release: 3.0
% Release date: 3/7/07

% default for metric
if (nargin<3) || isempty(metric)
  metric = 'a';
elseif ~ischar(metric)
  error 'metric must be a character flag if it is supplied.'
else
  % check for 'a' or 'p'
  metric = lower(metric(:)');
  ind = strmatch(metric,{'area','perimeter'});
  if isempty(ind)
    error 'metric does not match either ''area'' or ''perimeter'''
  end
  
  % just keep the first letter.
  metric = metric(1);
end

% preprocess data
x=x(:);
y=y(:);

% not many error checks to worry about
n = length(x);
if n~=length(y)
  error 'x and y must be the same sizes'
end

% start out with the convex hull of the points to
% reduce the problem dramatically. Note that any
% points in the interior of the convex hull are
% never needed, so we drop them.
if n>3
  edges = convhull(x,y);

  % exclude those points inside the hull as not relevant
  % also sorts the points into their convex hull as a
  % closed polygon
  
  x = x(edges);
  y = y(edges);
  
  % probably fewer points now, unless the points are fully convex
  nedges = length(x) - 1;
elseif n>1
  % n must be 2 or 3
  nedges = n;
  x(end+1) = x(1);
  y(end+1) = y(1);
else
  % n must be 0 or 1
  nedges = n;
end

% now we must find the bounding rectangle of those
% that remain.

% special case small numbers of points. If we trip any
% of these cases, then we are done, so return.
switch nedges
  case 0
    % empty begets empty
    rectx = [];
    recty = [];
    area = [];
    perimeter = [];
    return
  case 1
    % with one point, the rect is simple.
    rectx = repmat(x,1,5);
    recty = repmat(y,1,5);
    area = 0;
    perimeter = 0;
    return
  case 2
    % only two points. also simple.
    rectx = x([1 2 2 1 1]);
    recty = y([1 2 2 1 1]);
    area = 0;
    perimeter = 2*sqrt(diff(x).^2 + diff(y).^2);
    return
end
% 3 or more points.

% will need a 2x2 rotation matrix through an angle theta
Rmat = @(theta) [cos(theta) sin(theta);-sin(theta) cos(theta)];

% get the angle of each edge of the hull polygon.
ind = 1:(length(x)-1);
edgeangles = atan2(y(ind+1) - y(ind),x(ind+1) - x(ind));
% move the angle into the first quadrant.
edgeangles = unique(mod(edgeangles,pi/2));

% now just check each edge of the hull
nang = length(edgeangles);
area = inf;
perimeter = inf;
met = inf;
xy = [x,y];
for i = 1:nang
  % rotate the data through -theta 
  rot = Rmat(-edgeangles(i));
  xyr = xy*rot;
  xymin = min(xyr,[],1);
  xymax = max(xyr,[],1);
  
  % The area is simple, as is the perimeter
  A_i = prod(xymax - xymin);
  P_i = 2*sum(xymax-xymin);
  
  if metric=='a'
    M_i = A_i;
  else
    M_i = P_i;
  end
  
  % new metric value for the current interval. Is it better?
  if M_i<met
    % keep this one
    met = M_i;
    area = A_i;
    perimeter = P_i;
    
    rect = [xymin;[xymax(1),xymin(2)];xymax;[xymin(1),xymax(2)];xymin];
    rect = rect*rot';
    rectx = rect(:,1);
    recty = rect(:,2);
  end
end
% get the final rect

% all done

end % mainline end




