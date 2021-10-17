library(tidyverse)

#Are we in RStudio? If so, set path appropriately.
if (rstudioapi::isAvailable())
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

source("clean_functions.R")
data <- read_csv("example_gene_data.csv")


stoi <- stoichiometry(expression = data$value,
                      symbol = data$Symbol,
                      variable = data$variable,
                      geneset = c("gene1", "gene2", "gene3", "gene4", "gene5"),
                      sample = data$name)

stoi
t.test( stoi$IQR ~ stoi$variable)
stoi_plot(stoi)
