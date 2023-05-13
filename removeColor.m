%Lincoln Potts and Ben McMahan
%should remove the struct that has the color from the struct arr 
function possibleColors=removeColor(color, possibleColors)
    %iterate through the array without skipping any structs. increase index
    %only if you don't remove a color.
    index = 1;
    while index<=length(possibleColors)
        if possibleColors(index).color == color
            possibleColors(index) = [];
            continue;
        end
        index = index+1;
    end
end