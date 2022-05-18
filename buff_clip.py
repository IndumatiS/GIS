# -*- coding: utf-8 -*-
"""
Created on Wed Aug 20 15:35:13 2014

@author: Joseph Wright
updated for Python 3 by Tony Moore, 7th August 2018

Modified by Indu Sharma, 27 April 2022

This program automates a procedure from lab 1
The suburb boundary is buffered by 50m and then the road network is clipped to the buffered shape.   
"""

#import modules
from decimal import *
import arcpy
import traceback
import sys



try:
    #Allow overwriting
    arcpy.env.overwriteOutput = True
    
    #set parameters
    suburb = arcpy.GetParameterAsText(0) 
    roads = arcpy.GetParameterAsText(1) 
    buffer_val= arcpy.GetParameterAsText(2) 
    output =arcpy.GetParameterAsText(3) 
    
    #Create a filename for the temporary buffer
    temp_buff = output + "_temp"
    
    #Buffer the suburb
    arcpy.AddMessage  ("Buffering " + suburb)
    arcpy.Buffer_analysis(suburb, temp_buff, buffer_val)
    
    #Clip the roads
    arcpy.AddMessage  ("Clipping " + roads)
    arcpy.Clip_analysis(roads, temp_buff, output)
    #Delete the tmporary buffered suburb
    arcpy.Delete_management(temp_buff)
    arcpy.AddMessage  ("Finished")
    
except arcpy.ExecuteError: 
    # Get the tool error messages 
    # 
    msgs = arcpy.GetMessages(2) 

    # Return tool error messages for use with a script tool 
    #
    arcpy.AddError(msgs) 

    # Print tool error messages for use in Python/PythonWin 
    # 
    print (msgs)

except:
    # Get the traceback object
    #
    tb = sys.exc_info()[2]
    tbinfo = traceback.format_tb(tb)[0]

    # Concatenate information together concerning the error into a message string
    #
    pymsg = "PYTHON ERRORS:\nTraceback info:\n" + tbinfo + "\nError Info:\n" + str(sys.exc_info()[1])
    msgs = "ArcPy ERRORS:\n" + arcpy.GetMessages(2) + "\n"

    # Return python error messages for use in script tool or Python Window
    #
    arcpy.AddError(pymsg)
    arcpy.AddError(msgs)
    
