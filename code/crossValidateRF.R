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
