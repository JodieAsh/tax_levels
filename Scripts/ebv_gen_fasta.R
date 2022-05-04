

# Remove test proteins from all other data sets 
# '%!in%' <- function(x,y)!('%in%'(x,y))

ebv <- readRDS("./march_2022_data/ebv/ebv_data.rds")
ebv_prot <- ebv$proteins
ebv_df <- ebv$df

ebv_test <- ebv_df[ebv_df$Info_split == "split_01_25", ]
ebv_train <- ebv_df[ebv_df$Info_split == "split_02_75", ]
# write.csv(ebv_train, "train_ebv_full.csv")
# write.csv(ebv_test, "test_ebv_full.csv")

# Unique Protein ID's
prot_id_ebv <- unique(ebv_df$Info_protein_id)
prot_id_train_ebv <- unique(ebv_train$Info_protein_id)
prot_id_test_ebv <- unique(ebv_test$Info_protein_id)

train_ebv_prot <- ebv_prot[ebv_prot$UID %in% prot_id_train_ebv, ]
test_ebv_prot <- ebv_prot[ebv_prot$UID %in% prot_id_test_ebv, ]

train_protein_sequences <- train_ebv_prot[, c("UID", "TSeq_sequence")]
train_protein_sequences$UID <- paste(">", train_protein_sequences$UID, sep="")
for(i in 1:nrow(train_protein_sequences)){
  row <- train_protein_sequences[i,]
  print(row)
  
  row_name <- row$UID
  row_name <- sub('>', '', row_name)
  row_name <- sub(':', '_', row_name)
  row_name <- paste(row_name, ".fasta", sep="")
  file <- file(row_name)
  writeLines(c(row$UID, row$TSeq_sequence), file)
  close(file)
}


test_protein_sequences <- test_ebv_prot[, c("UID", "TSeq_sequence")]
test_protein_sequences$UID <- paste(">", test_protein_sequences$UID, sep="")
for(i in 1:nrow(test_protein_sequences)){
  row <- test_protein_sequences[i,]
  print(row)
  
  row_name <- row$UID
  row_name <- sub('>', '', row_name)
  row_name <- sub(':', '_', row_name)
  row_name <- paste(row_name, ".fasta", sep="")
  file <- file(row_name)
  writeLines(c(row$UID, row$TSeq_sequence), file)
  close(file)
}
