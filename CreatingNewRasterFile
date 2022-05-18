# -*- coding: utf-8 -*-
"""
Created on Mon Apr 11 23:00:02 2022
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
file_path_open= input("\tProvide the file's path to open: ")
#U:\SURV319_Lab1\surv319_519_lab1data\\nzdem1000.asc
ascii_grid = np.loadtxt(file_path_open, skiprows=6)
#save the output
Lab1RasterOutput = arcpy.NumPyArrayToRaster(ascii_grid,x_cell_size=1)
file_path_save= input("\tProvide the file's path to save: ")
#U:/output/SURV319_DEM/DemRaster1
Lab1RasterOutput.save(file_path_save)
