import numpy as np

a = np.arange(1, 10)
print(a)

# compare to range:
x = range(1, 10)
print(x)    # x is an iterator
print(list(x))

# some more arange examples:
x = np.arange(10.4)
print(x)
x = np.arange(0.5, 10.4, 0.8)
print(x)
x = np.arange(0.5, 10.4, 0.8, int)
print(x)
