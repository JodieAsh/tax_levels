# orgID <- 2104 # Mycoplasma pneumoniae - Species 
# orgID <- 2093 # Mycoplasma - Genus
# orgID <- 2092 # Mycoplasmataceae - Family 
# orgID <- 2085 # Mycoplasmatales - Order
# orgID <- 31969 # Mollicutes - Class
# orgID <- 544448 # Tenericutes - Phylum
# orgID <- 1783272 # Terrabacteria group - Clade
# orgID <- 2 # Bacteria - Kingdom

# Remove test proteins from all other data sets 
'%!in%' <- function(x,y)!('%in%'(x,y))

# Similarity threshold issues
# orgID <- 2104 # Mycoplasma pneumoniae - Species 

# orgID <- 2093 # Mycoplasma - Genus
mycoplasma <- readRDS("./jan_data/mycoplasma_data/mycoplasma_data.rds")
mycoplasma <- mycoplasma$df
mycoplasma_test <- mycoplasma[mycoplasma$Info_split == "split_01_25", ]
mycoplasma_train <- mycoplasma[mycoplasma$Info_split == "split_02_75", ]
unique_id_mycoplasma <- unique(mycoplasma$Info_PepID)
unique_id_train_mycoplasma <- unique(mycoplasma_train$Info_PepID)
unique_id_test_mycoplasma <- unique(mycoplasma_test$Info_PepID)
write.csv(mycoplasma_train, "train_mycoplasma.csv")
write.csv(mycoplasma_test, "test_mycoplasma.csv")

# orgID <- 2092 # Mycoplasmataceae - Family 
mycoplasmataceae <- readRDS("./jan_data/mycoplasma_data/mycoplasmataceae_data.rds")
mycoplasmataceae <- mycoplasmataceae$df
mycoplasmataceae <- mycoplasmataceae[mycoplasmataceae$Info_PepID %!in% unique_id_test_mycoplasma, ]
write.csv(mycoplasmataceae, "mycoplasmataceae.csv")
# pep_mycoplasmataceae <- unique(mycoplasmataceae$Info_PepID)

# Same peptides as Mycoplasmataceae
# orgID <- 2085 # Mycoplasmatales - Order
# mycoplasmatales <- readRDS("./jan_data/mycoplasma_data/mycoplasmatales_data.rds")
# mycoplasmatales <- mycoplasmatales$df

# Same peptides as Mycoplasmataceae
# orgID <- 31969 # Mollicutes - Class
# mollicutes <- readRDS("./jan_data/mycoplasma_data/mollicutes_data.rds")
# mollicutes <- mollicutes$df

# Same peptides as Mycoplasmataceae
# orgID <- 544448 # Tenericutes - Phylum
# tenericutes <- readRDS("./jan_data/mycoplasma_data/tenericutes_data.rds")
# tenericutes <- tenericutes$df

# orgID <- 1783272 # Terrabacteria group - Clade

