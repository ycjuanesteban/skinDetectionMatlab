%Directorios de entrada y salida de imagenes
dirProceso = 'Salida_Proceso\';
dirSegmento = 'Segmentadas\';

%Para mostrar el porcentaje de error en cada imagen cambiarlo a 1
porcentajeximagen = 0;

%Leo los directorios de las imagenes
imgProceso = dir(strcat(dirProceso,'*.jpg'));
imgSegmento = dir(strcat(dirSegmento,'*.jpg'));
[f c] = size(imgProceso);

%Declaro las variables necesarias para operar y dar el error medio.
umbral = 50;    
contTotal = 0;       
totalPix = 0;

for i=1:(f-1)
    contLocal = 0;
    %Leo imagen por imagen
    imgP = imread(strcat(dirProceso,imgProceso(i).name));
    imgS = imread(strcat(dirSegmento,imgSegmento(i).name));
    
    %Saco la diferencia entre la imagen Segmentada y la imagen Procesada
    imgDif = abs(imgS - imgP);
    
    %Tomo el tamaño de una imagen para el for
    [fil col] = size(imgP(:,:,1));
    %Cuento los pixeles de la imagen
    totalPix = totalPix + (fil*col);
    for j=1:(fil-1)
        for k=1:(col-1)
            %Pregunto si la imagen en la posición i,j esta sobre el umbral,
            %de ser verdad cuento un pixel
            if imgDif(j,k,1) > umbral && imgDif(j,k,2) > umbral && imgDif(j,k,3) > umbral
                contTotal = contTotal + 1;
                contLocal = contLocal + 1;
            end
        end
    end
    if porcentajeximagen == 1
        disp(strcat(imgProceso(i).name),int2str(contLocal/(fil*col)));
    end
end

%Muestro el resultado
disp('Número de errores  hallados: ');
disp(contTotal);
disp('Número total de pixeles recorridos: ');
disp(totalPix);
disp('Porcentaje de error: ');
disp(contTotal/totalPix*100);