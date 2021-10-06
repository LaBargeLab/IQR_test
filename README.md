# IQR_test

## Readme

Here I will provide R functions to a method paper explaining my loss of stoichiometry stuff and providing (hopefully useful) helper functions.

## How to work this mess

Let's prepare the workspace

```r
library(tidyverse)

# Load the data 

data <- read_csv("example_gene_data.csv")

#source the functions

source("clean_functions.R")

```


The data here is synthetic RNA seq data with a total of 10 samples and 2 conditions.


```r
head(data)

#  Symbol name    value variable
#   <chr>  <chr>   <dbl> <chr>   
# 1 gene1  sample1    99 A       
# 2 gene1  sample2   131 A       
# 3 gene1  sample3    74 A       
# 4 gene1  sample4   145 A       
# 5 gene1  sample5   102 A       
# 6 gene1  sample6   166 B 
```

The IQR analyses are aimed to compare two genesets to see if those change - get deregulated (meaning increasing in IQR) - over a variable such as time, age, treatment.

To calculate IQR for the two groups shown above we need to define a geneset first.
In this example just 5 genes.

```r
geneset <- c("gene1", "gene2", "gene3", "gene4", "gene5")
```


From there we can run the `r stoichiometry()` function.
this function requires a couple of inputs detailes below:


     symbol        - character vector of gene symbols
     expression    - numeric vectors of expression values
     variable      - character or factor vector with group information 
                     (e.g. age group or treatment)
     sample        - character vector of sample IDs
     geneset       - character vector of interested genes 
                     (same nomenclature as symbol)

The output of `stoichiometry()` is a dataframe that you can use for stat tests e.g.:

```r
t.test( stoi$IQR ~stoi$variable)
```

And there is a convenience plotting wrapper in `stoi_plot`

An example pipeline is in the script run_IQR_script.R

