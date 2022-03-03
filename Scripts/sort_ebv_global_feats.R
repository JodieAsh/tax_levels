
ebv <- readRDS("./feb_data/ebv_data.rds")
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

