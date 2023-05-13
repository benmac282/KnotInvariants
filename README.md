# KnotInvariants
This MATLAB program inputs an image of a mathematical knot projection
and calculates the Alexander Polynomial, colorability numbers,
and displays colorability.

Ben McMahan and Lincoln Potts
Matlab Project

___Required Toolboxes___
- Symbolic Toolbox
- Image Processing Toolbox

___How To Run___
1. Open the "...\Project" directory
2. Type "KnotDriver" in the command line and run
3. Enter the name of a .png or .jpg image
   file contained within the "...\Project\TestImages"
   directory.
4. This image must be drawn in MS Paint with the size 819 x 460
   and conform to proper knot projection convetions (as listed
   under Knot Drawing Conventions).

___Output Information___
The program should display:
1. A figure of the knot with endpoints of each arc labeled.
2. If there there was a twist, a figure showing where the twist
   was resolved with a blue line.
3. If the knot is colorable, a figure showing the knot colored.

___Knot Drawing Conventions___
1. No two separate arcs can touch.
2. The knot must be a single link.
3. No two crossings can be on top of one another or overlap.
4. The under-arc of a given crossing is drawn with gaps slightly
   before there would have been an intersection.
5. Specifically, if two endpoints are closest to each other
   they must be part of the same under-arc.

___TODO___
1. Add a GUI for ease of use.
2. Add ability to calculate more invariants.
