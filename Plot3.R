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
##resume data for plot total, emmision in Kilotons 

plot3data <- subset(NEI, fips == "24510") %>%
  group_by( year, type) %>% 
  summarise(Emissions= sum(Emissions)) 

##plot total
png('plot3.png')
g <- ggplot(plot3data, aes(year, Emissions, color = type))
g <- g + geom_line() +
  xlab("year") +
  ylab("PM 2.5 Emissions") +
  ggtitle('Emissions in Baltimore City, Maryland from 1999 to 2008')
print(g)
dev.off()
