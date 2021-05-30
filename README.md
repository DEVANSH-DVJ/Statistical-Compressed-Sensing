# Statistical Compressed Sensing

Implemented Compressed Sensing based on Bayesian Statistics.

## Given

![](others/given.png)

## MAP Estimate

We find the maximum a posteriori (MAP) estimate of **x** given **phi**, **y**, **Sigma**

First, we use Bayes' theorem  
![](others/map_arg.png)

Taking derivative to find closed form of MAP estimate  
![](others/map_derivative.png)

Optimizing the inverse computation using Woodbury matrix Identity  
![](others/optimize.png)

Final closed form of MAP estimate  
![](others/map_final.png)

## Generating the Covariance Matrix (Sigma)

Assumption: **i**<sup>th</sup> eigenvalue of the covariance matrix is of the form: **i**<sup>-alpha</sup> for all **i**s.

1. Choose a random orthonormal matrix **U** of size **n**x**n**.
2. Define a diagonal matrix **D** of size **n**x**n** with diagonal entries as **i**<sup>-alpha</sup>.
3. Covariance Matrix, **Sigma** is defined as **UDU'**.
