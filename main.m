dbstop if error

clear all
num_states = 4;
%construct the trellis
%each cell corresponds to a state
%in each cell there are 2 rows that correspond to the 2 inputs
%each column contains: INPUT | OUTPUT | PREV STATE

Trellis = cell(num_states,1);

Trellis{1} = zeros(2,3);
Trellis{1} = [-1 -3 0; -1 -3 2];

Trellis{2} = zeros(2,3);
Trellis{2} = [1 1 0; 1 1 2];

Trellis{3} = zeros(2,3);
Trellis{3} = [-1 -1 1; -1 -1 3];

Trellis{4} = zeros(2,3);
Trellis{4} = [1 3 1; 1 3 3];


%maximum error parameter : if the simulation reaches this number of error
%the code breaks
max_err = 1000;
%maximum zero-error parameter: if you got 'zero_err_max' simulations with
%no errors, the code breaks;
zero_err_max = 1;
snr = [-16 : 2 : 30];
num_sim = 4e7;

[snr,Pe ] = Viterbi_over_AWGN_MonteCarlo(Trellis,snr,num_sim,max_err,zero_err_max);



