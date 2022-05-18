
# -*- coding: utf-8 -*-
"""
Created on Mon Apr 11 20:40:11 2022
@author: shain421
"""
import numpy as np
import DEM_threshold_userdefined
import sys
import numpy
import arcpy
import math
from decimal import * 
import collections
#open the file based on user input
#open the file based on user input
file_path_open= input("\tProvide the file's path to open: ")
#U:\SURV319_Lab1\surv319_519_lab1data\\nzdem1000.asc
ascii_grid = np.loadtxt(file_path_open, skiprows=6)
ascii_grid_slope=np.loadtxt(file_path_open, skiprows=6)
#ask input from user to select slope or convexity
DEM_threshold= float(input("\tWhat is the threshold you want for your DEM?: ")
)
#call the function
modified_array = DEM_threshold_userdefined.DEM_threshold(ar=ascii_grid, 
 
ar1=ascii_grid_slope, 
 
threshold=DEM_threshold)
#save the output
Lab1RasterOutput = arcpy.NumPyArrayToRaster(modified_array,x_cell_size=1)
file_path_save= input("\tProvide the file's path to save: ")
#U:/output/SURV319_ThresholdDEM/1myRaster
Lab1RasterOutput.save(file_path_save)
