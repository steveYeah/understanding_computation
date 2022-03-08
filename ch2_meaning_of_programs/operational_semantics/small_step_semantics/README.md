# Small Step Semantics

This section creates a very basic operational semantics for a toy language called SIMPLE. It uses Ruby as the metalanguage

It defines a machine that evaluates a program by operating on its syntax directly, continually reducing it, in small steps, until it cannot be reduced any further. At this point we have arrived at our result.

This is very similar to how we evaluate algebraic expressions

(1 x 2) + (3 x 4)

2 + (3 x 4)

1 + 12

14

As this is for example purposes only, we only define a few statements and expressions. Correctness is not covered in this section as this is the job of a Static Semantics. Here we focus on the the Dynamic Semantics only

The code is broken down into expressions, statements and the machine that runs the process of the reductions. We make use of the “DoNothing” statement to state when there are no further reductions to take place.

Examples from the book are in the examples code to see what can be done and how. 

A good embodiment of the small step reductions can be seen in the while statement, where this is reduced to an if statement, with the body of the original while statement run when the condition is true, followed by the original while statement again. This recursive behaviour allow the small step reduction to keep track of the original while statement, whilst being able to reduce down to the body of the while by reusing existing structures
