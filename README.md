# Symbol Error Rate Analysis of Pulse Amplitude Modulation (PAM) Levels

## Overview
This project simulates the performance of different Pulse Amplitude Modulation (PAM) schemes by analyzing the Symbol Error Rate (SER) against varying Signal-to-Noise Ratios (SNR). The code performs a matched filtering simulation with Additive White Gaussian Noise (AWGN) introduced into the signal, allowing us to measure the robustness of each PAM level in noisy environments.

## Features
- **PAM Levels:** The script supports 2PAM, 4PAM, 8PAM, 16PAM, 32PAM, and 64PAM modulation levels.
- **Matched Filtering:** Convolution-based filtering is applied to recover transmitted symbols from the noisy signal.
- **Symbol Error Rate (SER):** The script calculates the error rate based on the difference between transmitted and detected symbols.
- **Visualization:** A semilog plot is generated to visualize the SER vs. SNR relationship for different PAM levels.

## Script Description
The script performs the following tasks:

1. **Initialization:**
   - Defines an array of different PAM levels to be tested (`M_ALL = [2, 4, 8, 16, 32, 64]`).
   - Sets a range of SNR values for analysis (`SNR_range = 1:0.25:20`).
   - Initializes a matrix to store the SER for each SNR value and PAM level.

2. **Main Loop:**
   - Loops over each PAM level and calculates SER for each SNR value.
   - Generates a pulse and its reversed version for matched filtering.
   - Creates a modulated signal by repeating a random signal and dividing by the square root of the pulse length.
   - Adds AWGN to the modulated signal to simulate real-world conditions.
   - Performs convolution to simulate matched filtering.
   - Calculates the number of errors and the SER for each SNR value and PAM level.

3. **Plotting the Results:**
   - Uses `semilogy` to plot SER against SNR for each PAM level.
   - Adds a legend, labels, and title for the plot.
   - Enables the grid for better visualization.

This project demonstrates the relationship between SNR and SER for various PAM levels. The results can help understand the performance of different modulation schemes under noisy conditions, providing valuable insights into communication systems design.

