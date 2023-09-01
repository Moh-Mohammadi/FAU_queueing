clc; clear
% Erlang-b 
% s
server_num = 10;
% a
offered_load =  9.6;
%tau
avg_service_time = 2.4;

% B(s, a)
% we know : B(0, a) = 1
b = 1;
for i = 1:server_num
    b = (offered_load * b)/(i + offered_load * b);
end

disp(b)

% Erlang-c 
% given a < s :
c = (server_num * b)/(server_num - offered_load *(1 - b));

if offered_load >= server_num
    c = 1;
end

disp(c)

% Expected waiting time per average service time 
utilization = offered_load / server_num;
e_w = c / ((1 - utilization)*server_num);

disp(e_w)

% Prob. of waiting time being more than t

for t = 0:8
    waiting_prob = c * exp(-(1 - utilization) *   server_num * t);
    disp(waiting_prob)
end

