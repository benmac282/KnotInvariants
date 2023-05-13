% Ben McMahan and Lincoln Potts
%This function swaps two rows in an array.

function array=swapRow(array, r1, r2)
    temp1 = array(r1).start;
    temp2 = array(r1).end;

    array(r1).start = array(r2).start;
    array(r1).end = array(r2).end;

    array(r2).start = temp1;
    array(r2).end = temp2;
end