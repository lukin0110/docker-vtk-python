from __future__ import print_function
# http://www.vtk.org/Wiki/VTK/Examples/Python/DistanceBetweenPoints
import vtk
import math

p0 = (0, 0, 0)
p1 = (1, 1, 1)

distSquared = vtk.vtkMath.Distance2BetweenPoints(p0, p1)

dist = math.sqrt(distSquared)

print("p0 = ", p0)
print("p1 = ", p1)
print("distance squared = ", distSquared)
print("distance = ", dist)
