## Logit models using OTUs from Random Forest feature selection
deps = c("parallel", "gtools","randomForest");
for (dep in deps){
  if (dep %in% installed.packages()[,"Package"] == FALSE){
    install.packages(as.character(dep), quiet=TRUE);
  }
  library(dep, verbose=FALSE, character.only=TRUE)
}

meta <- read.delim('data/training.meta.tsv', header=T, sep='\t')
shared <- read.delim('data/training.an.0.03.0.03.filter.shared', header=T, sep='\t')

all.data <- merge(meta, shared, by.x='sample', by.y='Group')

#Cancer vs Normal
canc.data <- all.data[all.data$dx!='adenoma',]
canc.data$dx <- factor(canc.data$dx, levels=c('normal', 'cancer'))

canc.rf <- cbind(dx=canc.data$dx, canc.data[,grep('Otu[0123456789]', colnames(all.data))]) #makes table on which to run random forest
canc.rf.out <- randomForest(dx ~ ., data=canc.rf, importance=TRUE, proximity=TRUE, ntree=10000)
save(canc.rf.out, file='data/cancer.RFmodel.RData')

canc.imp <- as.data.frame(importance(canc.rf.out, scale=T)) #extracts OTU importance from RF output
canc.imp <- canc.imp[order(canc.imp[,3], decreasing=T),] #sorts by mean decrease accuracy
canc.otus <- row.names(canc.imp)[1:20] #takes top 20 OTUs

calcAIC <- function(x){ #Takes a list of formulas and calculates thei AIC values
  return(glm(x, data=canc.data, family=binomial('logit'))$aic)
}

makeFormula <- function(x){ #this function will be used to convert combinations of OTUs in formula objects
  as.formula(paste('dx', paste(x, collapse=' + '), sep=' ~ '))
}

for(i in 1:20){
  start.time <- proc.time()[3]
  combos <- combinations(length(canc.otus), r=i, v=canc.otus) #makes a matrix with all combinations of <i> otus
  formulas <- apply(X=combos, MARGIN=1, FUN=makeFormula)
  aics <- mclapply(formulas, FUN=calcAIC, mc.cores=16)
  results <- cbind(combos,unlist(aics))
  results <- results[order(results[,i+1], decreasing=F),]  
  write.table(head(results, n=1000), file=sprintf('data/%iotu.cancer.rfLog.out', i), sep='\t', row.names=F, col.names=F, quote=F) #writes 1000 best models to a file
  cat('It took', (proc.time()[3]-start.time)%/%60, 'minutes', signif((proc.time()[3]-start.time)%%60, 2), 
      'seconds to run', nrow(results), 'models with', i, 'otus.\n')
}


#Adenoma vs Normal
ade.data <- all.data[all.data$dx!='cancer',]
ade.data$dx <- factor(ade.data$dx, levels=c('normal', 'adenoma'))

ade.rf <- cbind(dx=ade.data$dx, ade.data[,grep('Otu[0123456789]', colnames(all.data))]) #makes table on which to run random forest
ade.rf.out <- randomForest(dx ~ ., data=ade.rf, importance=TRUE, proximity=TRUE, ntree=10000)
save(ade.rf.out, file='data/adenoma.RFmodel.RData')

ade.imp <- as.data.frame(importance(ade.rf.out, scale=T)) #extracts OTU importance from RF output
ade.imp <- ade.imp[order(ade.imp[,3], decreasing=T),] #sorts by mean decrease accuracy
ade.otus <- row.names(ade.imp)[1:20] #takes top 20 OTUs

calcAIC <- function(x){ #Takes a list of formulas and calculates thei AIC values
  return(glm(x, data=ade.data, family=binomial('logit'))$aic)
}

makeFormula <- function(x){ #this function will be used to convert combinations of OTUs in formula objects
  as.formula(paste('dx', paste(x, collapse=' + '), sep=' ~ '))
}

for(i in 1:20){
  start.time <- proc.time()[3]
  combos <- combinations(length(ade.otus), r=i, v=ade.otus) #makes a matrix with all combinations of <i> otus
  formulas <- apply(X=combos, MARGIN=1, FUN=makeFormula)
  aics <- mclapply(formulas, FUN=calcAIC, mc.cores=16)
  results <- cbind(combos,unlist(aics))
  results <- results[order(results[,i+1], decreasing=F),]  
  write.table(head(results, n=1000), file=sprintf('data/%iotu.adenoma.rfLog.out', i), sep='\t', row.names=F, col.names=F, quote=F) #writes 1000 best models to a file
  cat('It took', (proc.time()[3]-start.time)%/%60, 'minutes', signif((proc.time()[3]-start.time)%%60, 2), 
      'seconds to run', nrow(results), 'models with', i, 'otus.\n')
}


#Lesion vs Normal
les.data <- all.data
levels(les.data$dx)[1:2] <- 'lesion'
les.data$dx <- factor(les.data$dx, levels=c('normal', 'lesion'))

les.rf <- cbind(dx=les.data$dx, les.data[,grep('Otu[0123456789]', colnames(all.data))]) #makes table on which to run random forest
les.rf.out <- randomForest(dx ~ ., data=les.rf, importance=TRUE, proximity=TRUE, ntree=10000)
save(les.rf.out, file='data/lesion.RFmodel.RData')

les.imp <- as.data.frame(importance(les.rf.out, scale=T)) #extracts OTU importance from RF output
les.imp <- les.imp[order(les.imp[,3], decreasing=T),] #sorts by mean decrease accuracy
les.otus <- row.names(les.imp)[1:20] #takes top 20 OTUs

calcAIC <- function(x){ #Takes a list of formulas and calculates thei AIC values
  return(glm(x, data=les.data, family=binomial('logit'))$aic)
}

makeFormula <- function(x){ #this function will be used to convert combinations of OTUs in formula objects
  as.formula(paste('dx', paste(x, collapse=' + '), sep=' ~ '))
}

for(i in 1:20){
  start.time <- proc.time()[3]
  combos <- combinations(length(les.otus), r=i, v=les.otus) #makes a matrix with all combinations of <i> otus
  formulas <- apply(X=combos, MARGIN=1, FUN=makeFormula)
  aics <- mclapply(formulas, FUN=calcAIC, mc.cores=16)
  results <- cbind(combos,unlist(aics))
  results <- results[order(results[,i+1], decreasing=F),]  
  write.table(head(results, n=1000), file=sprintf('data/%iotu.lesion.rfLog.out', i), sep='\t', row.names=F, col.names=F, quote=F) #writes 1000 best models to a file
  cat('It took', (proc.time()[3]-start.time)%/%60, 'minutes', signif((proc.time()[3]-start.time)%%60, 2), 
      'seconds to run', nrow(results), 'models with', i, 'otus.\n')
}


