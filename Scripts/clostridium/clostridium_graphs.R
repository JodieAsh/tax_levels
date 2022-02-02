# Splitting clostridium perf d into train and test

# clost_perf_d <- read.csv("./data/results/train_clostridium_perf_d_peptides_df_main_benchmarks.csv")
# clost_perf <- read.csv("./data/results/train_clostridium_perf_data_benchmarks.csv")
clostridium <- read.csv("./results/clostridium/train_clostridium_data_benchmarks.csv")
eubacteriales <- read.csv("./results/clostridium/train_eubacteriales_data_benchmarks.csv")
firmicutes <- read.csv("./results/clostridium/train_firmicutes_data_benchmarks.csv")
terrabacteria <- read.csv("./results/clostridium/train_terrabacteria_data_benchmarks.csv")
bacteria <- read.csv("./results/clostridium/train_bacteria_data_benchmarks.csv")

clostridium$Classifier[clostridium$Classifier=='RF'] <- 'clostridium_RF' 
eubacteriales$Classifier[eubacteriales$Classifier=='RF'] <- 'eubacteriales_RF'
firmicutes$Classifier[firmicutes$Classifier=='RF'] <- 'firmicutes_RF'
terrabacteria$Classifier[terrabacteria$Classifier=='RF'] <- 'terrabacteria_RF'
bacteria$Classifier[bacteria$Classifier=='RF'] <- 'bacteria_RF'

results_list <- list(clostridium, eubacteriales, firmicutes, terrabacteria, bacteria)
results_data <- data.frame()
for(item in results_list) {
  results_data <- rbind(results_data, item[2,])
}

# Need to order them by taxonomy level 
library('ggplot2')
library('gridExtra')
results_data$Classifier <- factor(results_data$Classifier, levels = c("clostridium_RF", "eubacteriales_RF", "clostridia_RF", "firmicutes_RF", "terrabacteria_RF", "bacteria_RF"))
test_acc <- ggplot(results_data, aes(x=Classifier, y=Accuracy.on.test)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
peptide_acc <- ggplot(results_data, aes(x=Classifier, y=Peptide.Accuracy)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level") 
tpr <- ggplot(results_data, aes(x=Classifier, y=True.Positive.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
tnr <- ggplot(results_data, aes(x=Classifier, y=True.Negative.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
mcc <- ggplot(results_data, aes(x=Classifier, y=MCC)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
precision <- ggplot(results_data, aes(x=Classifier, y=Precision)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")

grid.arrange(test_acc, peptide_acc, tpr, tnr, mcc, precision, top="Clostridium")


# Undersampling
clostridium <- read.csv("./results/clostridium/undersampling/train_clostridium_data_benchmarks.csv")
eubacteriales <- read.csv("./results/clostridium/undersampling/train_eubacteriales_data_benchmarks.csv")
clostridia <- read.csv("./results/clostridium/undersampling/train_clostridia_data_benchmarks.csv")
firmicutes <- read.csv("./results/clostridium/undersampling/train_firmicutes_data_benchmarks.csv")
terrabacteria <- read.csv("./results/clostridium/undersampling/train_terrabacteria_data_benchmarks.csv")
bacteria <- read.csv("./results/clostridium/undersampling/train_bacteria_data_benchmarks.csv")

clostridium$Classifier[clostridium$Classifier=='RF'] <- 'clostridium_RF' 
eubacteriales$Classifier[eubacteriales$Classifier=='RF'] <- 'eubacteriales_RF'
clostridia$Classifier[clostridia$Classifier=='RF'] <- 'clostridia_RF'
firmicutes$Classifier[firmicutes$Classifier=='RF'] <- 'firmicutes_RF'
terrabacteria$Classifier[terrabacteria$Classifier=='RF'] <- 'terrabacteria_RF'
bacteria$Classifier[bacteria$Classifier=='RF'] <- 'bacteria_RF'

sml_results_list <- list(clostridium, eubacteriales, clostridia, firmicutes, terrabacteria, bacteria)
sml_results_data <- data.frame()
for(item in sml_results_list) {
  sml_results_data <- rbind(sml_results_data, item[2,])
}

results_data$Classifier <- factor(results_data$Classifier, levels = c("clostridium_RF", "eubacteriales_RF", "clostridia_RF", "firmicutes_RF", "terrabacteria_RF", "bacteria_RF"))
sml_test_acc <- ggplot(results_data, aes(x=Classifier, y=Accuracy.on.test)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
sml_peptide_acc <- ggplot(results_data, aes(x=Classifier, y=Peptide.Accuracy)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level") 
sml_tpr <- ggplot(results_data, aes(x=Classifier, y=True.Positive.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
sml_tnr <- ggplot(results_data, aes(x=Classifier, y=True.Negative.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
sml_mcc <- ggplot(results_data, aes(x=Classifier, y=MCC)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
sml_precision <- ggplot(results_data, aes(x=Classifier, y=Precision)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")

grid.arrange(sml_test_acc, sml_peptide_acc, sml_tpr, sml_tnr, sml_mcc, sml_precision, top="Clostridium - Undersampling")

results_data$Classifier <- factor(results_data$Classifier, levels = c("clostridium_RF", "eubacteriales_RF", "clostridia_RF", "firmicutes_RF", "terrabacteria_RF", "bacteria_RF"))
test_acc <- test_acc + geom_point(data=sml_results_data, aes(x=Classifier, y=Accuracy.on.test), colour="red") 
peptide_acc <- peptide_acc + geom_point(data=sml_results_data, aes(x=Classifier, y=Peptide.Accuracy), colour="red")  
tpr <- tpr + geom_point(data=sml_results_data, aes(x=Classifier, y=True.Positive.Rate), colour="red")
tnr <- tnr + geom_point(data=sml_results_data, aes(x=Classifier, y=True.Negative.Rate), colour="red")
mcc <- mcc + geom_point(data=sml_results_data, aes(x=Classifier, y=MCC), colour="red")
precision <- precision + geom_point(data=sml_results_data, aes(x=Classifier, y=Precision), colour="red")
grid.arrange(test_acc, peptide_acc, tpr, tnr, mcc, precision, top="Clostridium")



