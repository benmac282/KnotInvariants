%Ben McMahan and Lincoln Potts
% This function sorts the arc arr by orientation. This is done by starting
% with the first arc that was randomly assigned, then putting the next
% start point as the closest endpoint to the current end point.

function [arcArr, labeledIm] = arcSort(arcArr, labeledIm)
    for i=1:length(arcArr) - 1
        p1 = arcArr(i).end;
        
        %p1label switch with i and vice versa
        x = p1(2);
        y = p1(1);
    
        p1Label = labeledIm(x, y);
    
        labeledIm = switchLabel(labeledIm, p1Label, i);
    
        smallDist = 10000;
        closeArc = 0;
        endCloser = false;
        for j = i + 1:length(arcArr)
            p2 = arcArr(j).start;
            dist = distance(p1, p2);
            if dist < smallDist
                closeArc = j;
                smallDist = dist;
                endCloser = false; %Just Changed
            end
            p2 = arcArr(j).end;
            dist = distance(p1, p2);
            if dist < smallDist
                closeArc = j;
                smallDist = dist;
                endCloser = true;
            end
        end
    
        %swap row i + 1 with closeArc
        arcArr = swapRow(arcArr, i + 1, closeArc);
    
    
        %swap end and start if endCloser
        if endCloser
            temp = arcArr(i + 1).end;
            arcArr(i + 1).end = arcArr(i + 1).start;
            arcArr(i + 1).start = temp;
        end
    end
end