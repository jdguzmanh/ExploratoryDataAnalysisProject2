library(dplyr)

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

plotTotal <- group_by(NEI, year) %>% summarise(Emission.Kilotons= sum(Emissions)/1000) 

##plot total
png('plot1.png')
plot(plotTotal,lwd=3, type = "b", main= "TOTAL YEAR PM25")
dev.off()
