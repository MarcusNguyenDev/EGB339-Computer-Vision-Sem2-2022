function [disparity, distance] = get_stereo(img_left, img_right)
    % Return the disparity in pixels, and the distance in meters.
    % Both images will be RGB color images of type uint8.
    %
    % Carefully read the problem description.
    
    centroids_left = segment_blue_markers(img_left);
    centroids_right = segment_blue_markers(img_right);
    distance=0;
    disparity=(centroids_right(1,1))-centroids_left(1,1);
    
    pixel_size = 0.000004;
    b = 0.05;
    d = pixel_size*disparity;
    f = 0.0025;

    distance = f*b/d;
    function  centroids = segment_blue_markers(img)
        img = imadjust(img,[],[],0.6);
        centroids=[];
        
        R = img(:,:,1);
        G = img(:,:,2);
        B = img(:,:,3);
    
        Y = R + G + B;
        r = R ./Y;
        b = B./Y;
        g = G./Y;
    
        BW_R=r>0.6;
        BW_G=g>0.6;

        BW=(logical(BW_R + BW_G));

        binary_img = imcomplement(BW);
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
end