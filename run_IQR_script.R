library(tidyverse)
data <- read_csv("example_gene_data.csv")


stoi <- stoichiometry(expression = data$value,
                      symbol = data$Symbol,
                      variable = data$variable,
                      geneset = c("gene1", "gene2", "gene3", "gene4", "gene5"),
                      sample = data$name)

stoi_plot(stoi)
