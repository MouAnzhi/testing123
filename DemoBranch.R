  # loading libraries
library(googleVis)
library(dplyr)
library(reshape2)


LineOfTherapyR <- read.csv("~/Data Sciences/Flatiron CLL Data Sample 20160701 (1)/LineOfTherapyR.csv", header=TRUE)
df<-LineOfTherapyR

df.plot<-data.frame()

for (i in 2: ncol(df)) {
  lin.cache<-df %>%
    group_by(df[ ,i-1], df [ , i]) %>%
    summarise(n=n()) %>%
    ungroup()
  
  colnames(lin.cache)[1:2]<-c ('from','to')
  
  #adding tags 
  lin.cache$from<-paste(lin.cache$from, '(', i-1, ')', sep = '')
  lin.cache$to <- paste(lin.cache$to, '(', i, ')', sep ='')
  
  df.plot<-rbind(df.plot, lin.cache)
}

#Sankey

M<-gvisSankey(df.plot, from = 'from', to= 'to', weight = 'n', options = list(height=2000, width=4000, sankey="{link:{color:{fill:'lightblue'}}}"))
plot(M)

cat(M$html$chart, file = "SankeyLineOfTherapy.html")