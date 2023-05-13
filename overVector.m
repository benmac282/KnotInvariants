%Lincoln Potts and Ben McMahan
%This function should return the "overvector" of the overarc in the middle of
%the two points. it should return this as a struct with the start and endpoints.

function overVec=overVector(p1, p2, labeledIm)

    %the sidelength of each the search box is the distance between the two
    %points. The function needs the midpoint of the two points and the
    %labels of the two arcs of the points. Initialize the overvector start
    %and end as [-1,-1] which cannot be a point.
    sideLength = round(distance(p1,p2));
    midpoint = [round((p1(1) + p2(1))/2), round((p1(2) + p2(2))/2)];
    l1 = labeledIm(p1(1), p1(2));
    l2 = labeledIm(p2(1), p2(2));
    
    overVec.start = [-1, -1];
    overVec.end = [-1, -1];
    
%---Finds the two points on the vector---
    %run while the endpoint of the vector hasn't been found.
    while overVec.end(2) == -1
        %if the sidelength is less than one, there is likely a twist so
        %display twist found and return to let Alexander polynomial handle
        %that.
        if(sideLength < 1)
            disp("Twist Found");
            return
        end

        %try to find a point using the topRightDown function.
        temp = topRightDown(labeledIm, sideLength, midpoint, l1, l2);

        %if that point is found, try to find a point using the bottomLeftUp
        %function.
        if(temp(1) ~= -1)
            overVec.start = temp;
            temp2 = bottomLeftUp(labeledIm, sideLength, midpoint, l1, l2);

            %if that did find a point, set the endpoint to it and break the
            %loop.
            if(temp2(1) ~= -1)
                overVec.end = temp2;
                break;
            else
                %if it did not, reduce the sideLength until a point has
                %been found
                while overVec.end(1) == -1
                    temp2 = bottomLeftUp(labeledIm, sideLength, midpoint, l1, l2);
                    if(temp2(1) ~= -1)
                        overVec.end = temp2;
                    else
                        sideLength = 3 * sideLength / 4;
                    end
                end
            end
        else
            %if topRightDown didn't find a point, try topRightLeft
            temp = topRightLeft(labeledIm, sideLength, midpoint, l1, l2);
            if (temp(1) ~= -1)
                %if a point was found, repeat the process used before,
                %except this time use the function bottomLeftRight
                overVec.start = temp;
                temp2 = bottomLeftRight(labeledIm, sideLength, midpoint, l1, l2);
                if(temp2(1) ~= -1)
                    overVec.end = temp2;
                    break;
                else
                    while overVec.end(1) == -1
                        temp2 = bottomLeftRight(labeledIm, sideLength, midpoint, l1, l2);
                        if(temp2(1) ~= -1)
                            overVec.end = temp2;
                        else
                            sideLength = 3 * sideLength / 4;
                        end
                    end
                    break;
                end
            else
                %if no point was found, reduce the sideLength
                sideLength = 3 * sideLength / 4;
                continue;
            end
        end
    end
%------

    

end