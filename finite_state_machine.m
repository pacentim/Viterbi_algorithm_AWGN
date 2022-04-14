function out = finite_state_machine(X,time)

persistent state;

if time==1
    state = 0;
end

switch state
    case 0
        if X==-1
            out = -3;
            state = 0;
        else
            out = 1;
            state = 1;
        end
    case 1
        if X==-1
            out = -1;
            state = 2;
        else
            out = 3;
            state = 3;
        end    
    case 2
        if X==-1
            out = -3;
            state = 0;
        else
            out = 1;
            state = 1;
        end
    case 3
        if X==-1
            out = -1;
            state = 2;
        else
            out = 3;
            state = 3;
        end
end