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

# Symbol name    value variable
#  <chr>  <chr>   <dbl> <chr>   
#1 gene1  sample1     2 A       
#2 gene1  sample2     4 A       
#3 gene1  sample3     8 A       
#4 gene1  sample4     0 A       
#5 gene1  sample5     1 A       
#6 gene2  sample1    59 A 
```

The IQR analyses are aimed to compare two genesets to see if those change - get deregulated (meaning increasing in IQR) - over a variable such as time, age, treatment.

To calculate IQR for the two groups shown above we need to define a geneset first.
In this example just 5 genes.

```r
geneset <- c("gene1", "gene2", "gene3", "gene4", "gene5")
```


From there we can run the `stoichiometry()` function.
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
stoi <- stoichiometry(expression = data$value,
                      symbol = data$Symbol,
                      variable = data$variable,
                      geneset = c("gene1", "gene2", "gene3", "gene4", "gene5"),
                      sample = data$name)
                      
                      
head(sttoi)
#  variable rep        IQR
#  <fct>    <chr>    <dbl>
#1 A        sample1     30
#2 A        sample2     21
#3 A        sample3     49
#4 A        sample4     26
#5 A        sample5     57
#6 B        sample10    38
```



```r
t.test( stoi$IQR ~stoi$variable)


# 	Welch Two Sample t-test

# data:  stoi$IQR by stoi$variable
# t = 0.46726, df = 5.7128, p-value = 0.6576
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#  -15.48451  22.68451
# sample estimates:
# mean in group A mean in group B 
#            36.6            33.0 
```

And there is a convenience plotting wrapper in `stoi_plot`


```r
stoi_plot(stoi)
```
[[Rplot02.png]]



An example pipeline is in the script run_IQR_script.R

