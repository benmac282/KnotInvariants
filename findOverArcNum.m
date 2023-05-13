% Ben McMahan and Lincoln Potts
% This function finds the over arc number of the over-arc in a specific
% crossing. This is done by searching a box around the midpoint between the
% two strands of the under-arc. When found it returns the two points found.

function overArc = findOverArcNum(labeledIm, p1, p2) 
    
    midpoint = [round((p1(1) + p2(1))/2), round((p1(2) + p2(2))/2)];
    sideLength = 1;
    point = [-1, -1];

    while point(1) == -1
        for i=1:round(sideLength)
            %BottomLeftRight
            tempLab = labeledIm(midpoint(1) + round(sideLength/2), midpoint(2) - round(sideLength/2) + i);
            if (tempLab > 0)
                point = [midpoint(1), midpoint(2)];
                break;
            end
            
            %BottomLeftUp
            tempLab = labeledIm(midpoint(1) + round(sideLength/2) - i, midpoint(2) - round(sideLength/2));
            if (tempLab > 0)
                point = [midpoint(1), midpoint(2)];
                break;
            end
            
            %TopRightDown
            tempLab = labeledIm(midpoint(1) - round(sideLength/2) + i, midpoint(2) + round(sideLength/2));
            if (tempLab > 0)
                point = [midpoint(1), midpoint(2)];
                break;
            end
            
            %TopRightLeft
            tempLab = labeledIm(midpoint(1) - round(sideLength/2), midpoint(2) + round(sideLength/2) - i);
            if (tempLab > 0)
                point = [midpoint(1), midpoint(2)];
                break;
            end
            sideLength = sideLength * 2;
        end
    end

    overArc = labeledIm(point(1),point(2));
end