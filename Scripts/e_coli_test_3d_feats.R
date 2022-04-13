
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
  

}


