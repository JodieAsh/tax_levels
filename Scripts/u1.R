# Remove test proteins from all other data sets 
'%!in%' <- function(x,y)!('%in%'(x,y))

# orgID <- 562 # Escherichia coli - Species 
e_coli <- readRDS("./jan_data/e_coli_data/e_coli_data.rds")
e_coli_prot <- e_coli$proteins
e_coli_df <- e_coli$df

e_coli_test <- e_coli_df[e_coli_df$Info_split == "split_01_25", ]
e_coli_train <- e_coli_df[e_coli_df$Info_split == "split_02_75", ]

unique_id_e_coli <- unique(e_coli_df$Info_PepID)
unique_id_train_e_coli <- unique(e_coli_train$Info_PepID)
unique_id_test_e_coli <- unique(e_coli_test$Info_PepID)

# Change UID name to Info_protein_id # add global features to test set 
library(tidyverse)
e_coli_prot <- rename(e_coli_prot, Info_protein_id = UID)
e_coli_global <- merge(e_coli_df, e_coli_prot[,], by="Info_protein_id")
e_coli_global_train <- e_coli_global[e_coli_global$Info_PepID %!in% unique_id_test_e_coli, ]
e_coli_global_test <- e_coli_global[e_coli_global$Info_PepID %!in% unique_id_train_e_coli, ]

write.csv(e_coli_global_train, "e_coli_global_train.csv")
write.csv(e_coli_global_test, "e_coli_global_test.csv")


# library(dplyr)
# pep <- group_by(e_coli_test, e_coli_test$Info_PepID)
# tab <- summarise(pep, Class=first(Class))
# table(tab$Class) 
