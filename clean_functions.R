
stoichiometry <- function(symbol, expression, variable, sample, geneset) { 
  
  # This function calculates the IQR values for selected genesets
  # The required inputs are:
  # symbol        - character vector of gene symbols
  # expression    - numeric vectors of expression values
  # variable      - character or factor vector with group information 
  #                 (e.g. age group or treatment)
  # sample        - character vector of sample IDs
  # geneset       - character vector of interested genes 
  #                 (same nomenclature as symbol)
  #                 if no geneset is supplied IQR analyses are performed based on all provided symbols
  require("dplyr")
  
  if(any(is.na(expression)))
    stop("remove NAs from expression values")
  if(any(is.na(symbol)))
    stop("remove NAs from gene symbols")
  if(length(as.factor(variable))<=2)
    stop("more variables required")
  if(missing(geneset)) {
    geneset <- symbol
  }
  if(is.character(geneset)==F)
    stop("check format of geneset")
  
  
  print(paste0("calculating using ", length(geneset)," symbols"))
  
  dat <- data.frame(expression = expression, 
                    symbol= symbol, 
                    variable=variable,
                    rep = sample)
  
    dat <- dplyr::filter(dat, symbol %in% geneset)
  
  
  dat <- dat %>% dplyr::group_by(variable, rep)
  
  dat2 <- dat %>% dplyr::summarise(IQR = IQR(expression), .groups = "drop_last")
  
  return(dat2)
  
}

stoi_plot <- function (data) {
  # This is a convenience wrapper to create the IQR plot using the stoichiometry() output
  require("ggplot2")
  require("ggrepel")
  require("ggsci") 
  require("dplyr")
  # test if enough samples for boxplot provided, if not just dotplot
  if(length(as.factor(stoi$rep)) <9) {
    # dotplot
    ggplot(stoi, aes(variable, IQR, label = rep, color = variable)) +
      geom_point() +
      stat_summary(fun=mean, geom = "crossbar") +
      theme_bw() +
      geom_text_repel() +
      scale_color_aaas() +
      ylab("Interquartilerange") +
      xlab("")
    
  }
  if(length(as.factor(stoi$rep)) >9){
    ggplot(stoi, aes(variable, IQR, label = rep, fill = variable)) +
      geom_boxplot() +
      geom_point() +
      theme_bw() +
      scale_fill_aaas() +
      geom_text_repel() +
      ylab("Interquartilerange") +
      xlab("")
  }
}
