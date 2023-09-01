clc; clear;

a = 1.2; 
avg_service_time = 2.4;
lambda = a/avg_service_time;
n = 16;

P_0 = 1;
P_{n+1} = 1; 
queue_length = 0;
length = 0;

for i = 1:n+1
   P_{n+1} = a * P_{n+1};
   queue_length = queue_length + (i - 1) * P_{n+1};
   length = length + i * P_{n+1};
   P_0 = P_0 + P_{n+1};
end

P_0 = 1/P_0;
P_{n+1} = P_{n+1} * P_0;
queue_length = queue_length * P_0;
length = length * P_0;

% Utilization
disp(length - queue_length)

% Prob. of being at state n + 1 from the POV of new arrival
disp(P_{n+1})

% Average waiting time 
disp(queue_length/((1 - P_{n+1}) * lambda * avg_service_time));