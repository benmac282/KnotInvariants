%Lincoln Potts and Ben McMahan
%run through the arc array, the index and index+1 (since it is oriented)
%and find the overArc for those two indexes

function crossingArr=makeCrossingArr(labeledIm, arcArr) 
    
    %iterate through the arcArr
    for i=1:length(arcArr)
        %the lagging strand will always be the index, and but the leading
        %will be the index+1 mod length because that will be the one in
        %"Front" of the lagging. 
        crossingArr(i).lagging = i;
        if mod(i+1, length(arcArr)) == 0
            lead = length(arcArr);
            crossingArr(i).leading = length(arcArr);
        else
            lead = mod(i+1, length(arcArr));
            crossingArr(i).leading = mod(i + 1, length(arcArr));
        end
        
        %find the label of the overarc using the overVector function
        overArcNum = overVector(fliplr(arcArr(i).end), fliplr(arcArr(lead).start), labeledIm).end;
        overArcNum = labeledIm(overArcNum(1), overArcNum(2));
        
        %set the overarc for the crossing arr to the overArcNumber
        crossingArr(i).over = overArcNum;
    end
    
end