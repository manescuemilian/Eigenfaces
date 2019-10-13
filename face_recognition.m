function [min_dist, output_img_index] = face_recognition(image_path, m, A, eigenfaces, pr_img)
  matrix = double(rgb2gray(imread(image_path)));
  vector_img = reshape(matrix, [], 1);
  vector_img = vector_img - m;
  
  PrTestImg = eigenfaces' * vector_img;
  
  [~, col] = size(pr_img);
  min_dist = norm(PrTestImg - pr_img(:, 1));
  output_img_index = 1;
  for i = 2 : col
      if norm(PrTestImg - pr_img(:, i)) < min_dist
        min_dist = norm(PrTestImg - pr_img(:, i));
        output_img_index = i;
      end
  end
end