%Lincoln Potts and Ben McMahan
%This function converts a gray image of a knot drawn with a white 
%background to a binary image of only the noteable regions.

function binKnot=binaryKnot(knotIm)
    %the blank image is just a plain white image
    blankIm=rgb2gray(imread("TestImages\blank.jpg"));
    
    knotIm = blankIm - knotIm;
    
    %Find the average difference in the images to use as a threshold
    %[doesn't work]
    %avgDiff = sum(knotIm, "all") / (460 * 819);
    
    %creates a binary image where there is the biggest differences
    knotIm = knotIm>50;
    
    %creates an image where there is only the large spaces of difference
    binKnot=bwareaopen(knotIm,100);
end