# 0. generate RF based on AUC_RF
#     - get features
#     - get RF / AUC
# 1. Trim shared file to those features
#
# 2. split shared shared by defined percentage (e.g. 90%)
# 3. split metadata by that grouping
# 4. train random forest and save model
# 5. run model on testing dataset
#     - save AUC
#     - save ROC curve
# 6. GoTo #2 N times
#
# 7. Generate distribution of AUCs and ROC curves
#
# need...
#   * shared file
#   * metadata file
#
# output
#   * Full RF object
#   * Confidence interval on AUC and RF

percent_training <- 0.8

deps = c("pROC","randomForest", "AUCRF");
for (dep in deps){
  if (dep %in% installed.packages()[,"Package"] == FALSE){
    install.packages(as.character(dep), quiet=TRUE);
  }
  library(dep, verbose=FALSE, character.only=TRUE)
}

set.seed("20150417")
metadata <- read.delim('data/process/metadata.tsv', header=T, sep='\t')
shared <- read.delim('data/process/glne007.final.an.unique_list.0.03.subsample.0.03.filter.shared', header=T, sep='\t', row.names=2)

#pull out the cancer and normal samples
cancer_normal <- metadata$dx == "normal" | metadata$dx == "cancer"
cancer_normal_dx <- factor(metadata[cancer_normal,"dx"], levels=c("normal", "cancer"))
levels(cancer_normal_dx)[levels(cancer_normal_dx)=="normal"] <- 0
levels(cancer_normal_dx)[levels(cancer_normal_dx)=="cancer"] <- 1

cancer_normal_shared <- shared[cancer_normal,]
cancer_normal_shared <- cancer_normal_shared[, grepl("^Otu", colnames(cancer_normal_shared))]
cancer_normal_shared <- cancer_normal_shared[,apply(cancer_normal_shared, 2, sum) > 0]

cancer_normal_data <- cbind(dx=cancer_normal_dx, cancer_normal_shared)
cancer_normal_full_rf <- AUCRF(dx ~ ., data=cancer_normal_data)

optimum_features <- cancer_normal_full_rf$Xopt
optimum_shared <- cancer_normal_data[,c("dx", optimum_features)]

optimum_shared_rf <- randomForest(dx ~ ., data=cancer_normal_data, ntrees=1e4)
optimum_shared_rf_fit <- predict(optimum_shared_rf, type="prob")
optimum_shared_rf_auc <- roc(cancer_normal_data$dx ~ optimum_shared_rf_fit[,1], levels=c(0,1))$auc

train_test <- function(shared_dx_data, percentage){
    n_samples <- nrow(shared_dx_data)
    sample_vector <- 1:n_samples
    random_sampling <- sample(sample_vector)

    training <- random_sampling[random_sampling < floor(percentage*n_samples)]
    testing <- random_sampling[random_sampling >= floor(percentage*n_samples)]

    training_data <- shared_dx_data[training,]
    testing_data <- shared_dx_data[testing,]

    training_model <- randomForest(dx~., data=training_data, ntree=1e4)
    #training_model$err.rate[1e4,"OOB"]
    test <- predict(training_model, testing_data, type='prob')
    roc(testing_data$dx ~ test[,1], levels=c(0,1))$auc
}

auc <- numeric()
for(percent in seq(0.05, 0.95, 0.1)){
auc[percent*10] <- median(replicate(10, train_test(shared_dx_data=optimum_shared, percentage=percent)))
}
