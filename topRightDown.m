%Lincoln Potts and Ben McMahan
%This function searches the image on a line from the top right point of a
%box, downward. It should return a point if it found one, and if not return
%[-1,-1].

function point=topRightDown(labeledIm, sideLength, midpoint, l1, l2)
    point = [-1, -1];
    
    %set the top right point to the midpoint up by half a sidelength and
    %to the right by half a sidelength.
    tRP = [midpoint(1) - round(sideLength/2), midpoint(2) + round(sideLength/2)];

    %search every point along the sidelength downward from the top right
    %point and set the point to return to the one found if it isn't the
    %same label as the two underarcs.
    for i=1:round(sideLength)
        tempLab = labeledIm(tRP(1) + i, tRP(2));
        if (tempLab > 0 && tempLab ~= l1 && tempLab ~= l2)
            point = [tRP(1) + i, tRP(2)];
            break;
        end
    end
end