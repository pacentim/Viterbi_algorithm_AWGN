function out = viterbi(Trellis,input,time,latency)

num_states = size(Trellis,1);

persistent path_memory;
persistent path_metric;

if time==0
    path_metric = zeros(num_states,1);
    path_memory = cell(num_states,1);
    for u = 2 : num_states
        path_metric(u) = inf;
    end
    out = NaN;
else

    new_paths = cell(num_states,1);
    new_accumulated = zeros(num_states,1);

    for k = 1 : num_states
        state = Trellis{k};
        accumulated = zeros(size(state,1),1);
        for n = 1 : length(accumulated)
            branch_metric = 0;
            prev_state = state(n,3)+1;
            branch_metric = (input-state(n,2))^2;
            accumulated(n) = branch_metric + path_metric(prev_state);
        end
        if accumulated(1) ~= accumulated(2)
            ind = find([accumulated==min(accumulated)]);
            survivor_input = state(ind,1);
            new_path_metric = accumulated(ind); 
        else
            ind = randi(2,1);
            survivor_input = state(ind,1);
            new_path_metric = accumulated(ind);
        end
            new_paths{k} = [survivor_input path_memory{state(ind,3)+1}];
            new_accumulated(k) = new_path_metric; 

    end

    path_memory = new_paths;
    path_metric = new_accumulated;

    if time < latency
        out = NaN;
    else
        out = path_memory{1}(end);
        for p = 1 : num_states
            path_memory{p}(end) = [];
        end
    end
end
end