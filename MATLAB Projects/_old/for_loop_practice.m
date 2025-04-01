%i = 0;
%for i < 10
    %for loops in MATLABS does NOT accept logical arguement/conditions
       %must specify specific interval ala [1:10] for 1 to 10
       %or some specific list of values
for i = 1:10
    disp(i)
    %i = i + 1;
end

for p = [1 28 "ted" "john" '8' 8]
    disp(p)
end

johnnybravotime = 5^600;
for increment = 1:johnnybravotime
    if increment % 2 == 1;
        disp("HAHA IT'S EVEN")
    else disp(increment)
    end
end