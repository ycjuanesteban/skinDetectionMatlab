%Directorios de entrada y salida de imágenes
dirEntrada = 'Originales\';
dirSalida  = 'Salida_Proceso\';
 
%Lectura de la carpeta de 'Origen' de las imágenes para saber sobre cuantas
%debo iterar
files = dir(strcat(dirEntrada,'*.jpg'));
[f c] = size(files);
 
for imagen = 1 : f
    %Concateno el nombre del directorio de entrada con el nombre de la
    %imagen para posteriormente leerla.
    imgALeer = strcat(dirEntrada,files(imagen).name);   
    I = imread(imgALeer);
    
    %Conversión a hsv para posteriormente hacer otro filtros.
    [hue,s,v]=rgb2hsv(I);
    
    [fil col] = size(I(:,:,1));
    
    %Primer filtro de RGB. Pone blanco lo que no considera 'Piel' según los
    %rangos establecidos.
    for i=1:(fil - 1)
        for j=1:(col - 1)
            maximo = max(max(I(i,j,1),I(i,j,2)),I(i,j,3));
            minimo = min(min(I(i,j,1),I(i,j,2)),I(i,j,3)); 
            if not(I(i,j,1) > 95 && I(i,j,2) > 40 && I(i,j,3) > 20 && ( maximo - minimo ) > 20 && 
                abs(I(i,j,1) - I(i,j,2)) > 20 && I(i,j,1) > I(i,j,2) && I(i,j,1) > I(i,j,3))
                I(i,j,1) = 255;
                I(i,j,2) = 255;
                I(i,j,3) = 255;
            end    
        end
    end
    
    %Filtrado posterior para eliminar algunas zonas que no son piel, no
    %elimina todas las zonas que no son piel. (Hasta ahora)
    for i=1:(fil-1)
         for j=1:(col-1)
             if hue(i,j) > 0.1 && s(i,j) > 0.3  
                I(i,j,1) = 255;
                I(i,j,2) = 255;
                I(i,j,3) = 255;
             end
         end
     end
    
    %Concateno la dirección destino y el nombre de la imagen para
    %posteriormente guardarla.
    path = strcat(dirSalida,files(imagen).name);
    imwrite(I,path,'jpg');
end
