
train_e_coli_csv <- read.csv("./may_2022/train_e_coli_full.csv")
train_csv_names <- list.files("./may_2022/train_e_coli_pdb_csv")

desired_length <- length(train_csv_names)
clean_train_csv_names <- rep(NA, desired_length)
i <- 1
for (fn in train_csv_names) {
  split <- unlist(strsplit(fn, "_ranked"))
  print(split[[1]])
  clean_train_csv_names[i] <- split[[1]]
  i <- i + 1
}

rm(i, fn, split, desired_length)

train_csv_ids <- train_e_coli_csv$Info_protein_id
train_csv_ids <- unique(train_csv_ids)
missing_train_csv <- setdiff(train_csv_ids, clean_train_csv_names)

# Remove missing proteins from og csv
train_csv <- train_e_coli_csv[train_e_coli_csv$Info_protein_id %in% clean_train_csv_names, ]
train <- train_csv
train <- subset(train, select = -c(X))
# write.csv(train, "j_train_e_coli.csv", row.names=FALSE)

# count <- 1
for (fn in train_csv_names) {
  # fn <- train_csv_names[1]
  path <- paste("./may_2022/train_e_coli_pdb_csv/", fn, sep="")
  df <- read.csv(path)
  # Rename columns so that they are the same before merge
  names(df)[names(df) == "Residue_depth"]  <- "feat_residue_depth"
  names(df)[names(df) == "Ca_depth"]  <- "feat_Ca_depth"
  names(df)[names(df) == "EXP_HSE_A_U"]  <- "feat_EXP_HSE_A_U"
  names(df)[names(df) == "EXP_HSE_A_D"]  <- "feat_EXP_HSE_A_D"
  names(df)[names(df) == "EXP_HSE_B_U"]  <- "feat_EXP_HSE_B_U"
  names(df)[names(df) == "EXP_HSE_B_D"]  <- "feat_EXP_HSE_B_D"
  names(df)[names(df) == "EXP_CN"]  <- "feat_EXP_CN"
  names(df)[names(df) == "Disordered_Res"]  <- "feat_disordered_Res"
  # Rename columns so that they are the same before merge
  names(df)[names(df) == "resseq"]  <- "Info_pos"
  
  # Add info_protein_id column to data frame
  split <- unlist(strsplit(fn, "_ranked"))
  df$Info_protein_id <- split[[1]]
  df <- subset(df, select = -c(X))
  
  commonNames <- names(train)[which(colnames(train) %in% colnames(df))]
  commonNames <- commonNames[commonNames != "Info_pos"]
  commonNames <- commonNames[commonNames != "Info_protein_id"]
  
  # pre_merg <- train
  train <- merge(train, df, by=c("Info_pos", "Info_protein_id"), all.x=TRUE)
  
  for(i in commonNames){
    left <- paste(i, ".x", sep="")
    right <- paste(i, ".y", sep="")
    train[is.na(train[left]),left] <- train[is.na(train[left]),right]
    train[right]<- NULL
    colnames(train)[colnames(train) == left] <- i
  }
  
}
rm(commonNames, fn, i, left, path, right, split)
# write.csv(train, "j_train_e_coli_with_3d_feats.csv", row.names=FALSE)




test_e_coli_csv <- read.csv("./may_2022/test_e_coli_full.csv")
test_csv_names <- list.files("./may_2022/test_e_coli_pdb_csv")
desired_length <- length(test_csv_names)
clean_test_csv_names <- rep(NA, desired_length)
i <- 1
for (fn in test_csv_names) {
  split <- unlist(strsplit(fn, "_ranked"))
  print(split[[1]])
  clean_test_csv_names[i] <- split[[1]]
  i <- i + 1
}
rm(i, fn, split, desired_length)

test_csv_ids <- test_e_coli_csv$Info_protein_id
test_csv_ids <- unique(test_csv_ids)
missing_test_csv <- setdiff(test_csv_ids, clean_test_csv_names)

# Remove missing proteins from og csv
test_csv <- test_e_coli_csv[test_e_coli_csv$Info_protein_id %in% clean_test_csv_names, ]
test <- test_csv
test <- subset(test, select = -c(X))
# write.csv(test, "j_test_e_coli.csv", row.names=FALSE)

# count <- 1
for (fn in test_csv_names) {
  path <- paste("./may_2022/test_e_coli_pdb_csv/", fn, sep="")
  df <- read.csv(path)
  # Rename columns so that they are the same before merge
  names(df)[names(df) == "Residue_depth"]  <- "feat_residue_depth"
  names(df)[names(df) == "Ca_depth"]  <- "feat_Ca_depth"
  names(df)[names(df) == "EXP_HSE_A_U"]  <- "feat_EXP_HSE_A_U"
  names(df)[names(df) == "EXP_HSE_A_D"]  <- "feat_EXP_HSE_A_D"
  names(df)[names(df) == "EXP_HSE_B_U"]  <- "feat_EXP_HSE_B_U"
  names(df)[names(df) == "EXP_HSE_B_D"]  <- "feat_EXP_HSE_B_D"
  names(df)[names(df) == "EXP_CN"]  <- "feat_EXP_CN"
  names(df)[names(df) == "Disordered_Res"]  <- "feat_disordered_Res"
  # Rename columns so that they are the same before merge
  names(df)[names(df) == "resseq"]  <- "Info_pos"
  
  # Add info_protein_id column to data frame
  split <- unlist(strsplit(fn, "_ranked"))
  df$Info_protein_id <- split[[1]]
  df <- subset(df, select = -c(X))
  
  commonNames <- names(test)[which(colnames(test) %in% colnames(df))]
  commonNames <- commonNames[commonNames != "Info_pos"]
  commonNames <- commonNames[commonNames != "Info_protein_id"]
  
  # pre_merg <- test
  test <- merge(test, df, by=c("Info_pos", "Info_protein_id"), all.x=TRUE)
  
  for(i in commonNames){
    left <- paste(i, ".x", sep="")
    right <- paste(i, ".y", sep="")
    test[is.na(test[left]),left] <- test[is.na(test[left]),right]
    test[right]<- NULL
    colnames(test)[colnames(test) == left] <- i
  }
  
}
rm(commonNames, fn, i, left, path, right, split)
write.csv(test, "j_test_e_coli_with_3d_feats.csv", row.names=FALSE)
