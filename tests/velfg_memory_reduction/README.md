This is an example of reducing memory by eliminating itermediate arrays.

The code is based on one of the key algorithms in the Large Eddy Simulator for Urban Flows.

The algorithm calculates the convection components based on the velocity field and from this calculates the force fields which are used in all further computations. 

In the original code, this algorithm uses the following 3-D arrays, 37 in total:

u,v,w
f,g,h
diu 1..9 for partial derivatives of the velocity
nou 1..9 for interpolated values
cov 1..9 for convection components
df{u,v,w}1 for updating the force fields with their derivatives 
sm 

Of these 37 arrays, only u,v,w are actual inputs to the calculation and f,g,h computed outputs. Our memory reduction approach eliminates the 31 intermediate arrays entirely. 


