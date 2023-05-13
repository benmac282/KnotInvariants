%Lincoln Potts and Ben McMahan
%This code should create an arcArr that sorts the endpoints into a struct
%that contains an arbitrary starting and ending point (to be sorted later)

function arcArr=knotArcArrMaker(knotEndpoints, labeledIm)
    %creates the initial arc struct
    arc.start = [0, 0];
    arc.end = [0, 0];
    
    %creates an array of structs with the size being the number of arcs
    arcArr(height(knotEndpoints)/2) = arc;
    
    %iterates through the number of arcs and puts a starting and ending
    %point on every arc.
    for arcNum=1:height(knotEndpoints)/2
        %set the starting endpoint and final endpoint to 0 and found to
        %false
        startEnd = 0;
        found = false;
        finalEnd = 0;
        %iterate through the knotEndpoints struct and find which points are
        %on the arc currently trying to be found. If the start point is 
        %already found, make the final endpoint that point.
        for i=1:height(knotEndpoints)
            if (labeledIm(knotEndpoints(i).Centroid(2), knotEndpoints(i).Centroid(1))==arcNum)
                if(~found)
                    startEnd = knotEndpoints(i);
                    found = true;
                else
                    finalEnd = knotEndpoints(i);
                end 
            end
        end
        
        %put the data into an arc struct then that arc struct into the
        %array.
        arc.start=[startEnd(1).Centroid(1), startEnd(1).Centroid(2)];
        arc.end=[finalEnd(1).Centroid(1), finalEnd(1).Centroid(2)];
        arcArr(arcNum)=arc;
    end
end