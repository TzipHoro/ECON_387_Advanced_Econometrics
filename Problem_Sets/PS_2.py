# ECON 387
# Problem Set 2

import numpy as np

#1
np.random.seed(37)
tmp = np.random.randn(21,21)

#2
np.fill_diagonal(tmp, 1)

#3
np.linalg.cond(tmp)

#4
np.linalg.inv(tmp)

#5
np.trace(tmp)

#6
np.sort(tmp, 0)

#7
tmp = tmp[0:20,0:20]

#8
tmp1 = tmp.reshape(40,10)

#9
tmp2 = np.tile(tmp1, 4)

#10
np.linalg.cond(tmp2)

#11
np.linalg.inv(tmp2)

#12
tmp2[tmp2 <= 0] = 0.5

#13  
tmp2[0,0:] *= -1
tmp2[1:,0] *= -1

#14
tmp3 = np.log(tmp2)

#15
np.argwhere(np.isnan(tmp3))




