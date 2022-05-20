#k-means clustering
#Inputs
#matrix = input1
#kclusters = input 2


#For the purpose of constructing this loop create dummy matrix
#which has two distict population of numbers
M<-matrix(sample(1:20,20), nrow = 5, byrow = TRUE)
M1<-matrix(sample(100:200,20), nrow = 5, byrow = TRUE)
M<-cbind(M,M1)

#Input variables
kclusters<-3
centroid_row<-sample(nrow(M), kclusters, replace = FALSE, prob = NULL)

#Make a list of centroid vectors based on number of kclusters
centroid_list<-list()
create_random_centroid<-function(centroid_row,matrix){
  for(i in 1:length(centroid_row)){
    centroid_list[[i]]<-matrix[centroid_row[i],]
  }
  return(centroid_list)
}

#Call create random_centroid to store the centroid values as a list
centroid_list<-create_random_centroid(centroid_row,M)

#Calculate euclidean distance for every one row at a time using apply family of functions
clusterdistance<-c()
unit_pytho<-function(x,centroid_list_arg){
  #for one row calculations
  #columns will be for the number of kclusters
  for(i in 1:length(centroid_list_arg)){
    clusterdistance[i]<-sqrt(sum((x-unlist(centroid_list_arg[i]))^2))
  }
  cluster<-which(clusterdistance==min(clusterdistance))[1]
  return (cluster)
}

#call the first vector of the matrix to calculate euclidean distance then try it out the remaining using sapply
#cluster<-unit_pytho(M[1,],centroid_list)
cluster_vector<-apply(M, 1,FUN = unit_pytho,centroid_list )

kmeans_lab3<-fuction(matrix, kclusters){
  kclusters
  ncols<-ncol(matrix)
  nrows<-nrows(matrix)
  kcluster_distance<-list()
  for (i in nrows){
    matrix[i]
  }
  kcluster_distance[i]<-vector-centroid[1]
  
  for(i in 1:nrows){
    kcluster_distance[i]<-vector-centroid[1]
    kcluster_distance[i]<-vector-centroid[2]
    cluster_col<-which(vector==min(vector))[1]
    
    return(cluster_vector)
  }
}


#make the dataframe

#in that distance row which is the minimum? assign it to that cluster
