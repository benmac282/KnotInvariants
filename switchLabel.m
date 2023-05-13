%Ben McMahan and Lincoln Potts
%This function switches the label assigned by bwlabel of an entire region.
%This is done for organizational purposes.

function labeledIm=switchLabel(labeledIm, arcNum, trueLabel)

%changes arcNum to arbitrary
    [r,c] = find(labeledIm==arcNum);
    rc = [r c];
    
    for index=1:height(rc)
        labeledIm(rc(index,1),rc(index,2)) = -1;
    end
%changes trueLabel to the place
    [r,c] = find(labeledIm==trueLabel);
    rc = [r c];
    
    for index=1:height(rc)
        labeledIm(rc(index,1),rc(index,2)) = arcNum;
    end

%change arcNum to correct label
    [r,c] = find(labeledIm==-1);
    rc = [r c];
    
    for index=1:height(rc)
        labeledIm(rc(index,1),rc(index,2)) = trueLabel;
    end

end