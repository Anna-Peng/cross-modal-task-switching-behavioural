library(readr)
pathname = "/Users/annapeng/Google Drive/Anna/PhD/Codes/2. CMTS-1/results/Pilot/"
files <- list.files(path = pathname, pattern = "*.csv", full.names = T)
tbl <- lapply(files, read_csv)
names(tbl) <- gsub(".csv","", list.files(path=pathname,pattern = "*.csv", full.names = FALSE), fixed = TRUE)

