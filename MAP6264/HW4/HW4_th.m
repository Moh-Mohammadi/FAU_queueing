clc; clear
server_num = 10;
source_num = 10000000000;
% a*
intended_load = 9.6;
a_hat = intended_load / (source_num - intended_load);

% calcualte from the POV of outside observer
P_s  =  helper(server_num, source_num, a_hat);

% calculate from the POV of arrivals 
Pi_s = helper(server_num, source_num - 1, a_hat);

% calculate carried load
carried_load = intended_load * (1 - (1 - (server_num/source_num)) * P_s);

% Probability from the POV of outside observer
disp(P_s)
% Probability from the POV of arrivals
disp(Pi_s)
% Utilization
disp(carried_load/server_num)


% function that generates the s state probability from the outside
% obeserver POV
function P_s = helper(s, n, a_hat)
    P_s = 1; 
    P_sum = 1; % normalization factor
    
    for j = 1:s
        P_s = ((n - j + 1) / j) * a_hat * P_s;
        P_sum = P_sum + P_s;
    end
    P_s = P_s/P_sum; % normalize the answer
end



