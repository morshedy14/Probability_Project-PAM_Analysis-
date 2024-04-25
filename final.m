%% Array of different M values to be drawn for comparison
M_ALL = [2 4 8 16 32 64];
SNR_range = 1:0.25:20;

% Initialize BER matrix
BER = zeros(length(SNR_range), length(M_ALL));

%% Loop over each M value
for m = 1:length(M_ALL)
    M = M_ALL(m);             % Set the value for M with each iteration
    L = 4;                    % Number of bits in a pulse (length of pulse)
    pulsesCount = 100000;     % Total number of pulses in the input signal

    % Generate pulse and its reversed version for matched filtering
    pulse = ones(1, L) ./ sqrt(L);     
    reversedPulse = fliplr(pulse);     
    
    % Generate random signal to be modulated
    Signal = randi([0, M - 1], 1, pulsesCount) .* 2 - 1;
    
    % Prepare the modulated signal for matched filtering
    modulated_signal = repelem(Signal, L) ./ sqrt(L);

    % Simulate matched filtering for different SNR values
    for snr_idx = 1:length(SNR_range)
    SNR = SNR_range(snr_idx);  % Set SNR value with each iteration
    
    % Introduce AWGN (Additive White Gaussian Noise) to the modulated signal
    noisySignal = awgn(modulated_signal, SNR, 'measured');
    % The 'measured' option adjusts noise power based on the desired SNR.
    % This adds simulated noise to the modulated signal to simulate real-world transmission.

    % Perform convolution for matched filtering
    Result = conv(noisySignal, reversedPulse);
    % Convolve the noisy signal with the reversed pulse using linear convolution.
    % This is the process of matched filtering, where we try to match the pulse shape to recover the transmitted symbols.
    
    Output = Result(L:L:end);
    % Extract symbols after matched filtering.
    % We take every Lth sample of the Result array starting from index L.
    % This step removes the redundant convolved samples that are not aligned with the original signal.

    % Calculate the number of symbol errors (BPSK: +1 for errors)
    errorsNum = sum(abs(round(Output) - Signal) > 1);
    % Round the matched filter output to obtain detected symbols.
    % Calculate the absolute difference between detected symbols and transmitted symbols.
    % If the absolute difference is greater than 1, it indicates an error in detection.
    % Summing up these errors gives the total number of symbol errors.

        % Calculate Symbol Error Rate (SER)
        BER(snr_idx, m) = errorsNum / pulsesCount;
    end
end

%% Plotting the relation between SNR and SER for different M values
figure;
% semilogy plots data on a logarithmic scale for the y-axis.
% This is particularly useful when dealing with quantities that span a wide range.
semilogy(SNR_range, BER);
legend('2PAM', '4PAM', '8PAM', '16PAM', '32PAM', '64PAM');
xlabel('SNR (dB)');
ylabel('SER');
title('Symbol Error Rate (SER) vs SNR for Different PAM Levels');
grid on;