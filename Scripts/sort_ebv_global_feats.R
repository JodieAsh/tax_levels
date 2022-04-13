
ebv <- readRDS("./march_2022_data/ebv/ebv_data.rds")
ebv_df <- ebv$df
ebv_prot <- ebv$proteins

ebv_test <- ebv_df[ebv_df$Info_split == "split_01_25", ]
ebv_train <- ebv_df[ebv_df$Info_split == "split_02_75", ]

unique_id_ebv <- unique(ebv_df$Info_PepID)
unique_id_train_ebv <- unique(ebv_train$Info_PepID)
unique_id_test_ebv <- unique(ebv_test$Info_PepID)


# Change UID name to Info_protein_id # add global features to test set 
library(tidyverse)
ebv_prot <- rename(ebv_prot, Info_protein_id = UID)
ebv_global <- merge(ebv_df, ebv_prot[,], by="Info_protein_id")
ebv_global_test <- ebv_global[ebv_global$Info_PepID %in% unique_id_test_ebv, ]
ebv_global_train <- ebv_global[ebv_global$Info_PepID %in% unique_id_train_ebv, ]

write.csv(ebv_global_train, "ebv_global_train.csv")
write.csv(ebv_global_test, "ebv_global_test.csv")




pf <- readRDS("./march_2022_data/plasmodium_falciparum/plasmodium_falciparum_data.rds")
pf_df <- pf$df
pf_prot <- pf$proteins

pf_test <- pf_df[pf_df$Info_split == "split_01_25", ]
pf_train <- pf_df[pf_df$Info_split == "split_02_75", ]

unique_id_pf <- unique(pf_df$Info_PepID)
unique_id_train_pf <- unique(pf_train$Info_PepID)
unique_id_test_pf <- unique(pf_test$Info_PepID)


# Change UID name to Info_protein_id # add global features to test set 
library(tidyverse)
pf_prot <- rename(pf_prot, Info_protein_id = UID)
pf_global <- merge(pf_df, pf_prot[,], by="Info_protein_id")
pf_global_test <- pf_global[pf_global$Info_PepID %in% unique_id_test_pf, ]
pf_global_train <- pf_global[pf_global$Info_PepID %in% unique_id_train_pf, ]

write.csv(pf_global_train, "pf_global_train.csv")
write.csv(pf_global_test, "pf_global_test.csv")
