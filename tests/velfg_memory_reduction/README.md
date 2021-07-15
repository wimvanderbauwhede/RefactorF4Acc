This is an example of reducing memory by eliminating itermediate arrays.

The code is based on one of the key algorithms in the Large Eddy Simulator for Urban Flows.


The simulator performs the following actions at every timestep (the number in parentheses is the number of full-domain 3-D arrays used):
- Set initial boundary conditions for wind velocity and pressure (4)
- Calculate the turbulent flow using the marker-and-cell method: based on the velocity fields u,v,w calculate the convection components and from this calculates the force fields f,g,h. (37)
- Integrate the force fields over time (Adams-Bashfort) (6)
- Solve the Poisson equation for the pressure using successive over-relatation (6)

In the original code, the turbulent flow algorithm uses the following 3-D arrays, 37 in total:

u,v,w
f,g,h
diu 1..9 for partial derivatives of the velocity
nou 1..9 for interpolated values
cov 1..9 for convection components
df{u,v,w}1 for updating the force fields with their derivatives 
sm 

Of these 37 arrays, only u,v,w are actual inputs to the calculation and f,g,h computed outputs. 

Our memory reduction approach eliminates the 31 intermediate arrays entirely. In the other algorithms, there are no redundant arrays. 

To illustrate the impact: assumong the GPU has 4GB of memory, then the maximum domain  for the original code was 100 MB, which translates to a domain of about 400x400 points.
After removal of the intermediate arrays, the domain can be up to 1000x1000 points.
As all redundant array accesses are replace by register accesses in the GPU, the resulting code is not only more memory efficient but also faster.