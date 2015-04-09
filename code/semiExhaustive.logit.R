
deps = c("parallel", "gtools");
for (dep in deps){
  if (dep %in% installed.packages()[,"Package"] == FALSE){
    install.packages(as.character(dep), quiet=TRUE);
  }
  library(dep, verbose=FALSE, character.only=TRUE)
}

meta <- read.delim('data/training.meta.tsv', header=T, sep='\t')
shared <- read.delim('data/training.an.0.03.0.03.filter.shared', header=T, sep='\t')

all.data <- merge(meta, shared, by.x='sample', by.y='Group')

otus <- grep('Otu[0123456789]', colnames(all.data), value=T)

numCores <- 16
maxOTUs <- 30
stepUpSize <- 100

#Cancer vs Normal
canc.data <- all.data[all.data$dx!='adenoma',]
canc.data$dx <- factor(canc.data$dx, levels=c('normal', 'cancer'))

calcAIC <- function(x){ #Takes a list of formulas and calculates thei AIC values
  return(glm(x, data=canc.data, family=binomial('logit'))$aic)
}

#calculate aics for 1-otu models
aics<-c()
for(i in 1:length(otus)){
  formula <- paste('dx', otus[i], sep=' ~ ')
  aics[i]<-glm(formula, data=canc.data, family=binomial('logit'))$aic
}
write.table(cbind(otus,aics), file=sprintf('data/1otu.cancer.se.out', i), sep='\t', row.names=F, col.names=F, quote=F)

makeFormulas <- function(x){ #this function will be used to convert combinations of OTUs in formula objects
  as.formula(paste('dx', paste(x, collapse=' + '), sep=' ~ '))
}

#calculates aics for 2- to n-otu models
for(i in 2:maxOTUs){
  goodOTUs <- read.table(sprintf('data/%iotu.cancer.se.out', i-1)) #Reads in previous models with i-1 otus
  goodOTUs <- as.data.frame(goodOTUs[1:stepUpSize,1:(i-1)]) #Keeps the top 100 models with i-1 otus
  
  combos <- c()
  for(x in otus){ # adds each of OTU to the 100 top models
    com <- cbind(goodOTUs, x)
    combos <- rbind(combos, com)
  } 
  
  getDuplicates <- function(x){ # function that finds modls with duplicate OTUs
    return(length(x) - length(unique(unlist(x))) )
  }
  dups <- apply(combos, MARGIN=1, FUN=getDuplicates)
  combos <- combos[!dups,] # removes models with duplicate OTUs
  
  combos <- t(apply(combos, 1, sort))
  combos <- unique(combos)

  formulas <- apply(X=combos, MARGIN=1, FUN=makeFormulas)
  aics <- mclapply(formulas, FUN=calcAIC, mc.cores=numCores)
  results <- cbind(combos,unlist(aics))
  results <- results[order(results[,i+1], decreasing=F),]  
  write.table(head(results, n=1000), file=sprintf('data/%iotu.cancer.se.out', i), sep='\t', row.names=F, col.names=F, quote=F) #writes 1000 best models to a file
}


#####################
#Adenoma vs Normal
ade.data <- all.data[all.data$dx!='cancer',]
ade.data$dx <- factor(ade.data$dx, levels=c('normal', 'adenoma'))

calcAIC <- function(x){ #Takes a list of formulas and calculates thei AIC values
  return(glm(x, data=ade.data, family=binomial('logit'))$aic)
}

#calculate aics for 1-otu models
aics<-c()
for(i in 1:length(otus)){
  formula <- paste('dx', otus[i], sep=' ~ ')
  aics[i]<-glm(formula, data=ade.data, family=binomial('logit'))$aic
}
write.table(cbind(otus,aics), file=sprintf('data/1otu.adenoma.se.out', i), sep='\t', row.names=F, col.names=F, quote=F)

