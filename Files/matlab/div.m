function [out] = div(arg1,arg2)
x = fi(zeros(1 , 25) , 1 , 32 , 16, 'RoundingMethod', 'Floor');
y = fi(zeros(1 , 25) , 1 , 32 , 16, 'RoundingMethod', 'Floor');
z = fi(zeros(1 , 25) , 1 , 32 , 16, 'RoundingMethod', 'Floor');

x(1)= fi(arg1 , 1 , 32 , 16, 'RoundingMethod', 'Floor');
y(1) = fi(arg2 , 1 , 32 , 16, 'RoundingMethod', 'Floor');
z(1) = fi(0 , 1 , 32 , 16, 'RoundingMethod', 'Floor');
for i=2:25
    if (y(i-1)<0)
        x(i) = fi((x(i-1)), 1 ,32 , 16, 'RoundingMethod', 'Floor');
        y(i) = fi((y(i-1) + fi(x(i-1)*fi((2^-(i-2)) , 1 , 32 , 16 ,'RoundingMethod', 'Floor') , 1 , 32 , 16, 'RoundingMethod', 'Floor')) , 1 , 32 , 16, 'RoundingMethod', 'Floor');
        z(i) = fi((z(i-1) - fi((2^-(i-2)) , 1 , 32 , 16, 'RoundingMethod', 'Floor')) , 1 , 32 ,16, 'RoundingMethod', 'Floor');
    else
       x(i) = fi((x(i-1)) , 1 ,32 , 16, 'RoundingMethod', 'Floor');
        y(i) = fi((y(i-1) - fi(x(i-1)*fi((2^-(i-2)) , 1 , 32 , 16 ,'RoundingMethod', 'Floor') , 1 , 32 , 16)) , 1 , 32 , 16, 'RoundingMethod', 'Floor');
        z(i) = fi((z(i-1) + fi((2^-(i-2)) , 1 , 32 , 16, 'RoundingMethod', 'Floor')) , 1 , 32 ,16, 'RoundingMethod', 'Floor');
    end   
end

out= fi(z(25) , 1 , 32 , 16 , 'RoundingMethod', 'Floor');
end

