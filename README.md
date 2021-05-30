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
