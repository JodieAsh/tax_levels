# orgID <- 5833 # Plasmodium falciparum - Species 
# orgID <- 5820 # plasmodium - Genus
# orgID <- 422676 # Aconoidasida - Class
# orgID <- 5794 # Apicomplexa - Phylum
# orgID <- 2698737 # Sar - Clade
# orgID <- 2759 # Eukaryota - Superkingdom

plasmodium_falciparum <- read.csv("./jan_results/plasmodium_fal/train_plasmodium_falciparum_benchmarks.csv")
plasmodium <- read.csv("./jan_results/plasmodium_fal/plasmodium_benchmarks.csv")
aconoidasida <- read.csv("./jan_results/plasmodium_fal/aconoidasida_benchmarks.csv")
apicomplexa <- read.csv("./jan_results/plasmodium_fal/apicomplexa_benchmarks.csv")
sar <- read.csv("./jan_results/plasmodium_fal/sar_benchmarks.csv")

plasmodium_falciparum$Classifier[plasmodium_falciparum$Classifier=='RF'] <- 'plasmodium_falciparum_RF' 
plasmodium$Classifier[plasmodium$Classifier=='RF'] <- 'plasmodium_RF' 
aconoidasida$Classifier[aconoidasida$Classifier=='RF'] <- 'aconoidasida_RF' 
apicomplexa$Classifier[apicomplexa$Classifier=='RF'] <- 'apicomplexa_RF' 
sar$Classifier[sar$Classifier=='RF'] <- 'sar_RF' 

results_list <- list(plasmodium_falciparum, plasmodium, aconoidasida, apicomplexa, sar)
results_data <- data.frame()
for(item in results_list) {
  results_data <- rbind(results_data, item[2,])
}

# Need to order them by taxonomy level - BLUE points are models trained on full train and tested on e_coli test
library('ggplot2')
library('gridExtra')
results_data$Classifier <- factor(results_data$Classifier, levels = c('plasmodium_falciparum_RF', 'plasmodium_RF', 'aconoidasida_RF', 'apicomplexa_RF', 'sar_RF'))

