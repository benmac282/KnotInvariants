%Lincoln Potts and Ben McMahan
%Use a variable to hold the used colors, and label each arc with a color if
%one is availible, if one isn't, make a new color and add it to both
%structs. Iterate through every crossing in order to do this.

function GraphColored(labeledIm, arcArr)
    %DO NOT CALL FUNCTION WITH UNKNOT
    %important variables
    %usedColors: the colors used so far
    %crossingArr: struct with each crossings over, lagging and leading arc
    %arcColors: each arcs color (parallel indexes with arcArr)
    crossingArr = makeCrossingArr(labeledIm, arcArr);

    

    %create a structure to hold each arc's colors and a boolean for if it
    %is colored.
    arcColors = arrayfun( @(x)struct('color',[0,0,0],'isColored',false),zeros(1,length(arcArr)) );

    %initialize the first crossing's colors
    usedColors(1).color = [0,0,1];
    usedColors(2).color = [0,1,0];
    usedColors(3).color = [1,0,0];
    arcColors(crossingArr(1).lagging).color = [0,0,1];
    arcColors(crossingArr(1).over).color = [1,0,0];
    arcColors(crossingArr(1).leading).color = [0,1,0];
    arcColors(crossingArr(1).lagging).isColored = true;
    arcColors(crossingArr(1).over).isColored = true;
    arcColors(crossingArr(1).leading).isColored = true;

    for i=2:length(crossingArr)
        %check if each arc (leading and over) is colored and if it
        %isn't, color it.
        %coloring each arc: check to see what it is the overarc to and make
        %sure it doesn't color it that way
        if ~arcColors(crossingArr(i).over).isColored
            possibleColors = usedColors;
            possibleColors = removeColor([0,0,0], possibleColors);

            for j=1:length(crossingArr)
                %remove the colors that aren't possible because it is
                %overarc, lagging, or leading to another arc
                if (crossingArr(j).over == crossingArr(i).over && i ~= j)
                    possibleColors = removeColor(arcColors(crossingArr(j).lagging).color, possibleColors);
                    possibleColors = removeColor(arcColors(crossingArr(j).leading).color, possibleColors);
                end
                if (crossingArr(j).lagging == crossingArr(i).over)
                    possibleColors = removeColor(arcColors(crossingArr(j).leading).color, possibleColors);
                end
                if (crossingArr(j).leading == crossingArr(i).over)
                    possibleColors = removeColor(arcColors(crossingArr(j).lagging).color, possibleColors);
                end
            end
            %remove the leading and lagging strand colors of the specific
            %crossing
            possibleColors = removeColor(arcColors(crossingArr(i).leading).color, possibleColors);
            possibleColors = removeColor(arcColors(crossingArr(i).lagging).color, possibleColors);


            %if no colors are possible, make it a new color and add that
            %color to the arcColors
            try
                arcColors(crossingArr(i).leading).color=possibleColors(1).color;
                arcColors(crossingArr(i).over).isColored=true;
            catch
                newColor = [rand,rand,rand];
                arcColors(crossingArr(i).over).color=newColor;
                usedColors(length(usedColors)).color = newColor;
                arcColors(crossingArr(i).over).isColored=true;
            end
        end


        if ~arcColors(crossingArr(i).leading).isColored
            possibleColors = usedColors;
            possibleColors = removeColor([0,0,0], possibleColors);

            for j=1:length(crossingArr)
                %remove the colors that aren't possible because it is
                %overarc, lagging, or leading to another arc
                if (crossingArr(j).over == crossingArr(i).leading)
                    possibleColors = removeColor(arcColors(crossingArr(j).lagging).color, possibleColors);
                    possibleColors = removeColor(arcColors(crossingArr(j).leading).color, possibleColors);
                end
                if (crossingArr(j).lagging == crossingArr(i).leading)
                    possibleColors = removeColor(arcColors(crossingArr(j).lagging).color, possibleColors);
                    possibleColors = removeColor(arcColors(crossingArr(j).over).color, possibleColors);
                end
                if (crossingArr(j).leading == crossingArr(i).leading && i ~= j)
                    possibleColors = removeColor(arcColors(crossingArr(j).leading).color, possibleColors);
                    possibleColors = removeColor(arcColors(crossingArr(j).over).color, possibleColors);
                end
            end
            %remove the lagging and over colors of the specific crossing
            possibleColors = removeColor(arcColors(crossingArr(i).lagging).color, possibleColors);
            possibleColors = removeColor(arcColors(crossingArr(i).over).color, possibleColors);

            %if no colors are possible, make it a new color and add that
            %color to the arcColors
            try
                arcColors(crossingArr(i).leading).color=possibleColors(1).color;
                arcColors(crossingArr(i).leading).isColored=true;
            catch
                newColor = [rand,rand,rand];
                arcColors(crossingArr(i).leading).color=newColor;
                usedColors(length(usedColors)).color = newColor;
                arcColors(crossingArr(i).leading).isColored=true;
            end
        end
    end

    

    %draw the knot with the code used in the driver, except use the colors
    %given previously.
    figure;
    title("Properly Colored Knot");
    for i=1:length(arcArr)
        [r,c] = find(labeledIm==i);
        rc = [r c];
        
        hold on;
        axis([0,819,0,460]);
        for index=1:height(rc)
            plot(rc(index,2), 460-rc(index,1),'.','color',arcColors(i).color,'markerSize',1);
        end
    end

end