## create the new folder, download the data and unzip the file

if(!file.exists("./data"))
{dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileURL,destfile="./data/new_data.zip",method="auto")  
unzip("./data/new_data.zip", exdir="./data")

## install the gg plot2 package
install.packages("ggplot2")


## read the files

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## separate the data for the plot

baltbyYear <- subset(NEI, fips == "24510")
byYearntype <- aggregate(Emissions ~ year + type, baltbyYear, sum)

## png file creation

png("Plot3.png")

## plotting

library(ggplot2)
ggplot(byYearntype, aes(x=factor(year), y=Emissions, fill=type, label= round(Emissions,2))) + 
      geom_bar(stat="identity") +
      facet_grid(.~type)+
      xlab("Year") +
      ylab(expression("Total PM"[2.5]*" emission in tons")) +
      ggtitle(expression("PM"[2.5]*paste(" emissions in Baltimore ",
                                     "City by various source types", sep="")))+
      geom_label(aes(fill = type), colour = "white", fontface = "bold")

## close png file

dev.off()