---
template: inverse

# 1. Concept overview

### Data-types, memory layout, broadcasting, indexing, ufuncs

---
layout: false

.left-column[
  ## Data types
]
.right-column[
]

---
.left-column[
  ## Memory layout
]

---

.left-column[
  ## Broadcasting
]

.right-column[

When combining two arrays of different shapes, shapes are matched from right to
left.  Match when:

- Dimensions are equal.
- One dimension is either None or 1.

```
   (5, 10)      (5, 10)    (5, 10, 1)
(3, 5, 10)      (6, 10)       (10, 5)
----------      -------    ----------
(3, 5, 10) OK   BAD        (5, 10, 5) OK
```
]

---

.left-column[
  ## Broadcasting example
]

.right-column[

```python
>>> x = np.arange(4)
>>> y = x[:, np.newaxis]
>>> x
array([0, 1, 2, 3])
>>> y
array([[0],
       [1],
       [2],
       [3]])
>>> x.shape
(4,)
>>> y.shape
(4, 1)
>>> (x + y).shape
(4, 4)
```

See also ``np.broadcast_arrays``.

]

---
.left-column[
  ## Indexing
]

.right-column[

None, indexing + broadcasting

.tip[.red[TIP] Best to avoid ``:`` and ``...`` in broadcasting--output shape is
sometimes hard to predict.]

]

---

.left-column[
  ## Universal Functions
]

.right-column[
  Standard vs generic
]
