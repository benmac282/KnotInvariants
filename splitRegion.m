%Lincoln Potts and Ben McMahan
%Split the region in two as described in overVecDirection. Return
%perims as [perimeter from endpoint, perimeter from start point]

function perims = splitRegion(labeledIm, overArcNum, arcArr, overVec)
    oAIm = labeledIm;
    clear labeledIm;

    %iterate through every arc and clear everything except for the overarc
    for i=1:length(arcArr)
        %if the index is the overArcNum continue
        if i==overArcNum
            continue;
        end
        %set all of the values with that label to 0
        [r,c] = find(oAIm==i);
        rc = [r c];
        
        for index=1:height(rc)
            oAIm(rc(index,1),rc(index,2)) = 0;
        end
    end
    clear index rc r c i;
    
    %Split the image at the start of overVec
    sideLength = 2;
    twoRegions = false;
    startToEndRegion = oAIm;

    %while there isn't two regions, keep splitting the region by more and
    %more.
    while twoRegions == false
        sideLength = sideLength + 3;
        
        startToEndRegion((overVec.start(1) - round(sideLength/2)):(overVec.start(1) + round(sideLength/2)), ...
            (overVec.start(2) - round(sideLength/2)):(overVec.start(2) + round(sideLength/2))) = 0;
        
        startToEndRegion=bwlabel(startToEndRegion);

        test = isempty(find(startToEndRegion==2));
        if test == 0
            twoRegions = true;
        end
        clear test;
    end
    

    %Split the image at the endpoint of overVec
    sideLength = 2;
    twoRegions = false;
    endToEndRegion = oAIm;
    %do the same thing as before, except split the image at the end point
    %rather than the start point.
    while twoRegions == false
        sideLength = sideLength + 3;
        
        endToEndRegion((overVec.end(1) - round(sideLength/2)):(overVec.end(1) + round(sideLength/2)), ...
            (overVec.end(2) - round(sideLength/2)):(overVec.end(2) + round(sideLength/2))) = 0;
        
        endToEndRegion=bwlabel(endToEndRegion);
        
        test = isempty(find(endToEndRegion==2));
        if test == 0
            twoRegions = true;
        end
        clear test;
    end

    %leave only the region with the startToEndRegion in it
    corrReg = startToEndRegion(arcArr(overArcNum).end(2),arcArr(overArcNum).end(1));
    if corrReg==1
        [r,c] = find(startToEndRegion==2);
        rc = [r c];
    
        for index=1:height(rc)
            startToEndRegion(rc(index,1),rc(index,2)) = 0;
        end
    else
        [r,c] = find(startToEndRegion==1);
        rc = [r c];
    
        for index=1:height(rc)
            startToEndRegion(rc(index,1),rc(index,2)) = 0;
        end
    end
    

    %do the same thing for the endToEndRegion
    corrReg = endToEndRegion(arcArr(overArcNum).end(2),arcArr(overArcNum).end(1));
    if corrReg==1
        [r,c] = find(endToEndRegion==2);
        rc = [r c];
    
        for index=1:height(rc)
            endToEndRegion(rc(index,1),rc(index,2)) = 0;
        end
    else
        [r,c] = find(endToEndRegion==1);
        rc = [r c];
    
        for index=1:height(rc)
            endToEndRegion(rc(index,1),rc(index,2)) = 0;
        end
    end
    
    %make the only noteable region the one that is still labeled
    endToEndRegion = bwareaopen(endToEndRegion,1);
    startToEndRegion = bwareaopen(startToEndRegion, 1);

    %measure the regions perimeters
    perim1=regionprops(endToEndRegion, 'Perimeter');

    perim2=regionprops(startToEndRegion, 'Perimeter');

    perims = [perim1.Perimeter, perim2.Perimeter];
end