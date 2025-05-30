clc;
clear all;

%capacity of battery
Q_battery = 3600; 
dt=1;
N = 300;

%ECM parameters
R0=0.01;
OCV_slope = 0.01;
OCV_intercept = 0.3;

true_SOC= zeros(1,N);
true_SOC(1)=1;

%simulating the battery
I = 2 * ones(1, N); 
V = zeros(1,N);

for i=2:N
    true_SOC(i)= true_SOC(i-1)-I(i-1)*dt/Q_battery;
    V(i)=OCV_slope*true_SOC(i)+OCV_intercept-I(i)*R0;
end

V_meas = V+ 0.01*randn(1,N);

%initialisation for kalman filter
x_hat = zeros(1,N);
x_hat(1)= 0.9;

%initial estimate of covariance
p_confidence= 0.01;
%process noise covraince
q_cov=1e-5;
%measurement noise covraince
r_cov=1e-4;

for i=2:N
    x_pred=x_hat(i-1) -(I(i-1)*dt)/Q_battery;
    P_pred=p_confidence+q_cov;
    H= OCV_slope;
    Kalman_gain = H*P_pred/(H^2*P_pred+r_cov);
    V_pred = OCV_slope * x_pred + OCV_intercept - R0 * I(i);
    x_hat(i)=x_pred+Kalman_gain*(V_meas(i)-V_pred);
    p_confidence = (1 - Kalman_gain * H) * P_pred;

end

figure;
plot(1:N, true_SOC, 'g', 'LineWidth', 2); hold on;
plot(1:N, x_hat, 'b--', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('SOC');
legend('True SOC', 'Estimated SOC');
title('Kalman Filter SOC Estimation');
grid on;














