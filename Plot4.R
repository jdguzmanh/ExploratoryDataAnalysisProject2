library(dplyr)
library(ggplot2)

if(!exists("NEI")){
  URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  destFile <- "exdata_data_NEI_data.zip"
  
  # realiza la descarga y descomprime el archivo
  # Download and unzip the file
  
  download.file(URL, destfile = destFile, mode='wb')
  unzip(destFile)
  
  ##carga los archivos
  ## This first line will likely take a few seconds. Be patient!
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

## select scc id of Fuel Comb.*Coal 
a <- SCC[grepl("Coal", SCC$Short.Name, ignore.case=TRUE),1]
##resume data for plot 

plot4data <- subset(NEI,SCC %in% a) %>% 
    group_by( year) %>% 
    summarise(Emissions= sum(Emissions))

##plot total
png('plot4.png')
plot(plot4data,lwd=3, type = "b", main= ("Emissions from coal combustion-related"))
dev.off()