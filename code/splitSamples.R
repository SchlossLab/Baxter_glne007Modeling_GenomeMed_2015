meta <- read.delim('data/metadata.tsv', sep='\t', header=T)

splitDx <- function(dx){ #function for splitting samples within a diagnosis into training and testing sets
  dx.meta<- meta[meta$Dx_Bin==dx,] #gets metadata for diagnosis specified in dx argument
  seed<-521
  continue <- FALSE
  while(continue==FALSE){
    set.seed(seed)
    testset <- sample(1:nrow(dx.meta), trunc(nrow(dx.meta)/3)) #randomly picks indices for samples to go into test set
    test.meta <- dx.meta[testset,] #gets metadata for test set
    train.meta <- dx.meta[-testset,] #gets metadata for training set

    pvals <- c() #next 5 lines run post hoc tests to test for uneven split of demographic data
    pvals[1]<-chisq.test(rbind(table(test.meta$Smoke),table(train.meta$Smoke)))$p.value
    pvals[2]<-chisq.test(rbind(table(test.meta$Gender),table(train.meta$Gender)))$p.value
    pvals[3]<-chisq.test(rbind(table(test.meta$Diabetic),table(train.meta$Diabetic)))$p.value
    pvals[4]<-t.test(test.meta$Age, train.meta$Age)$p.value
    pvals[5]<-t.test(test.meta$BMI, train.meta$BMI)$p.value
    if(min(pvals)>0.05){ #if no significant differences between testing and training sets...
      print(522-seed) #show number of iters it took for successful split 
      return(list('training'=train.meta, 'testing'=test.meta)) #return list containing a table for each set
      continue<-TRUE # break out of loop
    }
    else{seed <- seed+1} # change seed and split again
  }
}

#run splitDx on each diagnosis bin
adv.adenoma <- splitDx('adv Adenoma') 
adenoma <- splitDx('Adenoma')
cancer<- splitDx('Cancer')
hr.norm <- splitDx('High Risk Normal')
normal <- splitDx('Normal')

#combine training sets, combine testing sets
train <- rbind(adv.adenoma$training, adenoma$training, cancer$training, hr.norm$training, normal$training)
test <- rbind(adv.adenoma$testing, adenoma$testing, cancer$testing, hr.norm$testing, normal$testing)

write.table(train, file='data/training.meta.txt', quote=F, sep='\t', row.names=F) #write training set metadata
write.table(train[,1], file='data/training.accnos', quote=F, row.names=F, col.names=F) #make training set accnos file
write.table(test, file='data/testing.meta.txt', quote=F, sep='\t', row.names=F) #write testing set metadata
write.table(test[,1], file='data/testing.accnos', quote=F, row.names=F, col.names=F) #make testing set accnos file
