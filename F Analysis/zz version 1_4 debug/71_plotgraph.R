setwd("H:/second year paper research/second_year_paper/12 sandbox code/pseudomesabi/2018 02 12/dbresearch")
dir()

stringpath <- "H:/second year paper research/second_year_paper/12 sandbox code/pseudomesabi/2018 02 12"
stringpath2 <- paste(stringpath,"/dbresearch")
stringpath3 <-  paste(stringpath2,"/analysis/analysisfiles")

#setwd("./dbresearch/analysis/analysisfiles")
dir()
#dataset <- read.csv(file = "./data/mergefile.csv")
#install.packages("ggplot2")
require("ggplot2")

myscatter <- ggplot(data = dataset, aes(x = dsalesvolog, y = dempltotlog, color = age)) + geom_point() 
myscatter

myhist <- ggplot(data = dataset, aes(x = dsalesvolog)) + geom_histogram() 
myhist


mydens <- ggplot(data = dataset, aes(dsalesvolog, color = dstateco)) + geom_density() 
mydens


ggplot(data = diamonds , aes(depth, color = cut)) + geom_density()