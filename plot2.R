## create the new folder, download the data and unzip the file

if(!file.exists("./data"))
{dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileURL,destfile="./data/new_data.zip",method="auto")  
unzip("./data/new_data.zip", exdir="./data")

## read the files

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## separate the data for the plot

baltbyYear <- subset(NEI, fips == "24510")
byYear <- aggregate(Emissions ~ year, baltbyYear, sum)

## png file creation

png("Plot2.png")

## plotting

barplot(byYear$Emissions, col=c("blue", "green", "pink", "red"), names.arg=byYear$year, xlab="Years", ylab=expression('Total PM'[2.5]*' emission'), 
        main=expression('Total PM'[2.5]*' emission for each year'))

## close png file

dev.off()