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

## merge and subset the data

merged.Data <- merge(NEI, SCC, by="SCC")
merged.subset.Data <- subset(merged.Data, (fips=="24510"|fips=="06037") & type=="ON-ROAD")
totalbyYear <- aggregate(Emissions ~ year + fips, merged.subset.Data, sum)
totalbyYear$fips[totalbyYear$fips=="24510"] <- "Baltimore City, MD" 
totalbyYear$fips[totalbyYear$fips=="06037"] <- "Los Angeles County, CA"

## png file creation

png("Plot6.png")

## plotting

library(ggplot2)
ggplot(totalbyYear, aes(x=factor(year), y=Emissions,fill=fips)) + 
  geom_bar(stat="identity") +
  facet_grid(.~fips)+
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" emission in tons")) +
  ggtitle(expression("Total emissions from motor vehicles in Baltimor City vs Los Angeles from 1999 to 2000"))


## close png file

dev.off()