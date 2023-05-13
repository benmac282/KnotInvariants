%Lincoln Potts and Ben McMahan
%data should be structured as: data = [bool, arc number of over-arc]
%bool is true for R.H., false for L.H.

function data=handedness(p1, p2, labeledIm, arcArr, overVec)
    
    %finds the label for the over-arc in the crossing
    overArcNum = labeledIm(overVec.end(1),overVec.end(2));
    
    data = [true, overArcNum];
    
    %correctly orients the over vector
    overVec = overVecDirection(labeledIm, overArcNum, arcArr, overVec);

    %---Sets the handedness of the crossing---
    %gets the angle from the x-Axis for both vectors, then if the
    %difference of the angles is between -360 and -180 or 0 and 180, it is
    %right handed, if it is between -180 and 0 or 180 and 360 it is left
    %handed.
    u = p1-p2;
    oAngle = xAxAngle(overVec.end - overVec.start);
    uAngle = xAxAngle(u);
    angleDiff = uAngle-oAngle;
    if(angleDiff < -180)
        data(1) = true;
    elseif (angleDiff < 0)
        data(1) = false;
    elseif (angleDiff < 180)
        data(1) = true;
    else
        data(1) = false;
    end

end