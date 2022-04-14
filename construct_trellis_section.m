function Trellis = construct_trellis_section(FSM)
num_states = size(FSM,1);
num_input = 2;



Trellis = zeros(num_states,num_input);

for k = 1 : num_states
    state = FSM{k};
    for n = 1 : size(state,1)
        next = state(n,3)+1;
        %k = current state
        Trellis()
    end


end

end