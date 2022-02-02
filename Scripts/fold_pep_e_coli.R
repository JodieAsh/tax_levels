# orgID <- 562 # Escherichia coli - Species 
e_coli <- readRDS("./jan_data/e_coli_data/e_coli_data.rds")
e_coli <- e_coli$df
e_coli_test <- e_coli[e_coli$Info_split == "split_01_25", ]
e_coli_train <- e_coli[e_coli$Info_split == "split_02_75", ]

unique_id_e_coli <- unique(e_coli$Info_PepID)
unique_id_train_e_coli <- unique(e_coli_train$Info_PepID)
unique_id_test_e_coli <- unique(e_coli_test$Info_PepID)

e_coli_full <- readRDS("./jan_data/e_coli_data/e_coli_data.rds")
e_coli_peptides <- e_coli_full$peptides
train_e_coli_peptides <- e_coli_peptides[e_coli_peptides$Info_PepID %in% e_coli_train$Info_PepID, ]

pepid_sequence <- train_e_coli_peptides[, c("Info_PepID", "Info_peptide")]
pepid_sequence$Info_PepID <- paste(">", pepid_sequence$Info_PepID, sep="")

for(i in 1:nrow(pepid_sequence)){
  row <- pepid_sequence[i,]
  print(row)
  
  row_name <- row$Info_PepID
  row_name <- sub('>', '', row_name)
  row_name <- sub(':', '_', row_name)
  row_name <- paste(row_name, ".fasta", sep="")
  file <- file(row_name)
  writeLines(c(row$Info_PepID, row$Info_peptide), file)
  close(file)
  
}

