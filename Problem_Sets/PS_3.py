#ECON 387
#Problem Set 3

import numpy as np

#1
def simpRegress(x, y):
  
  size = len(x)
  xBar = np.mean(x)
  yBar = np.mean(y)
  b1_num = 0
  b1_den = 0
  
  for i in range(0,size-1):
    b1_num += ((x[i]-xBar)*(y[i]-yBar))
    b1_den += ((x[i]-xBar)**2)
  
  b1_Hat = b1_num/b1_den
  b0_Hat = yBar - (b1_Hat*xBar)
  
  return(b0_Hat, b1_Hat)


#2
np.random.seed(37)

#3
x = np.random.randn(1000)

#4
epsilon = np.random.randn(1000)
y = 0.5 + (1.8*x) + epsilon

#5
simpRegress(x,y)
# the estimates are almost, but not exactly equal to the true values, because OLS minimizes the error term.

#6
epsilon = np.random.randn(1000)
y = 0.5 + (1.8*x) + epsilon
simpRegress(x,y)
# the estimates are slightly different, but still almost equal because closeness of fit depends on the error term.
