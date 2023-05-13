%Ben McMahan and Lincoln Potts
% This function finds the angle between the vector and the x axis.

function vAng=xAxAngle(v)
    %v(1) = x ; v(2) = y

    %base the angle off of what quadrant the vector is pointing toward.
    if(v(1) < 0)
        if(v(2) <= 0)
            vAng = atand(v(2)/v(1))+180;
        else
            vAng = 180+atand(v(2)/v(1));
        end
    end
    if(v(1) >= 0)
        if(v(2) < 0)
            vAng = 360+atand(v(2)/v(1));
        else
            vAng = atand(v(2)/v(1));
        end
    end    
    if (vAng == 360)
        vAng = 0;
    end
end