%Lincoln Potts and Ben McMahan
% start with one of the over vector's endpoints, split the arc into two
% regions at that endpoint. Then, calculaate the perimeter of the
% region that contains the endpoint of the over-arc. Do this for both
% vector enpoints and compare the perimeters. The point that caused the
% smaller perimeter is set as the endpoint of the vector, and the other
% point is set as the start point. Return this new vector.

function overVec = overVecDirection(labeledIm, overArcNum, arcArr, overVec)
    perims = splitRegion(labeledIm, overArcNum, arcArr, overVec);
    %perims = [perim from endpnt, perim from startpnt]

    % changes the overVec to have correct orientation according to
    % splitRegion function
    if perims(1) > perims(2)
        temp = overVec.start;
        overVec.start = overVec.end;
        overVec.end = temp;
    end

end