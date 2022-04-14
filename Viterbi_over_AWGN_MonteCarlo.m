function [snr,Pe] = Viterbi_over_AWGN_MonteCarlo(Trellis,snr,num_sim,max_err,zero_err_max)

%initialization

latency = 10;
i=1;

zero_err_counter = 0;
Pe = zeros(1,length(snr));

for SNR = snr

% for SNR = -10
time=0;
viterbi(Trellis,1,time,10);
time=1;
symbol_vec = zeros(1,num_sim+latency);
num_errs=0;
Error_monitor = 0;

while time<num_sim+latency

    symbol = 2*randi(2,1)-3;
    symbol_vec(time) = symbol;
    X = finite_state_machine(symbol,time);
    
    
    
    Y = AWGN(X,SNR);

    Xest = viterbi(Trellis,Y,time,latency);


    if time>=latency
        %%%Error monitor
        Error_monitor = (symbol_vec(time-latency+1)-Xest)~=0;
        num_errs = num_errs+Error_monitor;

        if num_errs>max_err
            break;
        end
    end
     time=time+1;


end

if num_errs == 0
    zero_err_counter = zero_err_counter+1;
end
if zero_err_counter == zero_err_max
    break;
end 
Pe(i) = num_errs/time;
i=i+1;

end

snr = snr(1:i-zero_err_max);
Pe = Pe(1:i-zero_err_max);
thePe = qfunc(sqrt(10.^(snr/10)));

semilogy(snr,thePe);
grid on
hold on
semilogy(snr,Pe,'--','LineWidth',2);
legend('Theoretical','Simulated');
xlabel('SNR [dB]');
ylabel('Probability of error');

end
