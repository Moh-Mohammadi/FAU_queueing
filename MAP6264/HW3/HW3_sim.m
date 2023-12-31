clc; clear
server_num = 10;
customer_num = 10000000;
arrival = 0;
lambda = 4.2;
service_time_avg = 2.4;
max_waiting_threshold = 8;
service_sum = 0;
waiting_sum = 0;
waiting_num = zeros(max_waiting_threshold+1);
completion = zeros(server_num);
for i = 1:customer_num
    % determine X/X/s 
    % M :  - (1/lambda) * log(unifrnd(0, 1))
    % D :  1/lambda
    interarrival =   1/lambda;
    % M : - service_time_avg * log(unifrnd(0, 1))
    % D : service_time_avg
    service =   service_time_avg;
    service_sum = service_sum + service;
    arrival = arrival + interarrival;
    idle_server = false;
    % find an idle server
    for j = 1:server_num
        % condition of idle server
        if completion(j) < arrival && ~idle_server
           completion(j) = arrival + service;
           idle_server = true;
        end
    end
    
    % handle the case of overflow packet
    if ~idle_server
        % find the server with the least remaining service time
            min_time = completion(1);
            min_time_idx = 1;
            for x = 2:server_num
                if completion(x) < min_time
                    min_time = completion(x);
                    min_time_idx = x;
                end
            end
            % add the service time of the overflow packet to the min time
            % server
            completion(min_time_idx) = completion(min_time_idx) + service;
            waiting_time = (min_time - arrival)/service_time_avg;
            waiting_sum = waiting_sum + waiting_time;
            for t = 0:max_waiting_threshold
                if waiting_time > t
                    waiting_num(t+1) = waiting_num(t+1) + 1;
                end
            end

    end
end

completion_sum = 0;
for i = 1:server_num
     completion_sum = completion_sum + completion(i); 
end

% utilization
disp(service_sum/completion_sum)

% mean waiting time
disp(waiting_sum / customer_num)

% waiting time probabilities
for y = 0:max_waiting_threshold
    disp(waiting_num(y + 1) / customer_num)
end



