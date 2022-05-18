# -*- coding: utf-8 -*-
"""
Created on Thu Apr 7 22:58:29 2022
@author: shain421
"""
import numpy as np
import slope_3_3kernel
import sys
import numpy
import arcpy
import math
from decimal import *
from matplotlib import pyplot as plt
import numpy as np
import collections
import statistics as s
 
#Open file
file_path_open= input("\tProvide the file's path to open'
: ")
#"U:\SURV319_Lab1\surv319_519_lab1data\\nzdem1000.asc"
ascii_grid = np.loadtxt(file_path_open, skiprows=6)
ascii_grid_slope=np.loadtxt(file_path_open, skiprows=6)
ascii_grid_convexity=np.loadtxt(file_path_open, skiprows=6)
import numpy as np
#ask input from user to select slope or convexity
slope_convexity= input("\tDo you want Slope(type S) or Convexity (type C)?: ")
cell_resolution = int(input("\tWhat is the cell resolution: ")
)
#run the 3X3 kernel based on the user input
if slope_convexity == 'S' :
 modified_array= slope_3_3kernel.slope_3_by_3_kernel(ascii_grid,ascii_grid_slope,cell_resolution)
elif slope_convexity == 'C' : 
 modified_array= slope_3_3kernel.slope_3_by_3_kernel(ascii_grid,ascii_grid_slope,cell_resolution)
 modified_array1= slope_3_3kernel.slope_3_by_3_kernel(modified_array,ascii_grid_convexity,cell_resolution)
else :
 
sys.exit("No correct values were corrected. Run the program again to select.")
# #convert slope_array
if slope_convexity == 'S' :
 
Lab1RasterOutput = arcpy.NumPyArrayToRaster(modified_array,x_cell_size=1)
elif slope_convexity == 'C' : 
 
Lab1RasterOutput = arcpy.NumPyArrayToRaster(modified_array1,x_cell_size=1)
#Which file path to save the output data
#Make sure the file is saved into a folder called output
file_path_save= input("\tProvide the file's path to save'
: ")
#"U:/output/SURV319_SlopeConvex/2ConvexRaster"
#Save the file
Lab1RasterOutput.save(file_path_save)
