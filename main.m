function main()
  clc
  clear
  close all
  format long
  
  database_path = './dataset';
  in_path = strcat(pwd, '/in');
  max_dif = 10*200^3;

  [m, A, eigenfaces, pr_img] = eigenface_core(database_path);

  % write results to a file
  fid = fopen('./out/results.txt', 'w');
   
  for i = 1 : 6
    image_path = strcat(in_path,'/',int2str(i),'.jpg');
    image_name = strcat(int2str(i),'.jpg');
    
    [min_dist, output_img_index] = face_recognition(image_path, m, A, eigenfaces, pr_img);
    
    if (min_dist < max_dif)
        output_name = strcat(int2str(output_img_index),'.jpg');
        selected_image = strcat(database_path,'/',output_name);
        selected_image = imread(selected_image);
        
        test_image = imread(image_path);

        figure,imshow(test_image)
        title('Test Image');
        figure,imshow(selected_image);
        title('Equivalent Image');
        
        msg = strcat('Matched image is: ',output_name);
        disp(msg);
        fprintf(fid, "%s\n", msg);
    elseif (min_dist < max_dif * 5 / 4)
        fprintf('%s is a human face, but not a known one\n', image_name);
        fprintf(fid, "%s is a human face, but not a known one\n", image_name);
    else
        fprintf('%s image is not a human face\n', image_name);
        fprintf(fid, "%s image is not a human face\n", image_name);
    end
  end
  fclose(fid);
end