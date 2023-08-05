clc; clear
interrenewal_sum = 0;
remainder_sum = 0;
length_sum = 0;
c = 0;
num = 100000;
for j = 1:num
    s = 0;
    interruption_point = -1000 * log(unifrnd(0,1));
    while s < interruption_point
        interrenewal_time =  -1*log(unifrnd(0,1));
        c = c + 1;
        interrenewal_sum = interrenewal_sum + interrenewal_time;
        s = s + interrenewal_time;
    end
    remainder = s - interruption_point;
    interrupted_interval_length = interrenewal_time;
    remainder_sum = remainder_sum + remainder;
    length_sum = length_sum + interrupted_interval_length;
end
% sample mean of interrenewal times
disp(interrenewal_sum/c)
% sample mean of interrupted arrival length
disp(length_sum/num)
% sample mean of remainder of interrupted arrival
disp(remainder_sum/num)