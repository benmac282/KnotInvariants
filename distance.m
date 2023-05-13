%Lincoln Potts and Ben McMahan
%This function finds the distance between to points (inputted as vectors)
function distance=distance(p1, p2)
    distance=sqrt((p1(1,1)-p2(1,1))^2+(p1(1,2)-p2(1,2))^2);
end