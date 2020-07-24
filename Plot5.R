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

plot5data <- subset(NEI, fips == "24510" & type=="ON-ROAD") %>%
  group_by( year) %>% 
  summarise(Emissions= sum(Emissions)) 

##plot total
png('plot5.png')
plot(plot5data,lwd=3, type = "b", main= ("Baltimore - ON-ROAD Emissions"))
dev.off()
