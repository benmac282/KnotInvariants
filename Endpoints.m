%Lincoln Potts and Ben McMahan
%this function finds the endpoints of the knot given the image.
%It outputs the data in a struct 1 by length(knotStats)*2 because that
%should be the number of endpoints. To find each endpoint you find the
%centroid of each region after several functions are performed to thin the
%image to the endpoints.

function endPointLocations=Endpoints(knotIm)
    binKnot=binaryKnot(knotIm);
    
    %find the number of arcs in the image
    knotStats = regionprops(binKnot,'MajorAxisLength');
    
    %the skel morph creates a sort of skeleton of the image which is the
    %basically the lines of the image
    skelKnot = bwmorph(binKnot, 'skel', Inf);
    
    %the endpoints morph creates an image with just the endpoints of the
    %skeleton
    endPoints = bwmorph(skelKnot, 'endpoints', Inf);

    %finding the centroid of every region gives the (y,x) -[Not a typo] of 
    %each endpoint
    endPointLocations = regionprops(endPoints, 'Centroid');
    
    %put into a for loop until endpoints = length(knotStats) * 2 which is # of
    %endpoints
    while height(endPointLocations) > length(knotStats) * 2

        %these functions thin the skeleton line and despurs(kind of like
        %shaving unconnected dots) the skel image
        skelKnot = bwmorph(skelKnot, 'thin', 1);
        skelKnot = bwmorph(skelKnot, 'spur', 1);
    
        endPoints = bwmorph(skelKnot, 'endpoints', Inf);
    
        endPointLocations = regionprops(endPoints, 'Centroid');

        %if there is less endpoints than there should be then you display
        %that and break the loop
        if height(endPointLocations) < length(knotStats) * 2
            disp("Endpoints Not processed Correctly");
            break;
        end
    end
    
    disp("# of arcs and crossings: " + length(knotStats));
 end