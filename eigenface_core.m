function [m A eigenfaces pr_img] = eigenface_core(database_path)
  for i = 1 : 10
    image_path = strcat(database_path,'/',int2str(i),'.jpg');
    matrice = double(rgb2gray(imread(image_path)));
    vector_img = reshape(matrice, [], 1);
    T(:, i) = vector_img(:, 1);
  end
 
  [row col] = size(T);
  for i = 1 : row
     m(i, 1) = sum(T(i, :)) / col;
  end
  
  A = T - m;
  [V D] = eig(A' * A);
  eigenval = diag(D);
  [row col] = size(V);
  index = 1;
  for i = 1 : col
    if eigenval(i) > 1
      eigenvec(:, index) = V(:, i);
      index = index + 1;  
    end
  end
  
  V = eigenvec(:, :);
  eigenfaces = A * V;
  pr_img = eigenfaces' * A;
end