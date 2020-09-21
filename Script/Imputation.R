#Warning. These lines won't produce the same result twice
data = read.table("PreImput.txt", header=T, row.names=1)
library("missForest")
#Imputate missing values
dataImput = missForest(xmis = data, variablewise = TRUE)
#Export values
write.table(dataImput$ximp,file = "PostImput.txt", sep = ";")
#Export errors
write.table(dataImput$OOBerror,file = "ConfidenceMissForest.txt")

#Generate an overall error (isn't produce while variablewise=TRUE)
#Will take a few minutes to compute 10 missForest()
vector.error = vector(length = 10)
for(i in 1:length(vector.error))
{
  vector.error[i] = missForest(xmis = data)$OOBerror
  print(paste("Iteration", i,"is completed"))
}

#Using the output of the random Forest with AA.R
#Use the newly calculated indices instead of the imputed ones in MetaboPostImput.csv