makeFormulas <- function(x){ #this function will be used to convert combinations of OTUs in formula objects
  as.formula(paste('dx', paste(x, collapse=' + '), sep=' ~ '))
}

#calculates aics for 2- to n-otu models
for(i in 2:maxOTUs){
  goodOTUs <- read.table(sprintf('data/%iotu.adenoma.se.out', i-1)) #Reads in previous models with i-1 otus
  goodOTUs <- as.data.frame(goodOTUs[1:stepUpSize,1:(i-1)]) #Keeps the top 100 models with i-1 otus
  
  combos <- c()
  for(x in otus){ # adds each of OTU to the 100 top models
    com <- cbind(goodOTUs, x)
    combos <- rbind(combos, com)
  } 
  
  getDuplicates <- function(x){ # function that finds modls with duplicate OTUs
    return(length(x) - length(unique(unlist(x))) )
  }
  dups <- apply(combos, MARGIN=1, FUN=getDuplicates)
  combos <- combos[!dups,] # removes models with duplicate OTUs
  
  combos <- t(apply(combos, 1, sort))
  combos <- unique(combos)
  
  formulas <- apply(X=combos, MARGIN=1, FUN=makeFormulas)
  aics <- mclapply(formulas, FUN=calcAIC, mc.cores=numCores)
  results <- cbind(combos,unlist(aics))
  results <- results[order(results[,i+1], decreasing=F),]  
  write.table(head(results, n=1000), file=sprintf('data/%iotu.adenoma.se.out', i), sep='\t', row.names=F, col.names=F, quote=F) #writes 1000 best models to a file
}



##################
#Lesion vs Normal
les.data <- all.data
levels(les.data$dx)[1:2] <- 'lesion'
les.data$dx <- factor(les.data$dx, levels=c('normal', 'lesion'))

calcAIC <- function(x){ #Takes a list of formulas and calculates thei AIC values
  return(glm(x, data=les.data, family=binomial('logit'))$aic)
}

#calculate aics for 1-otu models
aics<-c()
for(i in 1:length(otus)){
  formula <- paste('dx', otus[i], sep=' ~ ')
  aics[i]<-glm(formula, data=les.data, family=binomial('logit'))$aic
}
write.table(cbind(otus,aics), file=sprintf('data/1otu.lesion.se.out', i), sep='\t', row.names=F, col.names=F, quote=F)

makeFormulas <- function(x){ #this function will be used to convert combinations of OTUs in formula objects
  as.formula(paste('dx', paste(x, collapse=' + '), sep=' ~ '))
}

#calculates aics for 2- to n-otu models
for(i in 2:maxOTUs){
  goodOTUs <- read.table(sprintf('data/%iotu.lesion.se.out', i-1)) #Reads in previous models with i-1 otus
  goodOTUs <- as.data.frame(goodOTUs[1:stepUpSize,1:(i-1)]) #Keeps the top 100 models with i-1 otus
  
  combos <- c()
  for(x in otus){ # adds each of OTU to the 100 top models
    com <- cbind(goodOTUs, x)
    combos <- rbind(combos, com)
  } 
  
  getDuplicates <- function(x){ # function that finds modls with duplicate OTUs
    return(length(x) - length(unique(unlist(x))) )
  }
  dups <- apply(combos, MARGIN=1, FUN=getDuplicates)
  combos <- combos[!dups,] # removes models with duplicate OTUs
  
  combos <- t(apply(combos, 1, sort))
  combos <- unique(combos)
  
  formulas <- apply(X=combos, MARGIN=1, FUN=makeFormulas)
  aics <- mclapply(formulas, FUN=calcAIC, mc.cores=numCores)
  results <- cbind(combos,unlist(aics))
  results <- results[order(results[,i+1], decreasing=F),]  
  write.table(head(results, n=1000), file=sprintf('data/%iotu.lesion.se.out', i), sep='\t', row.names=F, col.names=F, quote=F) #writes 1000 best models to a file
}

