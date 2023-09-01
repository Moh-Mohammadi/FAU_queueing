clc; clear
server_num = 10;
source_num = 100;
customer_num = 600000;

% a*
intended_load = 9.6;
avg_service_time = 2.4;
a_hat = intended_load / (source_num - intended_load);
gamma = a_hat / avg_service_time;

blocked_customers = 0;
completion = zeros(server_num);
source = zeros(source_num); 
service_sum = 0;
time_sum = 0;
allbusy = 0;

% initialize think times 
for i = 1:source_num
    % D : 1/gamma
    % M : - 1/gamma * log(unifrnd(0, 1))
    source(i) = - 1/gamma * log(unifrnd(0, 1));
end

for i = 1:customer_num

    % find the source with min think time
    min_think_time = source(1);
    min_think_index = 1;
    for j = 2:source_num
        if source(j) < min_think_time
            min_think_time = source(j);
            min_think_index = j;
        end
    end

    % find an idle server
    idle = false;
    busy_server_count = 0;
    for j = 1:server_num
        if completion(j) < min_think_time && ~idle% this means it is idle and that another hasn't been found 
                % generate service time
                % D : avg_service_time
                % M : - avg_service_time * log(unifrnd(0, 1))
                service_time = avg_service_time;
                service_sum = service_sum + service_time;
                idle = true;
                completion(j) = min_think_time + service_time;
                source(min_think_index) = source(min_think_index) + service_time;
        end
        if completion(j) >= min_think_time % this means the server is busy
            busy_server_count = busy_server_count + 1;
        end
    end
    
    if busy_server_count == server_num && idle % this shows that all servers got busy by the last arrival
        min_service_time = completion(1);
        for j = 2:server_num
            if min_service_time > completion(j)
                min_service_time = completion(j);
            end
        end
        allbusy = allbusy + min_service_time - min_think_time;
    end
    % if the request is blocked the source returns to think state
    if ~idle
        blocked_customers = blocked_customers + 1;
    end

    % generate think time
    % D : 1 / gamma
    % M : - 1/ gamma * log(unifrnd(0, 1))
    think_time = - 1/ gamma * log(unifrnd(0, 1));
    source(min_think_index) = source(min_think_index) + think_time;
end

for i = 1:server_num
    time_sum = time_sum + completion(i);
end

% probability of being in state s given n source from the POV of outside
% observer
disp((allbusy * server_num)/time_sum)
% probability of being in state s given n source from the POV of new 
% arrival
disp(blocked_customers/customer_num)
% utilization
disp(service_sum/time_sum)


