function [B,C,D] = houghtransform(inputfile,pixelsperline,angle,deltarho,deltatheta)

%angle = 45;
%pixelsperline = 35;
%inputfile='cameraman.tif';

I = imread(inputfile);

[rows,columns,dim] = size(I);

BW = edge(I,'sobel');
B = uint8(BW);

for i=1:rows
    for j=1:columns
        if B(i,j) == 1
            B(i,j) = 255;
        end
    end
end


maxrows=0;
maxcolumns=0;

for theta=0:deltatheta:90
    maxcolumns=maxcolumns+1;
end

for rho=0:deltarho:floor(sqrt(2)*rows)
    maxrows=maxrows+1;
end

for i=1:maxrows
    for j=1:maxcolumns
        A(i,j)=0;
    end
end

for r=1:rows
    for c=1:columns
        if B(r,c) == 255 %marked
            theta = 0;
            while theta <= 90
                
                rho = r*cosd(theta) + c*sind(theta);
                i = floor(rho/deltarho)+1;
                j = floor(theta/deltatheta)+1;
                A(i,j) = A(i,j)+1;
                %store (r,c) in (rho,theta) block
                theta = theta + deltatheta;
            end
        end
    end
end

for r=1:rows
    for c=1:columns
        C(r,c) = 0;
    end
end




for r=1:rows
    for c=1:columns
        theta1 = angle;
        rho1 = r*cosd(theta1) + c*sind(theta1);
        i = floor(rho1/deltarho)+1;
        j = floor(theta1/deltatheta)+1;
        if A(i,j) >= pixelsperline
            
            C(r,c) = 255;
        end
    end
    
end
C=uint8(C);
%imshow(C)

C = logical(C);

D = bitand(C,BW);
%imshow(D)

imwrite(B,'EdgeDetected.tif');
imwrite(C,'HoughMask.tif');
imwrite(D,'final.tif');