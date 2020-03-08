# ECON 387
# Problem Set 1


import numpy as np

# 1.
A = np.array([[1,3,3], [2,4,1]])
np.asmatrix(A)
B = np.array([[2,4], [1,5], [6,2]])
np.asmatrix(B)

#a)
A@B

#b)
A.T @ B.T

#c)
B @ A


# 2.
A = np.array([[1,4,7], [3,2,5], [2,5,8]])
np.asmatrix(A)

#a)
np.linalg.det(A)

#b)
np.trace(A)

#c)
np.linalg.inv(A)
