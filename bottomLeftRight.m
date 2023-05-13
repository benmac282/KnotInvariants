%Lincoln Potts and Ben McMahan
%This function searches the image on a line from the bottom left point of a
%box, to the right. It should return a point if it found one, and if not return
%[-1,-1].

function point=bottomLeftRight(labeledIm, sideLength, midpoint, l1, l2)
    point = [-1, -1];

    %set the bottom left point to the midpoint down by half a sidelength and
    %to the left by half a sidelength.
    bLP = [midpoint(1) + round(sideLength/2), midpoint(2) - round(sideLength/2)];

    %search every point along the sidelength right from the bottom left
    %point and set the point to return to the one found if it isn't the
    %same label as the two underarcs.
    for i=1:round(sideLength)
        tempLab = labeledIm(bLP(1), bLP(2) + i);
        if (tempLab > 0 && tempLab ~= l1 && tempLab ~= l2)
            point = [bLP(1), bLP(2) + i];
            break;
        end
    end
end