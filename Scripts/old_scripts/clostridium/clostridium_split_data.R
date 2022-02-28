# orgID <- 107819 # Clostridium perfringens D
# orgID <- 1502 # Clostridium perfringens

orgID <- 1485 # Clostridium 
# orgID <- 31979 # Clostridiaceae
# orgID <- 186802 # Eubacteriales
# orgID <- 186801 # Clostridia
# orgID <- 1239 # Firmicutes
# orgID <- 1783272 # Terrabacteria Group
# orgID <- 2 # Bacteria 

# Remove test proteins from all other data sets 
'%!in%' <- function(x,y)!('%in%'(x,y))

clostridium <- readRDS("./data/clostridium_files/clostridium_data.rds")
clostridium <- clostridium$df
test_clostridium <- clostridium[clostridium$Info_split == "split_01_25", ]
unique_id_clostridium <- unique(clostridium$Info_PepID)
unique_test_clostridium <- unique(test_clostridium$Info_PepID)
train_clostridium <- clostridium[clostridium$Info_PepID %!in% unique_test_clostridium, ]
unique_id_train_clostridium <- unique(train_clostridium$Info_PepID)

write.csv(train_clostridium, "train_clostridium_data.csv")
write.csv(test_clostridium, "test_clostridium_data.csv")

# Exactly the same as clostridium
# clostridiaceae <- readRDS("./data/clostridium_files/clostridiaceae_data.rds")
# clostridiaceae <- clostridiaceae$df
# clostridiaceae <- clostridiaceae[clostridiaceae$Info_PepID %!in% unique_test_clostridium, ]
# write.csv(clostridiaceae, "train_clostridiaceae_data.csv")

eubacteriales <- readRDS("./data/clostridium_files/eubacteriales_data.rds")
eubacteriales <- eubacteriales$df
eubacteriales <- eubacteriales[eubacteriales$Info_PepID %!in% unique_test_clostridium, ]
write.csv(eubacteriales, "train_eubacteriales_data.csv")
# pep_eubacteriales <- unique(eubacteriales$Info_PepID)

# Same as eubac
# clostridia <- readRDS("./data/clostridium_files/clostridia_data.rds")
# clostridia <- clostridia$df
# clostridia <- clostridia[clostridia$Info_PepID %!in% unique_test_clostridium, ]
# write.csv(clostridia, "train_clostridia_data.csv")
# pep_clostridia <- unique(clostridia$Info_PepID)

firmicutes <- readRDS("./data/clostridium_files/firmicutes_data.rds")
firmicutes <- firmicutes$df
firmicutes <- firmicutes[firmicutes$Info_PepID %!in% unique_test_clostridium, ]
write.csv(firmicutes, "train_firmicutes_data.csv")
# pep_firmicutes <- unique(firmicutes$Info_PepID)

terrabacteria <- readRDS("./data/clostridium_files/terrabacteria_data.rds")
terrabacteria <- terrabacteria$df
terrabacteria <- terrabacteria[terrabacteria$Info_PepID %!in% unique_test_clostridium, ]
write.csv(terrabacteria, "train_terrabacteria_data.csv")
# pep_terrabacteria <- unique(terrabacteria$Info_PepID)

bacteria <- readRDS("./data/clostridium_files/bacteria_data.rds")
bacteria <- bacteria$df
bacteria <- bacteria[bacteria$Info_PepID %!in% unique_test_clostridium, ]
write.csv(bacteria, "train_bacteria_data.csv")
# pep_bacteria <- unique(bacteria$Info_PepID)