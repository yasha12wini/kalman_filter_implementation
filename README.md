This project implements a Kalman Filter for estimating the State of Charge (SOC) of a battery using a simplified Equivalent Circuit Model (ECM). The model assumes a linear Open Circuit Voltage (OCV)-SOC relationship and includes a series resistance to simulate the battery behavior under constant current discharge.
The goal is to estimate the battery's SOC in real-time using voltage measurements corrupted by noise. This is a key function in Battery Management Systems (BMS) in electric vehicles and energy storage systems.

Model Specifications:
Battery capacity: 3600 Coulombs
Sampling interval: 1 second
Simulation time: 300 seconds
Load current: Constant at 2A

Results
The script plots:
The true SOC vs. estimated SOC using Kalman Filter.
The noisy terminal voltage is not explicitly plotted here but used in the estimation.
This basic example demonstrates how Kalman Filtering can significantly improve SOC estimation under uncertainty in measurements.
