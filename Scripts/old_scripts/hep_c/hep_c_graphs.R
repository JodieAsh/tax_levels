# orgID <- 11103 # Hepacivirus C
# orgID <- 11102 # Hepacivirus
# orgID <- 11050 # Flaviviridae
# orgID <- 2732545 # Amarillovirales
# orgID <- 2732462 # Flasuviricetes
# orgID <- 2732406 # Kitrinoviricota

# Load in data 
hep_c <- read.csv("./data/hep_c_data/results/regular/hep_c_train_benchmarks.csv")
hepacivirus <- read.csv("./data/hep_c_data/results/regular/hepacivirus_benchmarks.csv")
flaviviridae <- read.csv("./data/hep_c_data/results/regular/flaviviridae_benchmarks.csv")
amarillovirales <- read.csv("./data/hep_c_data/results/regular/amarillovirales_benchmarks.csv")
flasuviricetes <- read.csv("./data/hep_c_data/results/regular/flasuviricetes_benchmarks.csv")
kitrinoviricota <- read.csv("./data/hep_c_data/results/regular/kitrinoviricota_benchmarks.csv")

hep_c$Classifier[hep_c$Classifier=='RF'] <- 'hepacivirus_c_RF'
hepacivirus$Classifier[hepacivirus$Classifier=='RF'] <- 'hepacivirus_RF'
flaviviridae$Classifier[flaviviridae$Classifier=='RF'] <- 'flaviviridae_RF'
amarillovirales$Classifier[amarillovirales$Classifier=='RF'] <- 'amarillovirales_RF'
flasuviricetes$Classifier[flasuviricetes$Classifier=='RF'] <- 'flasuviricetes_RF'
kitrinoviricota$Classifier[kitrinoviricota$Classifier=='RF'] <- 'kitrinoviricota_RF'

results_list <- list(hep_c, hepacivirus, flaviviridae, amarillovirales, flasuviricetes, kitrinoviricota)
results_data <- data.frame()
for(item in results_list) {
  results_data <- rbind(results_data, item[2,])
}

# Need to order them by taxonomy level 
library('ggplot2')
library('gridExtra')
results_data$Classifier <- factor(results_data$Classifier, levels = c('hepacivirus_c_RF', 'hepacivirus_RF', 'flaviviridae_RF', 'amarillovirales_RF', 'flasuviricetes_RF', 'kitrinoviricota_RF'))
test_acc <- ggplot(results_data, aes(x=Classifier, y=Accuracy.on.test)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
peptide_acc <- ggplot(results_data, aes(x=Classifier, y=Peptide.Accuracy)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level") 
tpr <- ggplot(results_data, aes(x=Classifier, y=True.Positive.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
tnr <- ggplot(results_data, aes(x=Classifier, y=True.Negative.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
mcc <- ggplot(results_data, aes(x=Classifier, y=MCC)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
precision <- ggplot(results_data, aes(x=Classifier, y=Precision)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")

grid.arrange(test_acc, peptide_acc, tpr, tnr, mcc, precision, top="Hepacivirus C")


# Balanced Classifier - Load in data 
hep_c <- read.csv("./data/hep_c_data/results/bal_clf/hep_c_train_benchmarks.csv")
hepacivirus <- read.csv("./data/hep_c_data/results/bal_clf/hepacivirus_benchmarks.csv")
flaviviridae <- read.csv("./data/hep_c_data/results/bal_clf/flaviviridae_benchmarks.csv")
amarillovirales <- read.csv("./data/hep_c_data/results/bal_clf/amarillovirales_benchmarks.csv")
flasuviricetes <- read.csv("./data/hep_c_data/results/bal_clf/flasuviricetes_benchmarks.csv")
kitrinoviricota <- read.csv("./data/hep_c_data/results/bal_clf/kitrinoviricota_benchmarks.csv")

hep_c$Classifier[hep_c$Classifier=='RF'] <- 'hepacivirus_c_RF'
hepacivirus$Classifier[hepacivirus$Classifier=='RF'] <- 'hepacivirus_RF'
flaviviridae$Classifier[flaviviridae$Classifier=='RF'] <- 'flaviviridae_RF'
amarillovirales$Classifier[amarillovirales$Classifier=='RF'] <- 'amarillovirales_RF'
flasuviricetes$Classifier[flasuviricetes$Classifier=='RF'] <- 'flasuviricetes_RF'
kitrinoviricota$Classifier[kitrinoviricota$Classifier=='RF'] <- 'kitrinoviricota_RF'

bal_results_list <- list(hep_c, hepacivirus, flaviviridae, amarillovirales, flasuviricetes, kitrinoviricota)
bal_results_data <- data.frame()
for(item in bal_results_list) {
  bal_results_data <- rbind(bal_results_data, item[2,])
}

# Need to order them by taxonomy level 
bal_results_data$Classifier <- factor(bal_results_data$Classifier, levels = c('hepacivirus_c_RF', 'hepacivirus_RF', 'flaviviridae_RF', 'amarillovirales_RF', 'flasuviricetes_RF', 'kitrinoviricota_RF'))
bal_test_acc <- ggplot(bal_results_data, aes(x=Classifier, y=Accuracy.on.test)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
bal_peptide_acc <- ggplot(bal_results_data, aes(x=Classifier, y=Peptide.Accuracy)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level") 
bal_tpr <- ggplot(bal_results_data, aes(x=Classifier, y=True.Positive.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
bal_tnr <- ggplot(bal_results_data, aes(x=Classifier, y=True.Negative.Rate)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
bal_mcc <- ggplot(bal_results_data, aes(x=Classifier, y=MCC)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
bal_precision <- ggplot(bal_results_data, aes(x=Classifier, y=Precision)) + geom_point(colour="blue") + scale_x_discrete(guide = guide_axis(n.dodge = 3)) + labs(x = "\n\nTaxonomy Level")
grid.arrange(bal_test_acc, bal_peptide_acc, bal_tpr, bal_tnr, bal_mcc, bal_precision, top="Balanced Clf - Hepacivirus C")

# test_acc <- test_acc + geom_point(data=bal_results_data, aes(x=Classifier, y=Accuracy.on.test), colour="red") 
# peptide_acc <- peptide_acc + geom_point(data=bal_results_data, aes(x=Classifier, y=Peptide.Accuracy), colour="red")  
# tpr <- tpr + geom_point(data=bal_results_data, aes(x=Classifier, y=True.Positive.Rate), colour="red")
# tnr <- tnr + geom_point(data=bal_results_data, aes(x=Classifier, y=True.Negative.Rate), colour="red")
# mcc <- mcc + geom_point(data=bal_results_data, aes(x=Classifier, y=MCC), colour="red")
# precision <- precision + geom_point(data=bal_results_data, aes(x=Classifier, y=Precision), colour="red")
# grid.arrange(test_acc, peptide_acc, tpr, tnr, mcc, precision, top="Hepacivirus C")


