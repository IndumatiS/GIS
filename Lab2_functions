# -*- coding: utf-8 -*-
"""
Created on Thu Apr 28 15:22:04 2022

@author: shain421
"""

#Lab2- Buffering for lat/lag points
import pandas as pd
import os
import csv
import math
import math
import statistics
from math import sqrt
from scipy.spatial import distance
import arcpy


from math import radians, cos, sin, sqrt

def haversine(lat1, lon1, lat2, lon2):

      R =  6372.8 # this is in miles.  For Earth radius in kilometers use 6372.8 km

      dLat = radians(lat2 - lat1)
      dLon = radians(lon2 - lon1)
      lat1 = radians(lat1)
      lat2 = radians(lat2)

      a = sin(dLat/2)**2 + cos(lat1)*cos(lat2)*sin(dLon/2)**2
      c= 2*math.atan2(sqrt(a), sqrt(1-a) )
      return R * c

# # Usage
# lon1 = 5.73138889
# lat1 = 50.06638889
# lon2 = 3.07000000
# lat2 = 58.64388889

# print(haversine(lat1, lon1, lat2, lon2))


#where	φ is latitude, λ is longitude, R is earth’s radius (mean radius = 6,371km);
#note that angles need to be in radians to pass to trig functions!



def anti_haversine(lat1,long1,bearing,distance):
   
    #Variables
    R = 6378.1 #Radius of the Earth
    brng =  math.radians(bearing) #Bearing is 90 degrees converted to radians.
    d = distance #Distance in km
    lat1 =  math.radians(lat1) #Current lat point converted to radians
    long1 =  math.radians(long1) #Current long point converted to radians
    

    lat2 = math.asin( math.sin(lat1)*math.cos(d/R) +
         math.cos(lat1)*math.sin(d/R)*math.cos(brng))
    
    long2 = long1 + math.atan2(math.sin(brng)*math.sin(d/R)*math.cos(lat1),
                 math.cos(d/R)-math.sin(lat1)*math.sin(lat2))
    
    lat2 = math.degrees(lat2)
    long2 = math.degrees(long2)
    
    return(lat2,long2)


    # #test the funtion
    #  #lat2  52.20444 - the lat result I'm hoping for
    #  #lon2  0.36056 - the long result I'm hoping for.
    
    # lat1 = math.radians(52.20472) #Current lat point converted to radians
    # long1 = math.radians(0.14056) #Current long point converted to radians
    # bearing = 1.57 #Bearing is 90 degrees converted to radians.
    
    # function_test=anti_haversine(lat1,long1,bearing)
    
    
    
def nearest_neighbours(df):
    long1 = 0
    lat1 = 0
    long2 = 0
    lat2 = 0
    min_distance_array = []
    NNI = 0
    A = 10000000000 #total study area assumption 10000000000 m2
    
    for i in range(0,len(df)):
        array1 = []
        long1 = df.iloc[i][1]
        lat1 = df.iloc[i][2]
        if(i!=len(df)-1):
            for j in range(0,len(df)):
                if(j!=i):
                    long2=df.iloc[j][1]
                    lat2 = df.iloc[j][2]
                    point1 = (lat1, long1)
                    point2 = (lat2, long2)
                    array1.append(distance.euclidean(point1, point2))
            #print(distance)
            min_distance_array.append(min(array1))
            #print("Currently at index:" , i ,"out of" , len(df))
    #print("Finished calculating minimum distance",min_distance_array )
    #Observed mean
    Do = statistics.mean(min_distance_array)
    print("Calculated Observed mean:", Do)
    #Expected mean
    De = 0.5/(sqrt(len(min_distance_array)/A))
    print("Calculated expected mean:", De)
    #Ratios of the two means
    NNI = Do/De
    print("Calculated NNI")
    return NNI 

def kmlForLab2(xcol,ycol,fname):
    #XYpoints1_wgs84
    #XYpoints1_wgs84.csv
    #print(xrow,yrow,idrow)

    
    #Make pandas dataframe
    df = pd.read_csv(fname + '.csv')
    #Skip the 1st header row.
    #data.next()
    #Open the file to be written.
    f = open('Lab2_kml.kml', 'w')
    
    #Writing the kml file.
    f.write("<?xml version='1.0' encoding='UTF-8'?>\n")
    f.write("<kml xmlns='http://earth.google.com/kml/2.0'>\n")
    f.write("<Document>\n")
    f.write("<!--"+ "buffer -->\n")
    f.write("<Placemark>\n")
    f.write("   <name>"  + '.kml' +"</name>\n")
    f.write("   <Polygon> <outerBoundaryIs> <LinearRing>\n")
    f.write("           <coordinates>\n" )
    for j in range(0,len(df)):
        f.write(str((  df.iloc[j][xcol]))  + "," + (str( df.iloc[j][ycol]))+ "\n") 
    f.write("           </coordinates>\n" )
    f.write("   </LinearRing> </outerBoundaryIs> </Polygon> \n")
    f.write("</Placemark>\n")
    f.write("</Document>\n")
    f.write("</kml>\n")
    f.close()
    print ("File Created. ")
    print ("Press ENTER to exit. ")

def kmlForLab2Buffering(xcol,ycol,idcol,fname):
    #XYpoints1_wgs84
    #XYpoints1_wgs84.csv
    #print(xrow,yrow,idrow)

    
    #Make pandas dataframe
    df = pd.read_csv(fname + '.csv')
    IDs = list(set(df.iloc[:,idcol]))
    #Skip the 1st header row.
    #data.next()
    #Open the file to be written.
    f = open('Buffered_kml.kml', 'w')
    
    #Writing the kml file.
    f.write("<?xml version='1.0' encoding='UTF-8'?>\n")
    f.write("<kml xmlns='http://earth.google.com/kml/2.0'>\n")
    f.write("<Document>\n")
    
    for uniqueID in IDs:
        subset_df= df[df.iloc[:,idcol] == uniqueID]
        #print(subset_df)
        f.write("<!--"+ str(uniqueID+1) + "buffer -->\n")
        f.write("<Placemark>\n")
        f.write("   <name>" + str(uniqueID+1) + '.kml' +"</name>\n")
        f.write("   <Polygon> <outerBoundaryIs> <LinearRing>\n")
        f.write("           <coordinates>\n" )
        for j in range(0,358):
                f.write(str((  subset_df.iloc[j][ycol])) 
                        + "," 
                        + (str( subset_df.iloc[j][xcol]))
                        + "\n") 
        f.write("           </coordinates>\n" )
        f.write("   </LinearRing> </outerBoundaryIs> </Polygon> \n")
        f.write("</Placemark>\n")
                #print(xcol, ycol, j)
    f.write("</Document>\n")
    f.write("</kml>\n")
    f.close()
    print ("File Created. ")
    print ("Press ENTER to exit. ")