test_acc <- ggplot(results_data, aes(x=Classifier, y=Accuracy.on.test)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
peptide_acc <- ggplot(results_data, aes(x=Classifier, y=Peptide.Accuracy)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level") 
tpr <- ggplot(results_data, aes(x=Classifier, y=True.Positive.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
tnr <- ggplot(results_data, aes(x=Classifier, y=True.Negative.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
mcc <- ggplot(results_data, aes(x=Classifier, y=MCC)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
precision <- ggplot(results_data, aes(x=Classifier, y=Precision)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
grid.arrange(test_acc, peptide_acc, tpr, tnr, mcc, precision, top="Plasmodium_falciparum")







e_coli <- read.csv("./jan_results/e_coli/undersampling/train_e_coli_benchmarks.csv")
enterobacteriaceae <- read.csv("./jan_results/e_coli/undersampling/enterobacteriaceae_benchmarks.csv")
enterobacterales <- read.csv("./jan_results/e_coli/undersampling/enterobacterales_benchmarks.csv")
proteobacteria <- read.csv("./jan_results/e_coli/undersampling/proteobacteria_benchmarks.csv")
bacteria <- read.csv("./jan_results/e_coli/undersampling/bacteria_benchmarks.csv")

e_coli$Classifier[e_coli$Classifier=='RF'] <- 'e_coli_RF'
enterobacteriaceae$Classifier[enterobacteriaceae$Classifier=='RF'] <- 'enterobacteriaceae_RF'
enterobacterales$Classifier[enterobacterales$Classifier=='RF'] <- 'enterobacterales_RF'
proteobacteria$Classifier[proteobacteria$Classifier=='RF'] <- 'proteobacteria_RF'
bacteria$Classifier[bacteria$Classifier=='RF'] <- 'bacteria_RF'

results_list <- list(e_coli, enterobacteriaceae, enterobacterales, proteobacteria, bacteria)
results_data <- data.frame()
for(item in results_list) {
  results_data <- rbind(results_data, item[2,])
}

# Need to order them by taxonomy level - RED points are models trained on undersampled train sets and tested on e_coli test
results_data$Classifier <- factor(results_data$Classifier, levels = c("e_coli_RF", "enterobacteriaceae_RF", "enterobacterales_RF", "proteobacteria_RF", "bacteria_RF"))

test_acc <- test_acc + geom_point(data=results_data, aes(x=Classifier, y=Accuracy.on.test), colour="red") + labs(x = "\n\nTaxonomy Level")
peptide_acc <- peptide_acc + geom_point(data=results_data, aes(x=Classifier, y=Peptide.Accuracy), colour="red") + labs(x = "\n\nTaxonomy Level")
tpr <- tpr + geom_point(data=results_data, aes(x=Classifier, y=True.Positive.Rate), colour="red") + labs(x = "\n\nTaxonomy Level")
tnr <- tnr + geom_point(data=results_data, aes(x=Classifier, y=True.Negative.Rate), colour="red") + labs(x = "\n\nTaxonomy Level")
mcc <- mcc + geom_point(data=results_data, aes(x=Classifier, y=MCC), colour="red") + labs(x = "\n\nTaxonomy Level")
precision <- precision + geom_point(data=results_data, aes(x=Classifier, y=Precision), colour="red") + labs(x = "\n\nTaxonomy Level")

grid.arrange(test_acc, peptide_acc, tpr, tnr, mcc, precision, top="E_coli")


e_coli <- read.csv("./jan_results/e_coli/train_test/train_e_coli_benchmarks.csv")
enterobacteriaceae <- read.csv("./jan_results/e_coli/train_test/train_enterobacteriaceae_benchmarks.csv")
enterobacterales <- read.csv("./jan_results/e_coli/train_test/train_enterobacterales_benchmarks.csv")
proteobacteria <- read.csv("./jan_results/e_coli/train_test/train_proteobacteria_benchmarks.csv")
bacteria <- read.csv("./jan_results/e_coli/train_test/train_bacteria_benchmarks.csv")

e_coli$Classifier[e_coli$Classifier=='RF'] <- 'e_coli_RF'
enterobacteriaceae$Classifier[enterobacteriaceae$Classifier=='RF'] <- 'enterobacteriaceae_RF'
enterobacterales$Classifier[enterobacterales$Classifier=='RF'] <- 'enterobacterales_RF'
proteobacteria$Classifier[proteobacteria$Classifier=='RF'] <- 'proteobacteria_RF'
bacteria$Classifier[bacteria$Classifier=='RF'] <- 'bacteria_RF'

results_list <- list(e_coli, enterobacteriaceae, enterobacterales, proteobacteria, bacteria)
results_data <- data.frame()
for(item in results_list) {
  results_data <- rbind(results_data, item[2,])
}

# Need to order them by taxonomy level - GREEN points are full training data sets tested on matching taxonomy level test sets test sets
results_data$Classifier <- factor(results_data$Classifier, levels = c("e_coli_RF", "enterobacteriaceae_RF", "enterobacterales_RF", "proteobacteria_RF", "bacteria_RF"))

test_acc <- test_acc + geom_point(data=results_data, aes(x=Classifier, y=Accuracy.on.test), colour="green") + labs(x = "\n\nTaxonomy Level")
peptide_acc <- peptide_acc + geom_point(data=results_data, aes(x=Classifier, y=Peptide.Accuracy), colour="green") + labs(x = "\n\nTaxonomy Level")
tpr <- tpr + geom_point(data=results_data, aes(x=Classifier, y=True.Positive.Rate), colour="green") + labs(x = "\n\nTaxonomy Level")
tnr <- tnr + geom_point(data=results_data, aes(x=Classifier, y=True.Negative.Rate), colour="green") + labs(x = "\n\nTaxonomy Level")
mcc <- mcc + geom_point(data=results_data, aes(x=Classifier, y=MCC), colour="green") + labs(x = "\n\nTaxonomy Level")
precision <- precision + geom_point(data=results_data, aes(x=Classifier, y=Precision), colour="green") + labs(x = "\n\nTaxonomy Level")

grid.arrange(test_acc, peptide_acc, tpr, tnr, mcc, precision, top="E_coli")