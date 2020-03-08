# ECON 387
# Problem Set 5


# 1
simpRegress <- function(y, x){
  num = sum((x-mean(x))*(y-mean(y)))
  den = sum((x-mean(x))^2)
  
  Beta1 = num/den
  Beta0 = mean(y)-(Beta1*mean(x))
  coefs = c(Beta0, Beta1)
  return(coefs)
}

# 2
set.seed(37)

# 3
x <- rnorm(1000)

# 4
epsilon <- rnorm(1000)
y <- 0.5 + (1.8*x) + epsilon

# 5
simpRegress(y,x)

# 6
"The estimates are different from their true values due to sampling noise."

# 7
epsilon <- rnorm(1000)
y <- 0.5 + (1.8*x) + epsilon
simpRegress(y,x)
"The estimates are different from their true values due to sampling noise."

