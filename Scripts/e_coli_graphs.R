# Read results 
# orgID <- 562 # Escherichia coli - Species 
# orgID <- 543 # Enterobacteriaceae - Family 
# orgID <- 91347 # Enterobacterales - Order
# orgID <- 1224 # Proteobacteria - Phylum
# orgID <- 2 # Bacteria - Kingdom
library('ggplot2')
library('gridExtra')

a_e_coli <- read.csv("./jan_results/e_coli/train_e_coli_benchmarks.csv")
a_enterobacteriaceae <- read.csv("./jan_results/e_coli/enterobacteriaceae_benchmarks.csv")
a_enterobacterales <- read.csv("./jan_results/e_coli/enterobacterales_benchmarks.csv")
a_proteobacteria <- read.csv("./jan_results/e_coli/proteobacteria_benchmarks.csv")
a_bacteria <- read.csv("./jan_results/e_coli/bacteria_benchmarks.csv")

a_e_coli$Classifier[a_e_coli$Classifier=='RF'] <- 'e_coli_RF'
a_enterobacteriaceae$Classifier[a_enterobacteriaceae$Classifier=='RF'] <- 'enterobacteriaceae_RF'
a_enterobacterales$Classifier[a_enterobacterales$Classifier=='RF'] <- 'enterobacterales_RF'
a_proteobacteria$Classifier[a_proteobacteria$Classifier=='RF'] <- 'proteobacteria_RF'
a_bacteria$Classifier[a_bacteria$Classifier=='RF'] <- 'bacteria_RF'

a_results_list <- list(a_e_coli, a_enterobacteriaceae, a_enterobacterales, a_proteobacteria, a_bacteria)
a_results_data <- data.frame()
for(item in a_results_list) {
  a_results_data <- rbind(a_results_data, item[2,])
}

