function [triangles, squares, circles, mask] = shapes(img)
    % Return the centroids of all triangles, squares, and circles.
    %
    % Inputs Variable:
    %        img will be a grayscale image of type uint8.
    %
    % Outputs:
    %   triangles, squares, cirles should be of shape [n, 2]
    %   mask should be the binarized image, but is not evaluated. It can be
    %   helpful for your debugging.
    
    % Initialise centroid vectors
    triangles=zeros(4,2);
    squares=zeros(4,2);
    circles=zeros(4,2);
 
    % initialise counters
    sqc = 0;
    trc = 0;
    cic = 0;
    
    mask = binarize(img);
    [L,nb]=bwlabel(mask);
    
    prop = regionprops(L,"Circularity", "Centroid", "Area");
    for x=1:nb
        shape = shape_classification(prop(x).Circularity);

        if(prop(x).Area>10)    % this line ensures no pixelated dots remain
            switch shape           
                case 2
                    sqc = sqc + 1;
                    squares(sqc, :)=prop(x).Centroid;
                case 1
                    cic = cic + 1;
                    circles(cic, :)=prop(x).Centroid;
                otherwise
                    trc = trc + 1;
                    triangles(trc,:)=prop(x).Centroid;
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
 function mask = binarize(img)
    BW = imbinarize(img, 'Adaptive', 'ForegroundPolarity', 'dark');
    BW_reversed = imcomplement(BW); % negative of BW
    mask = imfill(BW_reversed,"holes"); % Fill holes in mask
 end
    
    
end
    