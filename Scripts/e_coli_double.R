# orgID <- 562 # Escherichia coli - Species 
# orgID <- 561 # Escherichia - Genus
# orgID <- 543 # Enterobacteriaceae - Family 
# orgID <- 91347 # Enterobacterales - Order
# orgID <- 1236 # Gammaproteobacteria - Class
# orgID <- 1224 # Proteobacteria - Phylum
# orgID <- 2 # Bacteria - Kingdom

# Remove test proteins from all other data sets 
'%!in%' <- function(x,y)!('%in%'(x,y))

# orgID <- 562 # Escherichia coli - Species 
e_coli <- readRDS("./jan_data/e_coli_data/e_coli_data.rds")
e_coli <- e_coli$df
e_coli_test <- e_coli[e_coli$Info_split == "split_01_25", ]
e_coli_train <- e_coli[e_coli$Info_split == "split_02_75", ]

# library(dplyr)
# pep <- group_by(e_coli_test, e_coli_test$Info_PepID)
# tab <- summarise(pep, Class=first(Class))
# table(tab$Class) 

unique_id_e_coli <- unique(e_coli$Info_PepID)
unique_id_train_e_coli <- unique(e_coli_train$Info_PepID)
unique_id_test_e_coli <- unique(e_coli_test$Info_PepID)
# write.csv(e_coli_train, "train_e_coli.csv")
# write.csv(e_coli_test, "test_e_coli.csv")

# orgID <- 561 # Escherichia - Genus
# Same as e.coli
# escherichia <- readRDS("./jan_data/escherichia_data.rds")
# escherichia <- escherichia$df

# orgID <- 543 # Enterobacteriaceae - Family 
enterobacteriaceae <- readRDS("./jan_data/e_coli_data/enterobacteriaceae_data.rds")
enterobacteriaceae <- enterobacteriaceae$df
# enterobacteriaceae <- enterobacteriaceae[enterobacteriaceae$Info_PepID %!in% unique_id_test_e_coli, ]
rm(e_coli_train, e_coli_test, unique_id_train_e_coli, unique_id_test_e_coli)

# Remove all e_coli peptides
enterobacteriaceae <- enterobacteriaceae[enterobacteriaceae$Info_PepID %!in% unique_id_e_coli, ]
# Randomly select 92 peptides ~ 1863 observations to add to e_coli_train data
pep_enterobacteriaceae <- unique(enterobacteriaceae$Info_PepID)
selected <- sample(pep_enterobacteriaceae, 50)
new_enterobacteriaceae <- enterobacteriaceae[enterobacteriaceae$Info_PepID %in% selected, ]
# Add observations to e coli data set
e_coli_enterobacteriacae <- rbind(e_coli_train, new_enterobacteriaceae)
write.csv(e_coli_enterobacteriacae, "e_coli_enterobacteriacae.csv")
# write.csv(enterobacteriaceae, "enterobacteriaceae.csv")
# pep_enterobacteriaceae <- unique(enterobacteriaceae$Info_PepID)
# enterobacteriaceae_test <- enterobacteriaceae[enterobacteriaceae$Info_split == "split_01_25", ]
# enterobacteriaceae_train <- enterobacteriaceae[enterobacteriaceae$Info_split == "split_02_75", ]
# write.csv(enterobacteriaceae_train, "train_enterobacteriaceae.csv")
# write.csv(enterobacteriaceae_test, "test_enterobacteriaceae.csv")

# orgID <- 91347 # Enterobacterales - Order
enterobacterales <- readRDS("./jan_data/e_coli_data/enterobacterales_data.rds")
enterobacterales <- enterobacterales$df
# enterobacterales <- enterobacterales[enterobacterales$Info_PepID %!in% unique_id_test_e_coli, ]
enterobacterales <- enterobacterales[enterobacterales$Info_PepID %!in% unique_id_e_coli, ]
pep_enterobacterales <- unique(enterobacterales$Info_PepID)
selected <- sample(pep_enterobacterales, 50)
new_enterobacterales <- enterobacterales[enterobacterales$Info_PepID %in% selected, ]
e_coli_enterobacterales <- rbind(e_coli_train, new_enterobacterales)
write.csv(e_coli_enterobacterales, "e_coli_enterobacterales.csv")

# write.csv(enterobacterales, "enterobacterales.csv")
# pep_enterobacterales <- unique(enterobacterales$Info_PepID)
# enterobacterales_test <- enterobacterales[enterobacterales$Info_split == "split_01_25", ]
# enterobacterales_train <- enterobacterales[enterobacterales$Info_split == "split_02_75", ]
# write.csv(enterobacterales_train, "train_enterobacterales.csv")
# write.csv(enterobacterales_test, "test_enterobacterales.csv")

# orgID <- 1236 # Gammaproteobacteria - Class
# Same as Enterobacterales
# gammaproteobacteria <- readRDS("./jan_data/gammaproteobacteria_data.rds")
# gammaproteobacteria <- gammaproteobacteria$df

# orgID <- 1224 # Proteobacteria - Phylum
proteobacteria <- readRDS("./jan_data/e_coli_data/proteobacteria_data.rds")
proteobacteria <- proteobacteria$df
#  <- proteobacteria[proteobacteria$Info_PepID %!in% unique_id_test_e_coli, ]
# write.csv(proteobacteria, "proteobacteria.csv")
# pep_proteobacteria <- unique(proteobacteria$Info_PepID)
# proteobacteria_test <- proteobacteria[proteobacteria$Info_split == "split_01_25", ]# 
# proteobacteria_train <- proteobacteria[proteobacteria$Info_split == "split_02_75", ]
# write.csv(proteobacteria_train, "train_proteobacteria.csv")
# write.csv(proteobacteria_test, "test_proteobacteria.csv")

proteobacteria <- proteobacteria[proteobacteria$Info_PepID %!in% unique_id_e_coli, ]
pep_proteobacteria <- unique(proteobacteria$Info_PepID)

selected <- sample(pep_proteobacteria, 50)
new_proteobacteria <- proteobacteria[proteobacteria$Info_PepID %in% selected, ]
e_coli_proteobacteria <- rbind(e_coli_train, new_proteobacteria)
write.csv(e_coli_proteobacteria, "e_coli_proteobacteria.csv")


# orgID <- 2 # Bacteria - Kingdom
bacteria <- readRDS("./jan_data/e_coli_data/bacteria_data.rds")
bacteria <- bacteria$df

bacteria <- bacteria[bacteria$Info_PepID %!in% unique_id_e_coli, ]
pep_bacteria <- unique(bacteria$Info_PepID)
selected <- sample(pep_bacteria, 65)
new_bacteria <- bacteria[bacteria$Info_PepID %in% selected, ]
e_coli_bacteria <- rbind(e_coli_train, new_bacteria)
write.csv(e_coli_bacteria, "e_coli_bacteria.csv")






# bacteria <- bacteria[bacteria$Info_PepID %!in% unique_id_test_e_coli, ]
# write.csv(bacteria, "bacteria.csv")
# pep_bacteria <- unique(bacteria$Info_PepID)
# bacteria_test <- bacteria[bacteria$Info_split == "split_01_25", ]
# bacteria_train <- bacteria[bacteria$Info_split == "split_02_75", ]
# write.csv(bacteria_train, "train_bacteria.csv")
# write.csv(bacteria_test, "test_bacteria.csv")



