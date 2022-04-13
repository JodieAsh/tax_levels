# orgID <- 562 # Escherichia coli - Species 
e_coli <- readRDS("./march_2022_data/e_coli/e_coli_data.rds")
e_coli_prot <- e_coli$proteins
e_coli_df <- e_coli$df
e_coli_test <- e_coli_df[e_coli_df$Info_split == "split_01_25", ]
e_coli_train <- e_coli_df[e_coli_df$Info_split == "split_02_75", ]

# List all the proteins in the e coli data set 
e_coli_proteins <- e_coli_prot$UID
# Split into train and test proteins
train_prot_id_e_coli <- unique(e_coli_train$Info_protein_id)
test_prot_id_e_coli <- unique(e_coli_test$Info_protein_id)
rm(e_coli_df, e_coli_test, e_coli_train)

# Seperate proteins into NCBI and Uni Prot proteins
NCBI_e_coli_prot <- e_coli_prot[e_coli_prot$DB == "NCBI protein",]
# ALL ecoli proteins are from NCBI


# list all the proteins that pdb files could be created for by AlphaFold
names <- list.files("./march_2022_data/af_e_coli_pdb")
desired_length <- length(names)
pdb_names <- rep(NA, desired_length)
i <- 1
for (fn in names) {
  split <- unlist(strsplit(fn, "_ranked"))
  print(split[[1]])
  pdb_names[i] <- split[[1]]
  i <- i + 1
}


test_names <- list.files("./march_2022_data/test_e_coli_pdb")
desired_length <- length(test_names)
test_pdb_names <- rep(NA, desired_length)
i <- 1
for (fn in test_names) {
  split <- unlist(strsplit(fn, "_ranked"))
  print(split[[1]])
  test_pdb_names[i] <- split[[1]]
  i <- i + 1
}

rm(i, fn, split, desired_length)


# How many train proteins are missing = 6 
missing_train <- length(train_prot_id_e_coli) - length(names)
# See which proteins are missing 
missing_train_prots <- setdiff(train_prot_id_e_coli, pdb_names)
rev <- setdiff(head(pdb_names,-1), train_prot_id_e_coli)


# NA on end of list

# How many test proteins are missing 
missing_test <- length(test_prot_id_e_coli) - length(test_names)
missing_test_prots <- setdiff(test_prot_id_e_coli, test_pdb_names)







test_e_coli_csv <- read.csv("./march_2022_data/test_e_coli_full.csv")
test_csv_names <- list.files("./march_2022_data/test_e_coli_csv")
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

# count <- 1
for (fn in test_csv_names) {
  path <- paste("./march_2022_data/test_e_coli_csv/", fn, sep="")
  df <- read.csv(path)
  # Rename columns so that they are the same before merge
  names(df)[names(df) == "Residue_depth"]  <- "Info_residue_depth"
  names(df)[names(df) == "Ca_depth"]  <- "Info_Ca_depth"
  names(df)[names(df) == "EXP_HSE_A_U"]  <- "Info_EXP_HSE_A_U"
  names(df)[names(df) == "EXP_HSE_A_D"]  <- "Info_EXP_HSE_A_D"
  names(df)[names(df) == "EXP_HSE_B_U"]  <- "Info_EXP_HSE_B_U"
  names(df)[names(df) == "EXP_HSE_B_D"]  <- "Info_EXP_HSE_B_D"
  names(df)[names(df) == "EXP_CN"]  <- "Info_EXP_CN"
  names(df)[names(df) == "Disordered_Res"]  <- "Info_disordered_Res"
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

  # test <- merge(test, df, by=c("Info_pos", "Info_protein_id"), all.x=TRUE)
  # test <- merge(test, df, by=c("Info_pos", "Info_protein_id"))
}


# fn <- "AAA23990.1_ranked_0.pdb.csv"
# df <- read.csv("./march_2022_data/test_e_coli_csv/AAA23990.1_ranked_0.pdb.csv")
#
# fn <- "AAA24736.1_ranked_0.pdb.csv"
# df <- read.csv("./march_2022_data/test_e_coli_csv/AAA24736.1_ranked_0.pdb.csv")
# # Rename columns so that they are the same before merge 
# names(df)[names(df) == "Residue_depth"]  <- "Info_residue_depth"
# names(df)[names(df) == "Ca_depth"]  <- "Info_Ca_depth"
# names(df)[names(df) == "EXP_HSE_A_U"]  <- "Info_EXP_HSE_A_U"
# names(df)[names(df) == "EXP_HSE_A_D"]  <- "Info_EXP_HSE_A_D"
# names(df)[names(df) == "EXP_HSE_B_U"]  <- "Info_EXP_HSE_B_U"
# names(df)[names(df) == "EXP_HSE_B_D"]  <- "Info_EXP_HSE_B_D"
# names(df)[names(df) == "EXP_CN"]  <- "Info_EXP_CN"
# names(df)[names(df) == "Disordered_Res"]  <- "Info_disordered_Res"
# # Rename columns so that they are the same before merge 
# names(df)[names(df) == "resseq"]  <- "Info_pos"
# 
# # Add info_protein_id column to data frame
# split <- unlist(strsplit(fn, "_ranked"))
# df$Info_protein_id <- split[[1]]
# df <- subset(df, select = -c(X))
# 
# 
# test3 <- merge(test2, df, by=c("Info_pos", "Info_protein_id"), all.x=TRUE)
# 
write.csv(test, "test_with_3d_feats.csv")
# write.csv(test2, "test2.csv")


# test <- merge(test, df, by=c("Info_pos", "Info_protein_id"), all.x=TRUE)
# test <- merge(test, df, by=c("Info_pos", "Info_protein_id"))
# y <- merge(test, df, by=c("Info_pos", "Info_protein_id"), all.x=TRUE)



