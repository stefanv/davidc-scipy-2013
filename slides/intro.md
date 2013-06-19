## Diving into NumPy

 - Stéfan Van der Walt:
 - David Cournapeau: cournape@gmail.com / @cournape



## Goals of the tutorial

  - understand how NumPy works internally
  - obtain some actionable knowledge to work on NumPy codebase



## What will you learn ?

At the end of this tutorial, you should be able to:

  - build numpy to customize it
  - know how to add new array methods, ufunc, and simple dtype
  - navigate and focus on some particular aspect of the codebase



 
## Appropriate usecases to modify numpy

Default thought: don`t !

 - new features usually better handled outside numpy
 - you really want to use cython

TODO: examples



## Appropriate usecases to modify numpy (Cont.)

 - fixing a numpy bug
 - improving the speed of some particular feature
 - you`re following this tutorial


## Exercise:

Try to fix https://github.com/numpy/numpy/issues/2592

	- find out where the meat of the functionality is implemented
	- can you understand the bug ?
	- fix it !