full_train_and_test <- function(a_results_data) {
  # Need to order them by taxonomy level - BLUE points are models trained on full train and tested on e_coli test
  a_results_data$Classifier <- factor(a_results_data$Classifier, levels = c("e_coli_RF", "enterobacteriaceae_RF", "enterobacterales_RF", "proteobacteria_RF", "bacteria_RF"))
  
  test_acc <- ggplot(a_results_data, aes(x=Classifier, y=Accuracy.on.test)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  peptide_acc <- ggplot(a_results_data, aes(x=Classifier, y=Peptide.Accuracy)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level") 
  tpr <- ggplot(a_results_data, aes(x=Classifier, y=True.Positive.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  tnr <- ggplot(a_results_data, aes(x=Classifier, y=True.Negative.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  mcc <- ggplot(a_results_data, aes(x=Classifier, y=MCC)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  precision <- ggplot(a_results_data, aes(x=Classifier, y=Precision)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  
  grid.arrange(test_acc, peptide_acc, tpr, tnr, mcc, precision, top="E_coli - Full train and test")
}


b_e_coli <- read.csv("./jan_results/e_coli/undersampling/train_e_coli_benchmarks.csv")
b_enterobacteriaceae <- read.csv("./jan_results/e_coli/undersampling/enterobacteriaceae_benchmarks.csv")
b_enterobacterales <- read.csv("./jan_results/e_coli/undersampling/enterobacterales_benchmarks.csv")
b_proteobacteria <- read.csv("./jan_results/e_coli/undersampling/proteobacteria_benchmarks.csv")
b_bacteria <- read.csv("./jan_results/e_coli/undersampling/bacteria_benchmarks.csv")

b_e_coli$Classifier[b_e_coli$Classifier=='RF'] <- 'e_coli_RF'
b_enterobacteriaceae$Classifier[b_enterobacteriaceae$Classifier=='RF'] <- 'enterobacteriaceae_RF'
b_enterobacterales$Classifier[b_enterobacterales$Classifier=='RF'] <- 'enterobacterales_RF'
b_proteobacteria$Classifier[b_proteobacteria$Classifier=='RF'] <- 'proteobacteria_RF'
b_bacteria$Classifier[b_bacteria$Classifier=='RF'] <- 'bacteria_RF'

b_results_list <- list(b_e_coli, b_enterobacteriaceae, b_enterobacterales, b_proteobacteria, b_bacteria)
b_results_data <- data.frame()
for(item in b_results_list) {
  b_results_data <- rbind(b_results_data, item[2,])
}


full_train_plus_undersampled <- function(a_results_data, b_results_data) {
  a_results_data$Classifier <- factor(a_results_data$Classifier, levels = c("e_coli_RF", "enterobacteriaceae_RF", "enterobacterales_RF", "proteobacteria_RF", "bacteria_RF"))
  
  test_acc <- ggplot(a_results_data, aes(x=Classifier, y=Accuracy.on.test)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  peptide_acc <- ggplot(a_results_data, aes(x=Classifier, y=Peptide.Accuracy)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level") 
  tpr <- ggplot(a_results_data, aes(x=Classifier, y=True.Positive.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  tnr <- ggplot(a_results_data, aes(x=Classifier, y=True.Negative.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  mcc <- ggplot(a_results_data, aes(x=Classifier, y=MCC)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  precision <- ggplot(a_results_data, aes(x=Classifier, y=Precision)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  
  # # Need to order them by taxonomy level - RED points are models trained on undersampled train sets and tested on e_coli test
  b_results_data$Classifier <- factor(b_results_data$Classifier, levels = c("e_coli_RF", "enterobacteriaceae_RF", "enterobacterales_RF", "proteobacteria_RF", "bacteria_RF"))
  
  test_acc <- test_acc + geom_point(data=b_results_data, aes(x=Classifier, y=Accuracy.on.test), colour="red") + labs(x = "\n\nTaxonomy Level")
  peptide_acc <- peptide_acc + geom_point(data=b_results_data, aes(x=Classifier, y=Peptide.Accuracy), colour="red") + labs(x = "\n\nTaxonomy Level")
  tpr <- tpr + geom_point(data=b_results_data, aes(x=Classifier, y=True.Positive.Rate), colour="red") + labs(x = "\n\nTaxonomy Level")
  tnr <- tnr + geom_point(data=b_results_data, aes(x=Classifier, y=True.Negative.Rate), colour="red") + labs(x = "\n\nTaxonomy Level")
  mcc <- mcc + geom_point(data=b_results_data, aes(x=Classifier, y=MCC), colour="red") + labs(x = "\n\nTaxonomy Level")
  precision <- precision + geom_point(data=b_results_data, aes(x=Classifier, y=Precision), colour="red") + labs(x = "\n\nTaxonomy Level")
  
  grid.arrange(test_acc, peptide_acc, tpr, tnr, mcc, precision, top="E_coli + Full train plus undersampled")
}


c_e_coli <- read.csv("./jan_results/e_coli/train_test/train_e_coli_benchmarks.csv")
c_enterobacteriaceae <- read.csv("./jan_results/e_coli/train_test/train_enterobacteriaceae_benchmarks.csv")
c_enterobacterales <- read.csv("./jan_results/e_coli/train_test/train_enterobacterales_benchmarks.csv")
c_proteobacteria <- read.csv("./jan_results/e_coli/train_test/train_proteobacteria_benchmarks.csv")
c_bacteria <- read.csv("./jan_results/e_coli/train_test/train_bacteria_benchmarks.csv")

c_e_coli$Classifier[c_e_coli$Classifier=='RF'] <- 'e_coli_RF'
c_enterobacteriaceae$Classifier[c_enterobacteriaceae$Classifier=='RF'] <- 'enterobacteriaceae_RF'
c_enterobacterales$Classifier[c_enterobacterales$Classifier=='RF'] <- 'enterobacterales_RF'
c_proteobacteria$Classifier[c_proteobacteria$Classifier=='RF'] <- 'proteobacteria_RF'
c_bacteria$Classifier[c_bacteria$Classifier=='RF'] <- 'bacteria_RF'

c_results_list <- list(c_e_coli, c_enterobacteriaceae, c_enterobacterales, c_proteobacteria, c_bacteria)
c_results_data <- data.frame()
for(item in c_results_list) {
  c_results_data <- rbind(c_results_data, item[2,])
}


matching_tax_test_sets <- function(a_results_data, c_results_data) {
  a_results_data$Classifier <- factor(a_results_data$Classifier, levels = c("e_coli_RF", "enterobacteriaceae_RF", "enterobacterales_RF", "proteobacteria_RF", "bacteria_RF"))
  
  test_acc <- ggplot(a_results_data, aes(x=Classifier, y=Accuracy.on.test)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  peptide_acc <- ggplot(a_results_data, aes(x=Classifier, y=Peptide.Accuracy)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level") 
  tpr <- ggplot(a_results_data, aes(x=Classifier, y=True.Positive.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  tnr <- ggplot(a_results_data, aes(x=Classifier, y=True.Negative.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  mcc <- ggplot(a_results_data, aes(x=Classifier, y=MCC)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  precision <- ggplot(a_results_data, aes(x=Classifier, y=Precision)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  
  # Need to order them by taxonomy level - GREEN points are full training data sets tested on matching taxonomy level test sets test sets
  c_results_data$Classifier <- factor(c_results_data$Classifier, levels = c("e_coli_RF", "enterobacteriaceae_RF", "enterobacterales_RF", "proteobacteria_RF", "bacteria_RF"))
  
  test_acc <- test_acc + geom_point(data=c_results_data, aes(x=Classifier, y=Accuracy.on.test), colour="green") + labs(x = "\n\nTaxonomy Level")
  peptide_acc <- peptide_acc + geom_point(data=c_results_data, aes(x=Classifier, y=Peptide.Accuracy), colour="green") + labs(x = "\n\nTaxonomy Level")
  tpr <- tpr + geom_point(data=c_results_data, aes(x=Classifier, y=True.Positive.Rate), colour="green") + labs(x = "\n\nTaxonomy Level")
  tnr <- tnr + geom_point(data=c_results_data, aes(x=Classifier, y=True.Negative.Rate), colour="green") + labs(x = "\n\nTaxonomy Level")
  mcc <- mcc + geom_point(data=c_results_data, aes(x=Classifier, y=MCC), colour="green") + labs(x = "\n\nTaxonomy Level")
  precision <- precision + geom_point(data=c_results_data, aes(x=Classifier, y=Precision), colour="green") + labs(x = "\n\nTaxonomy Level")
  
  grid.arrange(test_acc, peptide_acc, tpr, tnr, mcc, precision, top="E_coli test set +  individual taxonomic test sets")
}


# double data sets 
d_e_coli <- read.csv("./jan_results/e_coli/double/train_e_coli_benchmarks.csv")
d_enterobacteriaceae <- read.csv("./jan_results/e_coli/double/e_coli_enterobacteriaceae_benchmarks.csv")
d_enterobacterales <- read.csv("./jan_results/e_coli/double/e_coli_enterobacterales_benchmarks.csv")
d_proteobacteria <- read.csv("./jan_results/e_coli/double/e_coli_proteobacteria_benchmarks.csv")
d_bacteria <- read.csv("./jan_results/e_coli/double/e_coli_bacteria_benchmarks.csv")

d_e_coli$Classifier[d_e_coli$Classifier=='RF'] <- 'e_coli_RF'
d_enterobacteriaceae$Classifier[d_enterobacteriaceae$Classifier=='RF'] <- 'enterobacteriaceae_RF'
d_enterobacterales$Classifier[d_enterobacterales$Classifier=='RF'] <- 'enterobacterales_RF'
d_proteobacteria$Classifier[d_proteobacteria$Classifier=='RF'] <- 'proteobacteria_RF'
d_bacteria$Classifier[d_bacteria$Classifier=='RF'] <- 'bacteria_RF'

d_results_list <- list(d_e_coli, d_enterobacteriaceae, d_enterobacterales, d_proteobacteria, d_bacteria)
d_results_data <- data.frame()
for(item in d_results_list) {
  d_results_data <- rbind(d_results_data, item[2,])
}


double_data_sets <- function(d_results_data) {
  d_results_data$Classifier <- factor(d_results_data$Classifier, levels = c("e_coli_RF", "enterobacteriaceae_RF", "enterobacterales_RF", "proteobacteria_RF", "bacteria_RF"))
  
  test_acc <- ggplot(d_results_data, aes(x=Classifier, y=Accuracy.on.test)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  peptide_acc <- ggplot(d_results_data, aes(x=Classifier, y=Peptide.Accuracy)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level") 
  tpr <- ggplot(d_results_data, aes(x=Classifier, y=True.Positive.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  tnr <- ggplot(d_results_data, aes(x=Classifier, y=True.Negative.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  mcc <- ggplot(d_results_data, aes(x=Classifier, y=MCC)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  precision <- ggplot(d_results_data, aes(x=Classifier, y=Precision)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  
  grid.arrange(test_acc, peptide_acc, tpr, tnr, mcc, precision, top="E_coli double data sets")
}


double_data_sets_plus_full_train <- function(a_results_data, d_results_data) {
  a_results_data$Classifier <- factor(a_results_data$Classifier, levels = c("e_coli_RF", "enterobacteriaceae_RF", "enterobacterales_RF", "proteobacteria_RF", "bacteria_RF"))
  
  test_acc <- ggplot(a_results_data, aes(x=Classifier, y=Accuracy.on.test)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  peptide_acc <- ggplot(a_results_data, aes(x=Classifier, y=Peptide.Accuracy)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level") 
  tpr <- ggplot(a_results_data, aes(x=Classifier, y=True.Positive.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  tnr <- ggplot(a_results_data, aes(x=Classifier, y=True.Negative.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  mcc <- ggplot(a_results_data, aes(x=Classifier, y=MCC)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  precision <- ggplot(a_results_data, aes(x=Classifier, y=Precision)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  
  # Need to order them by taxonomy level - red points are double training data sets tested on e coli test set
  d_results_data$Classifier <- factor(d_results_data$Classifier, levels = c("e_coli_RF", "enterobacteriaceae_RF", "enterobacterales_RF", "proteobacteria_RF", "bacteria_RF"))
  
  test_acc <- test_acc + geom_point(data=d_results_data, aes(x=Classifier, y=Accuracy.on.test), colour="red") + labs(x = "\n\nTaxonomy Level")
  peptide_acc <- peptide_acc + geom_point(data=d_results_data, aes(x=Classifier, y=Peptide.Accuracy), colour="red") + labs(x = "\n\nTaxonomy Level")
  tpr <- tpr + geom_point(data=d_results_data, aes(x=Classifier, y=True.Positive.Rate), colour="red") + labs(x = "\n\nTaxonomy Level")
  tnr <- tnr + geom_point(data=d_results_data, aes(x=Classifier, y=True.Negative.Rate), colour="red") + labs(x = "\n\nTaxonomy Level")
  mcc <- mcc + geom_point(data=d_results_data, aes(x=Classifier, y=MCC), colour="red") + labs(x = "\n\nTaxonomy Level")
  precision <- precision + geom_point(data=d_results_data, aes(x=Classifier, y=Precision), colour="red") + labs(x = "\n\nTaxonomy Level")
  
  grid.arrange(test_acc, peptide_acc, tpr, tnr, mcc, precision, top="E_coli double data sets")
}



e_e_coli <- read.csv("./jan_results/e_coli/new/train_e_coli_benchmarks.csv")
e_enterobacteriaceae <- read.csv("./jan_results/e_coli/new/enterobacteriaceae_benchmarks.csv")
e_enterobacterales <- read.csv("./jan_results/e_coli/new/enterobacterales_benchmarks.csv")
e_proteobacteria <- read.csv("./jan_results/e_coli/new/proteobacteria_benchmarks.csv")
e_bacteria <- read.csv("./jan_results/e_coli/new/bacteria_benchmarks.csv")

e_e_coli$Classifier[e_e_coli$Classifier=='RF'] <- 'e_coli_RF'
e_enterobacteriaceae$Classifier[e_enterobacteriaceae$Classifier=='RF'] <- 'enterobacteriaceae_RF'
e_enterobacterales$Classifier[e_enterobacterales$Classifier=='RF'] <- 'enterobacterales_RF'
e_proteobacteria$Classifier[e_proteobacteria$Classifier=='RF'] <- 'proteobacteria_RF'
e_bacteria$Classifier[e_bacteria$Classifier=='RF'] <- 'bacteria_RF'

e_results_list <- list(e_e_coli, e_enterobacteriaceae, e_enterobacterales, e_proteobacteria, e_bacteria)
e_results_data <- data.frame()
for(item in e_results_list) {
  e_results_data <- rbind(e_results_data, item[2,])
}


full_train_plus_new <- function(a_results_data, e_results_data) {
  a_results_data$Classifier <- factor(a_results_data$Classifier, levels = c("e_coli_RF", "enterobacteriaceae_RF", "enterobacterales_RF", "proteobacteria_RF", "bacteria_RF"))
  
  test_acc <- ggplot(a_results_data, aes(x=Classifier, y=Accuracy.on.test)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  peptide_acc <- ggplot(a_results_data, aes(x=Classifier, y=Peptide.Accuracy)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level") 
  tpr <- ggplot(a_results_data, aes(x=Classifier, y=True.Positive.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  tnr <- ggplot(a_results_data, aes(x=Classifier, y=True.Negative.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  mcc <- ggplot(a_results_data, aes(x=Classifier, y=MCC)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  precision <- ggplot(a_results_data, aes(x=Classifier, y=Precision)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
  
  # # Need to order them by taxonomy level - RED points are models trained on undersampled train sets and tested on e_coli test
  e_results_data$Classifier <- factor(e_results_data$Classifier, levels = c("e_coli_RF", "enterobacteriaceae_RF", "enterobacterales_RF", "proteobacteria_RF", "bacteria_RF"))
  
  test_acc <- test_acc + geom_point(data=e_results_data, aes(x=Classifier, y=Accuracy.on.test), colour="red") + labs(x = "\n\nTaxonomy Level")
  peptide_acc <- peptide_acc + geom_point(data=e_results_data, aes(x=Classifier, y=Peptide.Accuracy), colour="red") + labs(x = "\n\nTaxonomy Level")
  tpr <- tpr + geom_point(data=e_results_data, aes(x=Classifier, y=True.Positive.Rate), colour="red") + labs(x = "\n\nTaxonomy Level")
  tnr <- tnr + geom_point(data=e_results_data, aes(x=Classifier, y=True.Negative.Rate), colour="red") + labs(x = "\n\nTaxonomy Level")
  mcc <- mcc + geom_point(data=e_results_data, aes(x=Classifier, y=MCC), colour="red") + labs(x = "\n\nTaxonomy Level")
  precision <- precision + geom_point(data=e_results_data, aes(x=Classifier, y=Precision), colour="red") + labs(x = "\n\nTaxonomy Level")
  
  grid.arrange(test_acc, peptide_acc, tpr, tnr, mcc, precision, top="E_coli + Full train plus undersampled")
}




# todo add keys to graphs 
# Full train and test
full_train_and_test(a_results_data)
# full_train_plus_undersampled(a_results_data, b_results_data)
# matching_tax_test_sets(a_results_data, c_results_data)
# double_data_sets(d_results_data)
# double_data_sets_plus_full_train(a_results_data, d_results_data)

full_train_plus_new(a_results_data, e_results_data)

