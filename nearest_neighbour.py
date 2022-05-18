# -*- coding: utf-8 -*-
"""
Created on Fri Apr 29 23:50:59 2022

@author: shain421
"""
#Nearest_neighbours.py

import pandas as pd
import os
import csv
from math import radians, cos, sin, sqrt
from decimal import *
import numpy as np
from numpy import genfromtxt
from pyproj import Proj, transform
import pyproj

import statistics
from Buffering_360points  import *
#'XYpoints1_wgs84.csv'

#test files XYpoints1_nztm2000.csv XYpoints2_nztm2000.csv XYpoints3_nztm2000.csv



try:
    file_input = input("Input the file name with .csv extension:")
    df_NNI = pd.read_csv(file_input,  header=0)
    df_NNI_wgs = pd.read_csv(file_input,  header=0)
    
    #Run nearest_neighbours
    print(nearest_neighbours(df_NNI))
    

except:
  print("Something went wrong")
  
#XYpoints1_nztm2000.csv Calculated NNI=0.25413995919876947, which is highly clustered
#XYpoints2_nztm2000.csv Calculated NNI = 1.2031350876024414, which is more scattered
#XYpoints3_nztm2000.csv Calculated NNI = 0.9593834696031001, which is randomaly distributed


