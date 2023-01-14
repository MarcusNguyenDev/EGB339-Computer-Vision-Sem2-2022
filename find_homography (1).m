function H = find_homography(filename)
    % Write a function that returns the Homography matrix as explained in the Problem description.
     
    % load the image
    img = imread(filename);
    
    % If you could not sovle Problem 2 (Segmentation of the Calibration Markers), 
    % you can call the get_centroids function below. However, this will cost you 2% of your marks.    
    % This function returns the centroids and areas (in pixels) for the blue markers. 
    % However, the ordering is arbitrary, i.e. the big circle is not guaranteed to be in position 1, etc.
    
    % [centroids, areas] = get_centroids(filename);
    
    
    
    
    % INSERT YOUR CODE HERE
    
    
    
    
    % store the image coordinates of the calibration marker centroids in the right order in P
    % P = [];
    
    % Using the same ordering, store the workspace coordinates of the calibration markers in Q.
    % Consult the problem description for coordinates.
    % You have to make sure that the coordinates in P and Q correspond to each other.
    % Q = [];
    
    % use the function simple_homography() to calculate the homography between two sets of points.    
    % H = simple_homography(P,Q);
    
    
        % Write a function that returns the Homography matrix as explained in the Problem description.
     
    % load the image
    img = imread(filename);
    
    % If you could not solve Problem 2 (Segmentation of the Calibration Markers), 
    % you can call the get_centroids function below. However, this will cost you 2% of your marks.    
    % This function returns the centroids and areas (in pixels) for the blue markers. 
    % However, the ordering is arbitrary, i.e. the big circle is not guaranteed to be in position 1, etc.
    
    % [centroids, areas] = get_centroids(filename);
    % ACTUAL CODE TO USE: [binary_img, centroids] = segment_blue_markers(img)
   
    
    
    % INSERT YOUR CODE HERE
    
    % Workspace calibration coords
    Q = [0 0 250 250 0 250 500 500 500; 0 250 250 0 500 500 500 250 0];%; 0 0 0 0 0 0 0 0 0];
    
    % Initialise the image calibration coords, p
    P = zeros(2,9);      % IS THIS MEANT TO BE ONES OR ZEROS?????
    
    %% Solve for P
    % Extract the coordinates of the images
    [~,centroids, centroid_areas] = biggest_blue_marker(img);
    Tcentroids = centroids';
    P(1:2,1) = Tcentroids(:,1);
    P(1:2,2) = Tcentroids(:,2);
    P(1:2,3) = Tcentroids(:,5);
    P(1:2,4) = Tcentroids(:,4);
    P(1:2,5) = Tcentroids(:,3);
    P(1:2,6) = Tcentroids(:,6);
    P(1:2,7) = Tcentroids(:,9);
    P(1:2,8) = Tcentroids(:,8);
    P(1:2,9) = Tcentroids(:,7);
    
    
    
    
    
    %% Hints
    
    % P = [];
    
    % Using the same ordering, store the workspace coordinates of the calibration markers in Q.
    % Consult the problem description for coordinates.
    % You have to make sure that the coordinates in P and Q correspond to each other.
    % Q = [];
    
    % use the function simple_homography() to calculate the homography between two sets of points.    
    H = simple_homography(P,Q);
    %% Debugging
    P
    Q
    
    function [binary_img, centroids, centroid_areas] = biggest_blue_marker(img)

% Find the blue markers in an image. 
%   Return Values:
%     binary_img must be of type logical.
%     centroids must be of shape [n, 2].    
%
    % Adjust the gamma of the img
    img = imadjust(img,[],[],0.7);

    % Initialize arrays
    centroids=[];
    centroid_areas=[];
    
    % R G B similar to Colour lecture
    
    R = img(:,:,1);
    G = img(:,:,2);
    B = img(:,:,3);
    
    Y = R + G + B;
    r = R ./Y;
    b = B./Y;
    g = G./Y;
    
    BW_R=r>0.6;
    BW_G=g>0.6;
    
    % Extract the BW img and then inverse it
    BW=(logical(BW_R + BW_G));

    binary_img = imcomplement(BW);

    % Simirlar to problem one
    [L,nb]=bwlabel(binary_img);

    prop = regionprops(L,"Centroid","Area","Circularity");
    
    for x=1:nb
        if(prop(x).Area>50)
            shape = shape_classification(prop(x).Circularity);
            centroid_areas=[centroid_areas;prop(x).Area];
            if(shape==1)
                centroids=[centroids;prop(x).Centroid];
            end
        end
    end

    function shape = shape_classification(sirqularity)

        shape = 0;

        if(sirqularity>0.89)
            shape = 1;
        end

        if(sirqularity<=0.89&&sirqularity>0.63)
            shape = 2;
        end

        shape = int8(shape);
    end
end
end