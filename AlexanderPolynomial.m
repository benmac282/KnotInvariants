%Ben McMahan and Lincoln Potts
% This is the function that controls the constuction of the matrix for
% calculating the alexander polynomial and then calculates and returns it.
% This function also calls the function that fixes twists. It does this by
% identifying the twist, resolving it, and then calling itself recursively
% to continue the process.

function [aPoly, arcArr, labeledIm]=AlexanderPolynomial(arcArr, labeledIm, twistCnt)
    arcNum = length(arcArr);

    syms t;
    mat = zeros(arcNum);
    mat = sym(mat);
    
    for i = 1:arcNum
        if mod(i + 1, arcNum) == 0
            lead = arcNum;
        else
            lead = mod(i + 1, arcNum);
        end

        p1 = fliplr(arcArr(i).end);
        p2 = fliplr(arcArr(lead).start);
                
        %checks for twist
        overVec = overVector(p1, p2, labeledIm);
        if overVec.start(1) == -1 && overVec.start(2) == -1
            %resolves twist
            twistCnt = twistCnt + 1;
            if twistCnt == 1
                figure;
                title("Twist Fixes");
                imshow(labeledIm);
            end
            [arcArr, labeledIm] = twistFix(i, mod(i + 1, arcNum), arcArr, labeledIm);
            %handles non-obvious unknots
            if(arcArr(1).start == -1)
                aPoly = sym(0);
                return;
            end
            [aPoly, arcArr, labeledIm]=AlexanderPolynomial(arcArr, labeledIm, twistCnt);
            return;
        else
            handOver = handedness(p1, p2, labeledIm, arcArr, overVec);
            hand = handOver(1);
            over = handOver(2);
        end


        % if branch that handles update to the matrix
        
        if hand
            %mat(cross, arc)
            mat(i, i) = -1;
            mat(i, lead) = t;
        else
            mat(i, i) = t;
            mat(i, lead) = -1;
        end
        mat(i, over) = 1 - t;

    end
    
    mat(arcNum, :) = [];
    mat(:, arcNum) = [];

    aPoly = det(mat);
end