%Ben McMahan and Lincoln Potts
%Gets the binary image and labels it to label each arc
function regionIm=Regions(knotIm)
    binKnot=binaryKnot(knotIm);
    regionIm = bwlabel(binKnot);
end