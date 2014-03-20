files = dir('*.bmp');
[f c] = size(files);
RM = 0;
Rm = 999999;
GM = 0;
Gm = 999999;
BM = 0;
Bm = 999999;

for imagen = 1 : f
    Im = imread(files(imagen).name);
    I = Im;
    %figure,imagesc(Im);
    [fil col] = size(I(:,:,1));
    for i=1:(fil - 1)
        for j=1:(col - 1)
            if I(i,j,1) ~= 255 && I(i,j,2) ~= 255 && I(i,j,3) ~= 255
                if I(i,j,1) > RM
                    RM = I(i,j,1);
                end
                if I(i,j,1) < Rm
                    Rm = I(i,j,1);
                end
                if I(i,j,2) > GM
                    GM = I(i,j,2);
                end
                if I(i,j,2) < Gm
                    Gm = I(i,j,2);
                end
                if I(i,j,3) > BM
                    BM = I(i,j,3);
                end
                if I(i,j,1) < Bm
                    Bm = I(i,j,3);
                end
            end
        end
    end
end

    RM
    Rm
    GM
    Gm
    BM
    Bm