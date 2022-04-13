# orgID <- 562 # Escherichia coli - Species 

# Remove test proteins from all other data sets 
'%!in%' <- function(x,y)!('%in%'(x,y))
# orgID <- 562 # Escherichia coli - Species 
e_coli <- readRDS("./march_2022_data/e_coli/e_coli_data.rds")
e_coli_prot <- e_coli$proteins
e_coli <- e_coli$df

e_coli_test <- e_coli[e_coli$Info_split == "split_01_25", ]
e_coli_train <- e_coli[e_coli$Info_split == "split_02_75", ]
# write.csv(e_coli_train, "train_e_coli_full.csv")
# write.csv(e_coli_test, "test_e_coli_full.csv")

# Unique Protein ID's
prot_id_e_coli <- unique(e_coli$Info_protein_id)
prot_id_train_e_coli <- unique(e_coli_train$Info_protein_id)
prot_id_test_e_coli <- unique(e_coli_test$Info_protein_id)

train_e_coli_prot <- e_coli_prot[e_coli_prot$UID %in% prot_id_train_e_coli, ]
test_e_coli_prot <- e_coli_prot[e_coli_prot$UID %in% prot_id_test_e_coli, ]


train_protein_sequences <- train_e_coli_prot[, c("UID", "TSeq_sequence")]
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


test_protein_sequences <- test_e_coli_prot[, c("UID", "TSeq_sequence")]
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

