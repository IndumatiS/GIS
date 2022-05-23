#k-means clustering
#Inputs
#matrix = input1
#kclusters = input 2
library(dplyr)
library(ggplot2)

#For the purpose of constructing this loop create dummy matrix
#which has two distict population of numbers
M<-matrix(sample(1:200,200), nrow = 50, byrow = TRUE)
M1<-matrix(sample(100:2000,200), nrow = 50, byrow = TRUE)
M<-rbind(M,M1)
M<-scale(M)#scale values in each column of the matrix

#Input variables
kclusters<-2

###################Functions############################
#Make a list of centroid vectors based on number of kclusters
centroid_list<-list()
create_random_centroid<-function(centroid_row,matrix){
  for(i in 1:length(centroid_row)){
    centroid_list[[i]]<-matrix[centroid_row[i],]
  }
  return(centroid_list)
}

#Calculate euclidean distance for every one row at a time using apply family of functions
clusterdistance<-c()
unit_cluster<-function(x,centroid_list_arg){
  #for one row calculations
  #columns will be for the number of kclusters
  for(i in 1:length(centroid_list_arg)){
    clusterdistance[i]<-sqrt(sum((x-unlist(centroid_list_arg[i]))^2))
  }
  cluster<-which(clusterdistance==min(clusterdistance))[1]
  return (cluster)
}

unit_distance<-function(x,centroid_list_arg,centroid_number){
  #for one row calculations
  #columns will be for the number of kclusters
  clusterdistance<-sqrt(sum((x-unlist(centroid_list_arg[centroid_number]))^2))
  
  return(clusterdistance)

}

wcss_distance<-function(){
  #cluster[1]
  clusterdistance_wcss<-c()
  for(k in 1:length(centroid_list)){
    df_filtered<-df %>% filter(cluster_vector == k)
    cluster_col<-ncol(df_filtered)
    clusterdistance_wcss[k]<-mean(apply(df_filtered[,-(ncol(df_filtered))], 1,FUN = unit_distance,centroid_list,k))
  }
  return(mean(clusterdistance_wcss))
}

###################Functions############################


if(kclusters >0){
  #Index random rows for the initialisation of clusters
  centroid_row<-sample(nrow(M), kclusters, replace = FALSE, prob = NULL)
  
  #Call create random_centroid to store the centroid values as a list
  centroid_list<-create_random_centroid(centroid_row,M)
  
  #calculate the cluster groupings for every data
  counter<-1
  checkNewCentroid = 1
  #call the first vector of the matrix to calculate euclidean distance then try it out the remaining using sapply
  #cluster<-unit_pytho(M[1,],centroid_list)
  
  #This will repeat through the matrix using different set of centroid for every round until the consecutive set of centroids equal each 
  #other. 
  while(length(checkNewCentroid)!=0 ){
    cluster_vector<-apply(M, 1,FUN = unit_cluster,centroid_list)
    M_withClustercol<-as.data.frame(cbind(M,cluster_vector))
    M_withClustercol$cluster_vector<-as.factor(M_withClustercol$cluster_vector)
    M_withClustercol_summary<-as.data.frame(M_withClustercol %>% group_by(cluster_vector) %>% summarise(across(everything(), mean)))
    centroid_list1<-split(M_withClustercol_summary[,-1],seq(nrow(M_withClustercol_summary[,-1])))  
    checkNewCentroid<-which(centroid_list %in% centroid_list1==FALSE)
    centroid_list<-centroid_list1
    print(paste(counter, checkNewCentroid))
    counter <- counter + 1
  }
}


#Elbow plot

wcss_kmeans<-function(Matrix){
  
  wcss_k1to20<-c()
  M<-Matrix
  
  for(i in 1:20){
  clusterdistance_wcss<-c()
  kclusters<-i
  
  #Index random rows for the initialisation of clusters
  centroid_row<-sample(nrow(M), kclusters, replace = FALSE, prob = NULL)
  
  #Call create random_centroid to store the centroid values as a list
  centroid_list<-create_random_centroid(centroid_row,M)
  
  #calculate the cluster groupings for every data
  counter<-1
  checkNewCentroid = 1
  
  while(length(checkNewCentroid)!=0 ){
    cluster_vector<-apply(M, 1,FUN = unit_cluster,centroid_list)
    M_withClustercol<-as.data.frame(cbind(M,cluster_vector))
    M_withClustercol$cluster_vector<-as.factor(M_withClustercol$cluster_vector)
    M_withClustercol_summary<-as.data.frame(M_withClustercol %>% group_by(cluster_vector) %>% summarise(across(everything(), mean)))
    centroid_list1<-split(M_withClustercol_summary[,-1],seq(nrow(M_withClustercol_summary[,-1])))  
    checkNewCentroid<-which(centroid_list %in% centroid_list1==FALSE)
    centroid_list<-centroid_list1
    print(paste(counter, checkNewCentroid))
    counter <- counter + 1
  }
  
  #calculate the distance
  for(k in 1:length(centroid_list)){
    df_filtered<-M_withClustercol %>% filter(cluster_vector == k)
    cluster_col<-ncol(df_filtered)
    clusterdistance_wcss[k]<-sum(apply(df_filtered[,-(ncol(df_filtered))], 1,FUN = unit_distance,centroid_list,k))^2
    
  }
  print(clusterdistance_wcss)
  wcss_k1to20[i]<-sum(clusterdistance_wcss)
  }
  return(wcss_k1to20)
}



M_Matrix_wcss<-wcss_kmeans(iris[,1:4])



M_withClustercol$xaxis<-c(1:100)
M_withClustercol %>% 
  ggplot(aes(x=xaxis)) +
    geom_point(aes(y=V1, color = cluster_vector)) +
    geom_point(aes(y=V2, color = cluster_vector)) +
    geom_point(aes(y=V3, color = cluster_vector))
