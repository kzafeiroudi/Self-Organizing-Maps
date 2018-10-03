clear all
close all

load('2C_classification.mat');

k = zeros(8, 1);

for i=1:1:400
    k(ClassPatterns(8,i) + 1) = k(ClassPatterns(8,i) + 1) + 1;
end

for i=0:1:7
    fprintf('Στην ομάδα %d βρίσκονται: %d πρότυπα ', i, k(i+1));
    fprintf('\n');
end
fprintf('\n');


s = zeros(8, 1);
l = zeros(7, 1);

for i=1:1:225
    if (IW(i,8) >= 0 && IW(i,8) <= 0.05)
        s(1) = s(1) + 1;
    elseif (IW(i,8) >= 0.95 && IW(i,8) <= 1.05)
        s(2) = s(2) + 1;
    elseif (IW(i,8) >= 1.95 && IW(i,8) <= 2.05)
        s(3) = s(3) + 1;
    elseif (IW(i,8) >= 2.95 && IW(i,8) <= 3.05)
        s(4) = s(4) + 1;
    elseif (IW(i,8) >= 3.95 && IW(i,8) <= 4.05)
        s(5) = s(5) + 1;
    elseif (IW(i,8) >= 4.95 && IW(i,8) <= 5.05)
        s(6) = s(6) + 1;
    elseif (IW(i,8) >= 5.95 && IW(i,8) <= 6.05)
        s(7) = s(7) + 1;
    elseif (IW(i,8) >= 6.95 && IW(i,8) <= 7)
        s(8) = s(8) + 1;
    elseif (IW(i,8) > 0.05 && IW(i,8) < 0.95)
        l(1) = l(1) + 1;
    elseif (IW(i,8) > 1.05 && IW(i,8) < 2.95)
        l(2) = l(2) + 1;
    elseif (IW(i,8) > 2.05 && IW(i,8) < 3.95)
        l(3) = l(3) + 1;
    elseif (IW(i,8) > 3.05 && IW(i,8) < 4.95)
        l(4) = l(4) + 1;
    elseif (IW(i,8) > 4.05 && IW(i,8) < 5.95)
        l(5) = l(5) + 1;
    elseif (IW(i,8) > 5.05 && IW(i,8) < 6.95)
        l(6) = l(6) + 1;
    elseif (IW(i,8) > 6.05 && IW(i,8) < 7)
        l(7) = l(7) + 1;
    end
end

for i=0:1:7
    fprintf('Στην ομάδα %d βρίσκονται: %d νευρώνες ', i, s(i+1));
    if (i < 7)
        fprintf('και στο όριο βρίσκονται: %d νευρώνες\n', l(i+1))
    fprintf('\n');
    end
end
fprintf('\n');
