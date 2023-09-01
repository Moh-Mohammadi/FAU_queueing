clc; clear;
% parameters
customer_num = 1000000;
a = 1.2;
avg_service_time = 2.4;
lambda = a / avg_service_time;
n = 3200;

% variables
service_sum = 0;
waiting_sum = 0;
service_completion = 0;
blocked_customers = 0;
arrival = 0;
waiting_list = zeros(n); % This list holds the completion times of the waiting customers
for i = 1:customer_num
    % Generate interarrival time
    interarrival = - 1/lambda * log(unifrnd(0, 1));
    arrival = arrival + interarrival;
    % Generate service time
    service_time = - avg_service_time * log(unifrnd(0, 1));
    
    % Handle the case when customer gets service immediately
    if service_completion < arrival
        service_completion = arrival + service_time;
        service_sum = service_sum + service_time;
    else
    % Handle the case when customer waits
    % Find an empty waiting position
        empty = false;
        counter = 0;
        for j = 1:n
            if waiting_list(j)  < arrival && ~empty % Check if a waiting position is empty
                empty = true;
                waiting_sum = waiting_sum + service_completion - arrival;
                service_sum = service_sum + service_time;
                waiting_list(j) = service_completion;
                service_completion = service_completion + service_time;
            end
        end
    
        
        % Handle the case when there is no empty position
        if ~empty
            blocked_customers = blocked_customers + 1;
        end
    end

end


% utilization
disp(service_sum/service_completion)

% Prob. of being in state n + 1 from POV of new arrival
disp(blocked_customers/ customer_num)

% average waiting time
waiting_sum = waiting_sum / avg_service_time;
disp(waiting_sum/(customer_num - blocked_customers)) 




