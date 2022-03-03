# Read results 
# orgID <- 562 # Escherichia coli - Species 
library('ggplot2')
library('gridExtra')

local_e_coli <- read.csv("./march_results/e_coli/e_coli_global_train_local_benchmarks.csv")
both_e_coli <- read.csv("./march_results/e_coli/e_coli_global_train_both_benchmarks.csv")
global_e_coli <- read.csv("./march_results/e_coli/e_coli_global_train_global_benchmarks.csv")

local_e_coli$Classifier[local_e_coli$Classifier=='RF'] <- 'e_coli_local_RF'
both_e_coli$Classifier[both_e_coli$Classifier=='RF'] <- 'e_coli_all_RF'
global_e_coli$Classifier[global_e_coli$Classifier=='RF'] <- 'e_coli_global_RF'
# Rename MLP
local_e_coli$Classifier[local_e_coli$Classifier=='MLP'] <- 'e_coli_local_MLP'
both_e_coli$Classifier[both_e_coli$Classifier=='MLP'] <- 'e_coli_all_MLP'
global_e_coli$Classifier[global_e_coli$Classifier=='MLP'] <- 'e_coli_global_MLP'

e_coli_results_list <- list(local_e_coli, both_e_coli, global_e_coli)
e_coli_results_data <- data.frame()
for(item in e_coli_results_list) {
  e_coli_results_data <- rbind(e_coli_results_data, item[2,])
}
for(item in e_coli_results_list) {
  e_coli_results_data <- rbind(e_coli_results_data, item[3,])
}

e_coli <- function(e_coli_results_data) {
  e_coli_results_data$Classifier <- factor(e_coli_results_data$Classifier, levels = c("e_coli_local_RF", "e_coli_all_RF", "e_coli_global_RF"))
  
  test_acc <- ggplot(e_coli_results_data, aes(x=Classifier, y=Accuracy.on.test)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures")
  peptide_acc <- ggplot(e_coli_results_data, aes(x=Classifier, y=Peptide.Accuracy)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures") 
  tpr <- ggplot(e_coli_results_data, aes(x=Classifier, y=True.Positive.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures")
  tnr <- ggplot(e_coli_results_data, aes(x=Classifier, y=True.Negative.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures")
  mcc <- ggplot(e_coli_results_data, aes(x=Classifier, y=MCC)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures")
  precision <- ggplot(e_coli_results_data, aes(x=Classifier, y=Precision)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures")
  
  grid.arrange(test_acc, peptide_acc, tpr, tnr, mcc, precision, top="E_coli - Local and Global Features")
}



local_e_coli$Features <- "Local"
both_e_coli$Features <- "Both"
global_e_coli$Classifier[global_e_coli$Classifier=='RF'] <- 'e_coli_global_RF'
# Rename MLP
local_e_coli$Classifier[local_e_coli$Classifier=='MLP'] <- 'e_coli_local_MLP'
both_e_coli$Classifier[both_e_coli$Classifier=='MLP'] <- 'e_coli_all_MLP'
global_e_coli$Classifier[global_e_coli$Classifier=='MLP'] <- 'e_coli_global_MLP'

e_coli_results_list <- list(local_e_coli, both_e_coli, global_e_coli)
e_coli_results_data <- data.frame()
for(item in e_coli_results_list) {
  e_coli_results_data <- rbind(e_coli_results_data, item[2,])
}
for(item in e_coli_results_list) {
  e_coli_results_data <- rbind(e_coli_results_data, item[3,])
}

e_coli <- function(e_coli_results_data) {
  e_coli_results_data$Classifier <- factor(e_coli_results_data$Classifier, levels = c("e_coli_local_RF", "e_coli_all_RF", "e_coli_global_RF"))
  
  test_acc <- ggplot(e_coli_results_data, aes(x=Classifier, y=Accuracy.on.test)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures")
  peptide_acc <- ggplot(e_coli_results_data, aes(x=Classifier, y=Peptide.Accuracy)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures") 
  tpr <- ggplot(e_coli_results_data, aes(x=Classifier, y=True.Positive.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures")
  tnr <- ggplot(e_coli_results_data, aes(x=Classifier, y=True.Negative.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures")
  mcc <- ggplot(e_coli_results_data, aes(x=Classifier, y=MCC)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures")
  precision <- ggplot(e_coli_results_data, aes(x=Classifier, y=Precision)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures")
  
  grid.arrange(test_acc, peptide_acc, tpr, tnr, mcc, precision, top="E_coli - Local and Global Features")
}


























local_ebv <- read.csv("./march_results/ebv/ebv_global_train_local_benchmarks.csv")
both_ebv <- read.csv("./march_results/ebv/ebv_global_train_both_benchmarks.csv")
global_ebv <- read.csv("./march_results/ebv/ebv_global_train_global_benchmarks.csv")

local_ebv$Classifier[local_ebv$Classifier=='RF'] <- 'ebv_local_RF'
both_ebv$Classifier[both_ebv$Classifier=='RF'] <- 'ebv_all_RF'
global_ebv$Classifier[global_ebv$Classifier=='RF'] <- 'ebv_global_RF'

ebv_results_list <- list(local_ebv, both_ebv, global_ebv)
ebv_results_data <- data.frame()
for(item in ebv_results_list) {
  ebv_results_data <- rbind(ebv_results_data, item[2,])
}

ebv <- function(ebv_results_data) {
  ebv_results_data$Classifier <- factor(ebv_results_data$Classifier, levels = c("ebv_local_RF", "ebv_both_RF", "ebv_global_RF"))
  
  test_acc <- ggplot(ebv_results_data, aes(x=Classifier, y=Accuracy.on.test)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures")
  peptide_acc <- ggplot(ebv_results_data, aes(x=Classifier, y=Peptide.Accuracy)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures") 
  tpr <- ggplot(ebv_results_data, aes(x=Classifier, y=True.Positive.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures")
  tnr <- ggplot(ebv_results_data, aes(x=Classifier, y=True.Negative.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures")
  mcc <- ggplot(ebv_results_data, aes(x=Classifier, y=MCC)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures")
  precision <- ggplot(ebv_results_data, aes(x=Classifier, y=Precision)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures")
  
  grid.arrange(test_acc, peptide_acc, tpr, tnr, mcc, precision, top="EBV - Local and Global Features")
}









org_results_list <- list(local_e_coli, local_ebv)
org_results_data <- data.frame()
for(item in org_results_list) {
  org_results_data <- rbind(org_results_data, item[2,])
}

org <- function(org_results_data) {
  org_results_data$Classifier <- factor(org_results_data$Classifier, levels = c("e_coli_local_RF", "ebv_local_RF"))
  
  test_acc <- ggplot(org_results_data, aes(x=Classifier, y=Accuracy.on.test)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures")
  peptide_acc <- ggplot(org_results_data, aes(x=Classifier, y=Peptide.Accuracy)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures") 
  tpr <- ggplot(org_results_data, aes(x=Classifier, y=True.Positive.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures")
  tnr <- ggplot(org_results_data, aes(x=Classifier, y=True.Negative.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures")
  mcc <- ggplot(org_results_data, aes(x=Classifier, y=MCC)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures")
  precision <- ggplot(org_results_data, aes(x=Classifier, y=Precision)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nFeatures")
  
  grid.arrange(test_acc, peptide_acc, tpr, tnr, mcc, precision, top="Organism Specific - Local Features")
}




# Functions
e_coli(e_coli_results_data)
