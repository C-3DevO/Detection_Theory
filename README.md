# Detection of Random Signals in Gaussian Noise

This project implements statistical signal detection techniques in MATLAB using the Neyman–Pearson framework.

Two detectors are studied:

- Energy Detector
- Estimator–Correlator Detector

The simulations evaluate the probability of detection under different signal-to-noise ratios (SNR), false alarm probabilities, and observation lengths.

---

# Overview

The objective is to determine whether a random signal is present in noisy observations.

The binary hypothesis testing problem is formulated as:

## Null Hypothesis

```math
H_0 : x[n] = w[n]
```

## Signal Present Hypothesis

```math
H_1 : x[n] = s[n] + w[n]
```

where:

- `s[n]` is the random signal
- `w[n]` is additive white Gaussian noise (AWGN)

---

# Energy Detector

The energy detector determines signal presence using the total received signal energy.

## Test Statistic

```math
T(x) = \sum_{n=0}^{N-1} x^2[n]
```

The detector decides:

```math
T(x)
\overset{H_1}{\underset{H_0}{\gtrless}}
\gamma
```

where:

- `γ` is the detection threshold

---

# Statistical Model

Under the two hypotheses:

## Under H₀

```math
x \sim \mathcal{N}(0,\sigma^2 I)
```

## Under H₁

```math
x \sim \mathcal{N}(0,(\sigma_s^2+\sigma^2)I)
```

The signal-to-noise ratio is defined as:

```math
SNR = \frac{\sigma_s^2}{\sigma^2}
```

---

# Detection Metrics

## Probability of False Alarm

```math
P_{FA} = P(T(x) > \gamma | H_0)
```

## Probability of Detection

```math
P_D = P(T(x) > \gamma | H_1)
```

---

# Energy Detector Simulations

The simulations evaluate detection performance for:

```matlab
P_FA = [10^{-1}, 10^{-2}, 10^{-3}, 10^{-4}, 10^{-5}]
```

and different observation lengths:

- `N = 25`
- `N = 50`

---

# Key Energy Detector Observations

## Effect of SNR

- Detection probability increases with SNR
- At low SNR, noise dominates the observations
- At high SNR, signal and noise distributions become more separable

## Effect of False Alarm Probability

- Larger `P_FA` produces lower thresholds
- Lower thresholds improve detection probability
- Smaller `P_FA` makes the detector more conservative

## Effect of Observation Length

Increasing the number of samples improves performance because:

- averaging reduces statistical variability
- hypothesis distributions separate more clearly
- detector reliability increases

---

# General Linear Model

The second part of the lab extends detection to correlated random signals generated through a linear model.

## Observation Model

```math
H_0 : x = w
```

```math
H_1 : x = Hd + w
```

where:

- `H` is a known system matrix
- `d` is a random signal vector
- `w` is AWGN

The signal covariance becomes:

```math
C_s = \sigma_s^2 HH^T
```

---

# Estimator–Correlator Detector

The Neyman–Pearson detector for the general linear model leads to the estimator–correlator statistic:

```math
T(x) =
x^T
C_s
(C_s + \sigma^2 I)^{-1}
x
```

This detector exploits signal structure through the covariance matrix instead of relying only on total signal energy.

---

# MATLAB Features

The implementation includes:

- Monte Carlo detection simulations
- Energy detector implementation
- Estimator–correlator detector
- Neyman–Pearson hypothesis testing
- Chi-square threshold computation
- Probability of detection estimation
- False alarm analysis
- SNR performance evaluation
- Correlated signal detection

---

# Simulation Parameters

## Energy Detector

```matlab
Nsample = 50
Ntrial = 1e5
```

## Estimator–Correlator Detector

```matlab
Nsample = 50
M = 2
Ntrial = 1e6
```

---

# Main Findings

## Energy Detector

- Detection probability increases monotonically with SNR
- Larger observation lengths improve detection reliability
- Smaller false alarm probabilities require higher SNR

## Estimator–Correlator Detector

- Exploiting signal covariance improves detection performance
- Detection curves become smoother
- Performance becomes less sensitive to `P_FA`
- Correlated signal structure improves robustness

Compared to the energy detector, the estimator–correlator better distinguishes signal components from noise because it incorporates prior signal structure information through the covariance matrix.

---

# Detection Theory Concepts Covered

This project covers several core statistical signal processing topics:

- Neyman–Pearson detection
- Binary hypothesis testing
- Energy detection
- Estimator–correlator detection
- Gaussian random processes
- Signal covariance modeling
- Chi-square statistics
- Monte Carlo simulation
- Detection probability analysis
- False alarm probability
- Random signal detection
- Statistical decision theory

---

# Files

- `Baseline.m` — Energy detector simulation
- `GLM.m` — General linear model detector
- `Detection_Report.pdf` — Full report with derivations, plots, and analysis

---

# References

1. S. M. Kay, *Fundamentals of Statistical Signal Processing: Detection Theory*, Prentice Hall International, 1998.
