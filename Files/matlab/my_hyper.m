function [my_sinh,my_cosh] = my_hyper(inputArg1)
arctanhx_neg = [fi(atanh(1 - 1/32),1,32,16 , 'RoundingMethod', 'Floor') , fi(atanh(1 - 1/16),1,32,16 , 'RoundingMethod', 'Floor') , fi(atanh(1 - 1/8),1,32,16 , 'RoundingMethod', 'Floor') , fi(atanh(1 - 1/4),1,32,16 , 'RoundingMethod', 'Floor')];
arctanhx = [fi(atanh(1/2),1,32,16 , 'RoundingMethod', 'Floor'), fi(atanh(1/4),1,32,16 , 'RoundingMethod', 'Floor') , fi(atanh(1/8),1,32,16 , 'RoundingMethod', 'Floor') , fi(atanh(1/16),1,32,16 , 'RoundingMethod', 'Floor') , fi(atanh(1/32),1,32,16 , 'RoundingMethod', 'Floor') , fi(atanh(1/64),1,32,16 , 'RoundingMethod', 'Floor') , fi(atanh(1/128),1,32 , 16 , 'RoundingMethod', 'Floor') , fi(atanh(1/256),1,32,16 , 'RoundingMethod', 'Floor') , fi(atanh(1/512),1,32,16 , 'RoundingMethod', 'Floor') , fi(atanh(1/1024),1,32,16 , 'RoundingMethod', 'Floor') , fi(atanh(1/2048),1,32,16 , 'RoundingMethod', 'Floor'), fi(atanh(1/4096),1,32,16 , 'RoundingMethod', 'Floor') ,  fi(atanh(1/8192),1,32,16 , 'RoundingMethod', 'Floor') ,  fi(atanh(1/16384),1,32,16 , 'RoundingMethod', 'Floor'), fi(atanh(1/32768),1,32,16 , 'RoundingMethod', 'Floor') , fi(atanh(1/65536),1,32,16 , 'RoundingMethod', 'Floor')];
x = fi(zeros(1 , 21) , 1 , 32 , 16 , 'RoundingMethod', 'Floor');
y = fi(zeros(1 , 21) , 1 , 32 , 16, 'RoundingMethod', 'Floor');
z = fi(zeros(1 , 21) , 1 , 32 , 16 , 'RoundingMethod', 'Floor');
x(1)= fi(43.602396236567309 , 1 , 32 , 16 , 'RoundingMethod', 'Floor');
y(1) = fi(0 , 1 , 32 , 16 , 'RoundingMethod', 'Floor');
z(1) = fi(inputArg1 , 1 , 32 , 16 , 'RoundingMethod', 'Floor');
for i=2:5
    if (z(i-1)<0)
        x(i) = fi((x(i-1) - fi(y(i-1)-fi(y(i-1) * fi(2^(i-7) , 1 , 32 , 16 , 'RoundingMethod', 'Floor') , 1 , 32 , 16, 'RoundingMethod', 'Floor') , 1 , 32 , 16,'RoundingMethod', 'Floor')) , 1 ,32 , 16, 'RoundingMethod', 'Floor');
        y(i) = fi((y(i-1) - fi(x(i-1)-fi(x(i-1) * fi(2^(i-7) , 1 , 32 , 16,  'RoundingMethod', 'Floor') , 1 , 32 , 16 , 'RoundingMethod', 'Floor') , 1 , 32 , 16 , 'RoundingMethod', 'Floor')) , 1 ,32 , 16 , 'RoundingMethod', 'Floor');
        z(i) = fi((z(i-1) + fi(arctanhx_neg(i-1) , 1 , 32 , 16 ,'RoundingMethod', 'Floor')) , 1 , 32 ,16 , 'RoundingMethod', 'Floor');
    else
        x(i) = fi((x(i-1) + fi(y(i-1)-fi(y(i-1) * fi(2^(i-7) , 1 , 32 , 16 , 'RoundingMethod', 'Floor') , 1 , 32 , 16 , 'RoundingMethod', 'Floor') , 1 , 32 , 16 , 'RoundingMethod', 'Floor')) , 1 ,32 , 16 , 'RoundingMethod', 'Floor');
        y(i) = fi((y(i-1) + fi(x(i-1)-fi(x(i-1) * fi(2^(i-7) , 1 , 32 , 16 , 'RoundingMethod', 'Floor') , 1 , 32 , 16 , 'RoundingMethod', 'Floor') , 1 , 32 , 16 , 'RoundingMethod', 'Floor')) , 1 ,32 , 16 , 'RoundingMethod', 'Floor');
        z(i) = fi((z(i-1) - fi(arctanhx_neg(i-1) , 1 , 32 , 16 ,'RoundingMethod', 'Floor')) , 1 ,32 , 16 , 'RoundingMethod', 'Floor');
    end   
end
for i=2:17
    if (z(i+4-1)<0)
        x(i+4) = fi((x(i+4-1) - fi(y(i+4-1)*fi((2^-(i-1)) , 1 , 32 , 16 ,'RoundingMethod', 'Floor') , 1 , 32 , 16 , 'RoundingMethod', 'Floor')) , 1 ,32 , 16 , 'RoundingMethod', 'Floor');
        y(i+4) = fi((y(i+4-1) - fi(x(i+4-1)*fi((2^-(i-1)) , 1 , 32 , 16 ,'RoundingMethod', 'Floor') , 1 , 32 , 16 , 'RoundingMethod', 'Floor')) , 1 ,32 , 16 , 'RoundingMethod', 'Floor');
        z(i+4) = fi((z(i+4-1) + fi(arctanhx(i-1) , 1 , 32 , 16 ,'RoundingMethod', 'Floor')) , 1 , 32 ,16 , 'RoundingMethod', 'Floor');
    else
       x(i+4) = fi((x(i+4-1) + fi(y(i+4-1)*fi((2^-(i-1)) , 1 , 32 , 16 ,'RoundingMethod', 'Floor') , 1 , 32 , 16 , 'RoundingMethod', 'Floor')) , 1 ,32 , 16 , 'RoundingMethod', 'Floor');
        y(i+4) = fi((y(i+4-1) + fi(x(i+4-1)*fi((2^-(i-1)) , 1 , 32 , 16 ,'RoundingMethod', 'Floor') , 1 , 32 , 16 , 'RoundingMethod', 'Floor')) , 1 ,32 , 16 , 'RoundingMethod', 'Floor');
        z(i+4) = fi((z(i+4-1) - fi(arctanhx(i-1) , 1 , 32 , 16 ,'RoundingMethod', 'Floor')) , 1 ,32 , 16 , 'RoundingMethod', 'Floor');
    end   
end

my_sinh = fi(y(21) , 1 , 32 , 16 , 'RoundingMethod', 'Floor') ;
my_cosh = fi(x(21) , 1 , 32 , 16 , 'RoundingMethod', 'Floor');
end

