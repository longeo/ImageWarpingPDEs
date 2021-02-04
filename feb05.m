%clear the work space and close all open figure windows
clc; clear all; close all;

%Read in image
pic = imread('C:\Users\ELong\Desktop\Colege 17 -18\FinalYrProject\englishmansbay.jpg');
img = double(pic);
img = rgb2gray(img/255);
imshow(img);

offset = 10;
%boundary
right = 3115;
left = 2351;
top = 1698;
bottom = 1910;

%Spleen 1
s1p1 = [3115 1910];
s1p2 = [2919 1826];
s1p3 = [2815 1794];
s1p4 = [2671 1750];
s1p5 = [2499 1722];
s1p6 = [2351 1698];

s1_x = [s1p1(1), s1p2(1), s1p3(1),s1p4(1), s1p5(1),s1p6(1)];
s1_y = [s1p1(2), s1p2(2), s1p3(2),s1p4(2), s1p5(2),s1p6(2)];
s1 = [s1_x,s1_y];

%Plot parametric curves of x and y coordinates 
f=polyfit(1:6,s1_x, 2);
X = polyval(f, 1:6);
Xp = X+(offset.*(0:5));
figure
hold on
plot(1:6,X);
plot(1:6,Xp);
title('Parametric X coordinates');
hold off
f=polyfit(1:6,s1_y, 3);
Y = polyval(f, 1:6);
Yp = Y+(offset.*(0:5));
figure
hold on
plot(1:6,Y);
plot(1:6, Yp);
title('Parametric Y coordinates');
hold off
%New line
new_s1 = [Xp, Yp];

[rows, cols] = size(img);
X = ones(rows, 1) * (1 : cols);
Y = (1 : rows)' * ones(1, cols);
coords = [X(:)'; Y(:)'];

new_coords = coords;
vec_field = coords;
size = length(coords);

%Replace old spleen with new spleen
for i = 1:size
  if(coords(1,i) > left)  && (coords(1,i) < right) && (coords(2,i) < bottom)  && (coords(2,i) > top)  
    for j = 1:6  
      if(coords(:,i) == s1(:,j))
        vec_field(:,i) = new_s1(:,j)-coords(:,i);
      end
    end
  else
    vec_field(:,i) = [0,0];
  end
end

%Create vector field
%vec_field = cat(1, zeros(1,6), new_s1, zeros(1,6));
% vecX = ones(3, 1) * (1 : 6);
% vecY = (1 : 3)' * ones(1, 6);
new_vec_field = interp2(vecX, vecY, vec_field,X, Y);

X_lookup = reshape(new_coords(1, :), rows, cols);
Y_lookup = reshape(new_coords(2, :), rows, cols);

newoutput = interp2(X, Y, img, X_lookup, Y_lookup);

figure(2);
imshow(newoutput); 
title('Output Image');
