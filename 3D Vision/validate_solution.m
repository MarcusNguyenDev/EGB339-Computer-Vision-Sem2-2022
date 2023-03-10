function validate_solution()
    % Use this function to validate your solution.
    % 
    % It iterates over all test images and calls your solution in line 18. 
    % Feel free to edit this function to help you debug and test your
    % solution!
        
    close all; clear all;  
         
    for i = 1:10
        % load the image (change the path if needed)
        img_filename_left = sprintf('test_images/test_%02d_left.png', i);
        img_left = imread(img_filename_left);  

        img_filename_right = sprintf('test_images/test_%02d_right.png', i);
        img_right = imread(img_filename_right); 
        
        % load the true answer (change the path if needed)
        data_filename = sprintf('test_images/test_%02d.mat', i);
        load(data_filename); 
        true_disparity = disparity;
        
        % ==================================================
        % >>>>>>>> CALL YOUR FUNCTION HERE <<<<<<<<
        [img_disparity, distance] = get_stereo(img_left,img_right);
        % ==================================================
        
        % uncomment this for debugging / plotting
%         figure(); imshow(binary_img);
%         figure(); imshow(img);
%         hold on;
%         plot(centroids(:,1), centroids(:,2), 'r*')
%         plot(centroid_markers(:,1), centroid_markers(:,2), 'go');
%         hold off;
%         title(img_filename, 'interpreter', 'none');
%         pause(0.1);

        % did your script return too many centroids? There are only 9 true
        % centroids!
        if img_disparity ~= disparity
            fprintf('!!! Error in image %d!\n', i);
        else
            fprintf('Image %d correctly analysed.\n',i);
        end
    end
    
    
end