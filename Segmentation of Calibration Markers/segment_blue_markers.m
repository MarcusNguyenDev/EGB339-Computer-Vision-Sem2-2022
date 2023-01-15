function [binary_img, centroids] = segment_blue_markers(img)
% Find the blue markers in an image. 
%   Return Values:
%     binary_img must be of type logical.
%     centroids must be of shape [n, 2].    
%
    % Adjust the gamma of the img
    img = imadjust(img,[],[],0.7);

    % Initialize array
    centroids=[];
    
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