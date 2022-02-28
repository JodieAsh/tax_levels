# orgID <- 5833 # Plasmodium falciparum - Species 
# orgID <- 418107 # Plasmodium (Laverania) - Subgenus
# orgID <- 5820 # plasmodium - Genus
# orgID <- 1639119 # Plasmodiidae - Family 
# orgID <- 5819 # Haemosporida - Order
# orgID <- 422676 # Aconoidasida - Class
# orgID <- 5794 # Apicomplexa - Phylum
# orgID <- 33630 # Alveolata - Clade
# orgID <- 2698737 # Sar - Clade
# orgID <- 2759 # Eukaryota - Superkingdom

# Remove test proteins from all other data sets 
'%!in%' <- function(x,y)!('%in%'(x,y))

# orgID <- 5833 # Plasmodium falciparum - Species 
plasmodium_falciparum <- readRDS("./jan_data/plasmodium_fal_data/plasmodium_falciparum_data.rds")
plasmodium_falciparum <- plasmodium_falciparum$df
plasmodium_falciparum_test <- plasmodium_falciparum[plasmodium_falciparum$Info_split == "split_01_25", ]
plasmodium_falciparum_train <- plasmodium_falciparum[plasmodium_falciparum$Info_split == "split_02_75", ]
unique_id_plas_fal <- unique(plasmodium_falciparum$Info_PepID)
unique_id_train_plas_fal <- unique(plasmodium_falciparum_train$Info_PepID)
unique_id_test_plas_fal <- unique(plasmodium_falciparum_test$Info_PepID)
# write.csv(plasmodium_falciparum_train, "train_plasmodium_falciparum.csv")
# write.csv(plasmodium_falciparum_test, "test_plasmodium_falciparum.csv")

# orgID <- 5820 # plasmodium - Genus
plasmodium <- readRDS("./jan_data/plasmodium_fal_data/plasmodium_data.rds")
plasmodium <- plasmodium$df
plasmodium <- plasmodium[plasmodium$Info_PepID %!in% unique_id_plas_fal, ]
plas_fal_plasmodium <- rbind(plasmodium_falciparum_train, plasmodium)
write.csv(plas_fal_plasmodium, "plasmodium_falciparum_plasmodium.csv")

# orgID <- 422676 # Aconoidasida - Class
aconoidasida <- readRDS("./jan_data/plasmodium_fal_data/aconoidasida_data.rds")
aconoidasida <- aconoidasida$df
aconoidasida <- aconoidasida[aconoidasida$Info_PepID %!in% unique_id_plas_fal, ]
aconoidasida_plasmodium <- rbind(aconoidasida, plasmodium)
write.csv(aconoidasida_plasmodium, "aconoidasida_plasmodium.csv")

# orgID <- 5794 # Apicomplexa - Phylum
apicomplexa <- readRDS("./jan_data/plasmodium_fal_data/apicomplexa_data.rds")
apicomplexa <- apicomplexa$df
apicomplexa <- apicomplexa[apicomplexa$Info_PepID %!in% unique_id_plas_fal, ]

apicomplexa






# orgID <- 2698737 # Sar - Clade
sar <- readRDS("./jan_data/plasmodium_fal_data/sar_data.rds")
sar <- sar$df
sar <- sar[sar$Info_PepID %!in% unique_id_test_plas_fal, ]
write.csv(sar, "sar.csv")

# orgID <- 2759 # Eukaryota - Superkingdom
eukaryota <- readRDS("./jan_data/plasmodium_fal_data/eukaryota_data.rds")