meta <- read.delim('data/metadata.tsv', sep='\t', header=T)

splitDx <- function(dx){
  dx.meta<- meta[meta$Dx_Bin==dx,]
  seed<-521
  continue <- FALSE
  while(continue==FALSE){
    set.seed(seed)
    testset <- sample(1:nrow(dx.meta), trunc(nrow(dx.meta)/3))
    test.meta <- dx.meta[testset,]
    train.meta <- dx.meta[-testset,]

    pvals <- c()
    pvals[1]<-chisq.test(rbind(table(test.meta$Smoke),table(train.meta$Smoke)))$p.value
    pvals[2]<-chisq.test(rbind(table(test.meta$Gender),table(train.meta$Gender)))$p.value
    pvals[3]<-chisq.test(rbind(table(test.meta$Diabetic),table(train.meta$Diabetic)))$p.value
    pvals[4]<-t.test(test.meta$Age, train.meta$Age)$p.value
    pvals[5]<-t.test(test.meta$BMI, train.meta$BMI)$p.value
    if(min(pvals)>0.1){
      print(seed)
      return(list('training'=train.meta, 'testing'=test.meta))
      continue<-TRUE
    }
    else{seed <- seed+1}
  }
}

adv.adenoma <- splitDx('adv Adenoma')
adenoma <- splitDx('Adenoma')
cancer<- splitDx('Cancer')
hr.norm <- splitDx('High Risk Normal')
normal <- splitDx('Normal')

train <- rbind(adv.adenoma$training, adenoma$training, cancer$training, hr.norm$training, normal$training)
test <- rbind(adv.adenoma$testing, adenoma$testing, cancer$testing, hr.norm$testing, normal$testing)

write.table(train, file='data/training.meta.txt', quote=F, sep='\t', row.names=F)
write.table(train[,1], file='data/training.accnos', quote=F, row.names=F, col.names=F)
write.table(test, file='data/testing.meta.txt', quote=F, sep='\t', row.names=F)
write.table(test[,1], file='data/testing.accnos', quote=F, row.names=F, col.names=F)
