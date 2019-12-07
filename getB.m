function [B] = getB(gradN)
    B = zeros(3,8);
    for i = 1:8
       if (mod(i,2) == 1)
           B(1,i) = gradN(1,(i+1)/2);
           B(3,i) = gradN(2,(i+1)/2);
       else
           B(2,i) = gradN(2,i/2);
           B(3,i) = gradN(1,i/2);
       end
    end
end