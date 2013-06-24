import numpy as np
import my_ufunc_types

x = np.array([1.0, 2.0, 3.0, 4.0])
y = x.astype(np.intc)

print "square(x) [dtype=double]"
print my_ufunc_types.square(x)
print

print "square(x) [dtype=int]"
print my_ufunc_types.square(y)
