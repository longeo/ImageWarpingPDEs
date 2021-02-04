clc; clear  all; close all;

%
%
%  INPUT IMAGE         OUTPUT IMAGE
%
%       num_col               a* columns
% *--------*         *--------------*
% |  |     |         |       |      |   
% |--*(x,y)|   <==   |       |      |
% *--------*         |-------*      |
%                    |       (xp,yp)|
%                    *--------------* a*num_rows
%
%
%    scalingMatrix_transpose*(xp,yp) => (x,y) 

RGBImage = imread('smallpic.jpg');
c = rgb2gray(RGBImage);
inputImage = double(c);


%For Debugging
%figure; imshow(inputImage/255);
%inputImage = [1, 2 ,3 ,4 ,5; 1, 2 ,3 ,4 ,5; 1, 22 ,3 ,4 ,5; 1, 2 ,3 ,4 ,5];



%Set parameters 
[num_rows, num_columns] = size(inputImage);

%Create scaling Matrix
a = 1.5;
scalingMatrix = zeros(2,2);
scalingMatrix(1,1) = a;
scalingMatrix(2,2) = a;

%Rotation Matrix
theta = 10;          %degrees

rotationMatrix = zeros(2,2);
rotationMatrix(1,1)  = cosd(theta);
rotationMatrix(1,2)  = sind(theta);
rotationMatrix(2,1)  = -sind(theta);
rotationMatrix(2,2)  = cosd(theta);


new_numrows = round(num_rows*a)  %number of rows in the output image
new_numcol = round(num_columns*a)  %number of columns in the output image
%scalingMatrixInv = inv(scalingMatrix);

columnMatrix = zeros(new_numrows, new_numcol, class(inputImage));
rowMatrix = zeros(new_numrows, new_numcol, class(inputImage));

%Combine scaling and rotation operation
transformationMatrix = scalingMatrix*rotationMatrix;

figure(1); imshow(inputImage / 255); shg
fprintf('\n');
for y=1:new_numrows
  for x=1:new_numcol
     
    xpyp = [x y];                                  %Take current coordinates from output image
    xy = transformationMatrix\xpyp(:);             %Find the equivalent coordinates in the input image (SLOWING DOWN PROGRAM!)
    columnMatrix(y,x) =xy(1);                      %create matrices to keep track ofequivalent coordinates (Maybe there's a
    rowMatrix(y,x) =xy(2);                         %better way of doing this      
  
  end
  %for debugging
  if ( rem(y, 20) == 0 )
    fprintf('.%2.0f',y);
  elseif ( rem(y, 100) == 0 )
    fprintf('\n.');
  end;
end
fprintf('\n');

outputImage = interp2(inputImage, columnMatrix, rowMatrix, 'linear', 0);

figure(2), imshow(outputImage/255)


%do it in one shot
%Prepare a matrix of coordinates for your output image
[rows, cols] = size(inputImage);
X = ones(rows, 1) * (1 : cols);
Y = (1 : rows)' * ones(1, cols);
coords = [X(:)'; Y(:)'];
new_coords = inv(transformationMatrix) * coords;
X_lookup = reshape(new_coords(1, :), rows, cols);
Y_lookup = reshape(new_coords(2, :), rows, cols);
newoutput = interp2(X, Y, inputImage, X_lookup, Y_lookup);

figure(3`);
imshow(newoutput/255); 
title('Other way');


