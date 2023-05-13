%Ben McMahan and Lincoln Potts
%This file is the driver for all of our functions. It outputs the
%information needed and calls the functions we implement.
clear;

%handles the user inputted file name
imPath = input("Enter the name of the knot image file: ", "s");
try
    labeledIm = Regions(rgb2gray(imread("TestImages\" + imPath)));
catch 
    if(contains(imPath, "png"))
        imPath = replace(imPath, "png", "jpg");
    elseif(contains(imPath, "jpg"))
        imPath = replace(imPath, "jpg", "png");
    else
        try
            imPath = imPath + ".png";
            labeledIm = Regions(rgb2gray(imread("TestImages\" + imPath)));
          catch
              imPath = replace(imPath, "png", "jpg");
              labeledIm = Regions(rgb2gray(imread("TestImages\" + imPath)));
         end
    end
    
    labeledIm = Regions(rgb2gray(imread("TestImages\" + imPath)));

end
%gets the endpoints structure
knotEndpoints = Endpoints(rgb2gray(imread("TestImages\" + imPath)));

%creates a structure with the endpoints sorted into an arc(endpoints)
%format. The try catch statement handles the unknot case 
arcArr = knotArcArrMaker(knotEndpoints, labeledIm);
aPoly = sym(0);

%Sorts the arcArr with orientation
[arcArr, labeledIm] = arcSort(arcArr, labeledIm);

%This code plots the knot with endpoints and knot orientation
%create the figure with a title
figure;
title("Knot Drawn with Oriented Endpoints Shown");

%loop through every arc number
for i=1:length(arcArr)
    %find where the image is equal to the arc number
    [r,c] = find(labeledIm==i);
    rc = [r c];
    
    %plot the points as small blue dots then plot the endpoints as bigger 
    %red dots and starting points as bigger green dots
    hold on;
    axis([0,819,0,460]);
    for index=1:height(rc)
        plot(rc(index,2), 460-rc(index,1),'.','color',[0,0,1],'markerSize',1);
    end
    plot(arcArr(i).start(1), 460-arcArr(i).start(2),".", 'color', [1,0,0], 'markerSize',20);
    plot(arcArr(i).end(1), 460-arcArr(i).end(2),".",'color',[0,1,0], 'markerSize',20);
end

%Displays arcArr info if wanted
%disp(struct2table(arcArr));
%disp("start and end are both cartesian coordinate values");

%set the twist count to 0 on the outside for recursion purposes
twistCnt = 0;

%finds the alexander polynomial
[aPoly, arcArr, labeledIm] = AlexanderPolynomial(arcArr, labeledIm, twistCnt);

% finds the colorability number
t = -1;
colNum = subs(aPoly);

%finds the unique prime factors
factors = factor(colNum);
temp = [];
cnt = 1;
for i = 1:length(factors)
    num = factors(i);
    exists = find(ismember(num, temp) == 1);
     if(num >= 3 && isempty(exists) && num <= length(arcArr))
        temp(1, cnt) = num;
        cnt = cnt + 1;
     end
end
% factors is the set of valid colorability numbers
factors = temp;

str = sprintf('%d, ', factors);
str(end) = [];
str(end) = [];

% if has a non-trivial aPoly, colors the graph
if(aPoly ~= sym(0) && ~isempty(factors))
    GraphColored(labeledIm, arcArr);
    % displays the colorability numbers
    disp("Valid colorability numbers: " + str);
else
    disp("Not Colorable.");
end

% outputs the Alexander polynomial
disp("Alexander Polynomial: ");
disp(aPoly);