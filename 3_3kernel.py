# -*- coding: utf-8 -*-
"""
Created on Fri Apr 8 13:52:00 2022
@author: shain421
"""

# Author: Indumati Sharma
#
# Date: April 2022
# 
#
import math
import numpy as np
from decimal import *
def slope_3_by_3_kernel(ar,ar1,cell_size)
:
 
#Clear the values of the duplicate array passed as argument
 
for i in range(len(ar)
)
:#iterates through the rows
 
for j in range(len(ar[i]
)
) :
 
if(ar[i]
[j]==-9999)
:
 
continue
 
else :
 
ar1[i]
[j]=0
 
 
#define all the variables used to calculate the slope
 
dz_dx=0
 
dz_dy=0
 
x_cellsize=cell_size
 
y_cellsize=cell_size
 
 
#Run iteration process to perform 3X3 kernal operation
 
for i in range(len(ar)-2)
:#iterates through the rows
 
for j in range(len(ar[i]
)-2)
:#iterates through the columns
 
#Define all the values that this kernel will hav
 
a=ar[i]
[j]
 
b=ar[i]
[j+1]
 
c=ar[i]
[j+2]
 
d=ar[i+1]
[j]
 
e=ar[i+1]
[j+1]
 
f=ar[i+1]
[j+2]
 
g=ar[i+2]
[j]
 
h=ar[i+2]
[j+1]
 
ivar=ar[i+2]
[j+2]
 
 
kernel_vars=[a,b,c,d,e,f,g,h,ivar]
 
for k in kernel_vars:
 
if(k==0 or k==-9999)
:
 
continue
 
elif(k==ivar)
:
 
dz_dx = (
(c + 2*f + ivar) - (a +2*d + g)
) / (8 * x_cellsize)
 
dz_dy = (
(g + 2*h + ivar) - (a + 2*b + c)
) / (8 * y_cellsize)
 
rise_run = math.sqrt(
(dz_dx)**2 + (dz_dy)**2)
 
slope_degrees = math.atan(rise_run) * 57.2957
 
#Now assign the slope_degree value to cell e withn 3X3 kernel of the dupliated array
#kernel_vars=[a,b,c,d,e,f,g,h,ivar]
#print(kernel_vars)
 
ar1[i+1]
[j+1]=float(slope_degrees)
 
 
 
return (ar1)
def trial(array,array1)
:
 
#Clear the values of the duplicate array passed as argument
 
for i in range(len(array)
)
:#iterates through the rows
 
for j in range(len(array[i]
)
)
:
 
array1[i]
[j]=0
 
return(array1)
