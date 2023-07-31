clc; clear
server_num = 10;
customer_num = 1000000;
arrival = 0;
blocked_customers = 0;
completion = zeros(server_num);
allbusy = 0;
for i = 1:customer_num
    interarrival = 0.25;
    arrival = arrival + interarrival;
    j = 1;
    block = false;
    while arrival < completion(j)
        j = j + 1;
        if j == server_num + 1
            blocked_customers = blocked_customers + 1;
            block = true;
            break;
        end
    end
    if block
         continue; 
    end
    service = - 2.4 * log(unifrnd(0, 1));
    completion(j) = arrival + service;
    min_time = completion(1);
    for x = 2:server_num
        if completion(x) < min_time
            min_time = completion(x);
        end
    end
    if min_time > arrival
        allbusy = allbusy + min_time - arrival;
    end
end

disp(blocked_customers/customer_num)
disp(allbusy/arrival)



