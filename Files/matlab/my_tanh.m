clearvars
z = fi(-5:0.2:5 , 1 , 32 , 16);
plot(z,tanh(z));
hold
y = fi(zeros(1 , 51) , 1 , 32 , 16);
x = fi(zeros(1 , 51) , 1 , 32 , 16);
my_tanhx = fi(zeros(1 , 51) , 1 , 32 , 16);
j = 1;
f = fopen('matlab_data.hex' , 'w+');
for i=-5:0.2:5
    [y(j),x(j)] = my_hyper(i);
    t2 = x(j);
    t3 = z(j);
    my_tanhx(j) = div(x(j) , y(j));
    t1 = my_tanhx(j);
    fprintf(f ,'%s \t %s \n', t1.hex , t3.hex);
    j = j+1;
end
plot(z,my_tanhx);

fclose(f);
