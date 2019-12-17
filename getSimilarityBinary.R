

# Get siliarities for a bianry matrix/sparse

#dataDist2 is the dataframe with the Binary variables and Id column
datMatrix <- as.matrix(dataDist2)

#row names will be id
rownames(datMatrix) <- dataDist[,'id']

#Inner product
result <- datMatrix%*%t(datMatrix)


#symmetric matrix so making distances in the upper half 0
result[upper.tri(result,diag = T)] <- 0

#creating a dummy Df for reults
nearestDf <- data.frame(PSU=as.character(),nerestPsu=as.character(),stringsAsFactors = F)

#loop over to find closest individuals
for(i in 1:nrow(dataDist)){
  nearestDf[i,1] <- names(result[i,])[i]
  nearestDf[i,2]<- names(which.max( result[,i]))
}


head(nearestDf)

