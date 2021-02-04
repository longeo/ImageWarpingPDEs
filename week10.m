close all
clear


original = double(imread('greece.tif'));
[vres, hres] = size(original);

%badpic = double(imread('corrupted.tif'));

mask = double(imread('badpixels.tif'));


load forcing;

load badpicture;

figure(1);
image(original);
title('Original');
colormap(gray(256));

figure(2);
image(badpic);
title('Corrupted Picture');
colormap(gray(256));

restored = badpic;

[j, i] = find(mask ~= 0);
index = find(mask ~= 0);

for iteration = 1 : 2000,
  for k = 1 : length(j), 
    jj = j(k);
    ii = i(k);
    error = restored(jj, ii-1) + restored(jj, ii+1) + restored(jj-1, ii) + ...
      restored(jj+1, ii) - restored(jj, ii) * 4;
    restored(jj,ii) = restored(jj,ii) + 1.0*(error / 4);
  end;
  e(iteration) = std(restored(index) - original(index));
end;

figure(3);
image(restored);
title('Restored Picture');
colormap(gray(256));

figure(4);
plot(e, 'r-', 'linewidth', 3);
xlabel('Iteration', 'fontsize', 20);
ylabel('Std Error');

restored2 = badpic;
for iteration = 1 : 2000,
  for k = 1 : length(j), 
    jj = j(k);
    ii = i(k);
    error = restored2(jj, ii-1) + restored2(jj, ii+1) + restored2(jj-1, ii) + ...
      restored2(jj+1, ii) - restored2(jj, ii) * 4 - f(jj, ii);
    restored2(jj,ii) = restored2(jj,ii) + 1.0*(error / 4);
  end;
  e2(iteration) = std(restored2(index) - original(index));
end;

figure(5);
plot((1:iteration), e, 'r-', (1:iteration), e2, 'b-', 'linewidth', 3);
legend('No forcing function', 'With forcing function');
xlabel('Iteration', 'fontsize', 20);
ylabel('Std Error', 'fontsize', 20);

figure(6);
image(restored2);
title('Restored Picture (with F)');
colormap(gray(256));