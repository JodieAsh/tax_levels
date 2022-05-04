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

# For every protein in train and test proteins, get the full protein sequence and check it for irregular AA's
AA_codes <- c('A', 'R', 'N', 'D', 'B', 'C', 'E', 'Q', 'Z', 'G', 'H', 'I', 'L', 'K', 'M', 'F', 'P', 'S', 'T', 'W', 'Y', 'V')

for(i in 1:nrow(test_e_coli_prot)){
  row <- test_e_coli_prot[i,]
  sequence <- row$TSeq_sequence
  # print(sequence)
  # for every letter in the sequence 
  sequence <- strsplit(sequence, "")
  for(letter in sequence){
    # print(letter)
    # check if the letter is a valid AA code 
    check <- letter %in% AA_codes
    if(FALSE %in% check){
      print("FALSE")
      print(sequence)
    }
  }
  
  
}
