%Lincoln Potts and Ben McMahan
%connect the two arcs using arc1's endpoint, and arc2's starting point.

function [arcArr, labeledIm]=twistFix(arc1, arc2, arcArr, labeledIm)
    
    p1 = arcArr(arc1).end;

    %handles non-obvious unknots
    try
        p2 = arcArr(arc2).start;
    catch
        %warning('Suspected Unknot, Alexander Polynomial set to 0');
        disp("Suspected unknot projection");
        arcArr(1).start = -1;
        return;
    end

    %connect the two arcs with a line and re-label using arcSort.
    hold on;
    line([p1(1),p2(1)],[p1(2),p2(2)],'LineWidth',3,'Color','blue');
    title("Twist Fixes");
    hold off;
    labeledIm = getframe;
    labeledIm = im2gray(labeledIm.cdata) > 0;
    labeledIm = bwlabel(labeledIm);

    arcArr(arc1).end = arcArr(arc2).end;
    arcArr(arc2) = [];
    

    [arcArr, labeledIm] = arcSort(arcArr, labeledIm);
end