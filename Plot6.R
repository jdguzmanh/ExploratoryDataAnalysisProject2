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

plot6dataB <- subset(NEI, fips == "24510" & type=="ON-ROAD") %>%
  group_by( year, fips) %>% 
  summarise(Emissions= sum(Emissions)) 

plot6dataA <- subset(NEI, fips == "06037"& type=="ON-ROAD") %>%
  group_by( year, fips) %>% 
  summarise(Emissions= sum(Emissions)) 

plot6dataB <- mutate(plot6dataB, City = "Baltimore")
plot6dataA <- mutate(plot6dataA, City = "Angeles")

plot6data <- rbind(plot6dataB,plot6dataA)

##plot total
png('plot6.png')
g <- ggplot(plot6data, aes(year, Emissions, color = City))
g <- g + geom_line() +
  xlab("year") +
  ylab("PM 2.5 Emissions") +
  ggtitle('ON-ROAD Emissions in Baltimore and Angeles from 1999 to 2008')
print(g)
dev.off()
