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

## Experiment

We experiment with two values of alpha: 0, 3.  
For each alpha, we generate **nexp** **n**-dimensional vectors (**x**s).

We choose a set of **m**.  
For every **m**, we generate a random sensing matrix **phi** of size **m**x**n** with entries from iid Gaussian with mean 0 and variance 1/**m**.

We use this to generate measure signal **y** (**phi** **x**).  
We add Gaussian noise with standard deviation as 0.01 times average of measured signal.

We reconstruct **x** using the MAP estimate formula derived above and compute Relative Root Mean Square Error (Relative RMSE).
