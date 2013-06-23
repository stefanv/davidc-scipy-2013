---
template: inverse

# Universal Functions

---

.left-column[
  ## API
]

.right-column[

``numpy/core/include/numpy/ufunc_api.txt``
``numpy/core/include/numpy/ufuncobject.h``

- Vectorized function that takes a fixed number of scalar inputs and produces a
fixed number of scalar outputs.

- Supports array broadcasting, type casting, and other standard features

]

---

.left-column[
  ## Pure Python ufunc
]

.right-column[

```python
def range_sum(a, b):
    return np.arange(a, b).sum()

rs = np.frompyfunc(range_sum, 2, 1)

x = np.array([[1, 2, 3, 4]])

>>> rs(x, x + 1)
array([[1, 2, 3, 4]], dtype=object)

>>> rs(x, x.T)
array([[0, 0, 0, 0],
       [1, 0, 0, 0],
       [3, 2, 0, 0],
       [6, 5, 3, 0]], dtype=object)
```

- Note that broadcasting is supported
- Unfortunately, the output is always an object array.  Also slow, because
  we're wrapping a Python call.

]

---

.left-column[
  ## Ufunc calling
]

.right-column[

Keywords:

- ``out`` : Output array, useful for in-place computation.
- ``where`` : Ufunc only calculated where ``broadcast(mask, inputs) == True``.
- ``casting`` : Casting behavior (more later).
- ``order`` : Calculation iteration order and memory layout of output array.
- ``dtype`` : Output *and calculation* dtype.  Often important for
  accumulators.
- ``sig`` : Data-type or signature string; indicates which underlying 1-D loop
  is executed (typically the loops are found automatically).  See ``types``
  attribute.
- ``extobj`` : Specify ufunc buffer size, error mode integer, error call-back
  function.

]

---

.left-column[
  ## Ufunc output type
]

.right-column[

- Determined by input class with highest `__array_priority__`.

```
class StrongArray(np.ndarray):
    __array_priority__ = 10


class WeakArray(np.ndarray):
    __array_priority__ = 1


>>> s = StrongArray([2, 2]); w = WeakArray([2, 2])

>>> type(s + w).__name__
StrongArray
```
]

---

.left-column[
  ## Ufunc output type (continued)
]

.right-column[

Otherwise, by ``output`` parameter.  Output class may have following methods:

- ``__array_prepare__`` :
  Called before ufunc. Knows some context about the ufunc, and may be used to
  add, e.g., meta-data.  Output then passed to ufunc.

- ``__array_wrap__`` : Called after execution of ufunc.

```python
In [159]: class MyArray(np.ndarray):
     ...:     def __array_prepare__(self, array, (ufunc, inputs, domain)):
     ...:         print 'Array:', array
     ...:         print 'Ufunc:', ufunc
     ...:         print 'Inputs:', inputs
     ...:         print 'Domain:', domain
     ...:         return array
     ...:
     ...: m = MyArray((1, 2))

In [160]: np.add([1, 2], [3, 4], out=m)
Array: [[  6.93023165e-310   1.33936849e-316]]
Ufunc: <ufunc 'add'>
Inputs: ([1, 2], [3, 4], MyArray([[  6.93023165e-310,   1.33936849e-316]]))
Domain: 0

Out[160]: MyArray([[ 4.,  6.]])
```

<!-- Internally, buffers are used for misaligned data, swapped data, and data
that has to be converted from one data type to another. The size of internal
buffers is settable on a per-thread basis. There can be up to buffers of the
specified size created to handle the data from all the inputs and outputs of a
ufunc. The default size of a buffer is 10,000 elements. Whenever buffer-based
calculation would be needed, but all input arrays are smaller than the buffer
size, those misbehaved or incorrectly-typed arrays will be copied before the
calculation proceeds. Adjusting the size of the buffer may therefore alter the
speed at which ufunc calculations of various sorts are completed. A simple
interface for setting this variable is accessible using the function

setbufsize(size)        Set the size of the buffer used in ufuncs.
-->
]

---

.left-column[
  ## Data type promotion
]

.right-column[

```python
>>> np.add([1, 2], [3.5])
array([ 4.5,  5.5])
```

``types`` attribute of ufunc, e.g. ``np.add.types``.

Common types:

```
 * byte -> b
 * short -> h
 * intc -> i
 * double -> d
 * single -> f
 * longfloat -> g
 * complex double -> D
```

See also ``np.sctypeDict``.

If no suitable ufunc loop exists, try to find one to which can be cast safely
(``np.can_cast``).  Can specify casting policy to ufunc via ``casting`` keyword
(``no``, ``equiv``, ``same_kind``, or ``unsafe``--default is the safe 
``same_kind``).

Scalar transformation
Combination of arrays -- generalized ufuncs
Reductions
]

---

.left-column[
  ## Other ufunc ops
]

.right-column[

- ``ufunc.reduce(a[, axis, dtype, out, keepdims])``<br/>
  Reduces a‘s dimension by one, by applying ufunc along one axis.

- ``ufunc.accumulate(array[, axis, dtype, out])``<br/>
  Accumulate the result of applying the operator to all elements.

- ``ufunc.reduceat(a, indices[, axis, dtype, out])``<br/>
  Performs a (local) reduce with specified slices over a single axis.

- ``ufunc.outer(A, B)``<br/>
  Apply the ufunc op to all pairs (a, b) with a in A and b in B.

]

---

.left-column[
  ## Implementing a ufunc
]

.right-column[

Credit: Chris Jordan-Squire, who wrote the numpy user guide entry
]


<!-- Type resolution -->
