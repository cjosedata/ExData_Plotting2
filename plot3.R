#3.Of the four types of sources indicated by the =type= (point, nonpoint, onroad, nonroad)variable, 
#which of these four sources have seen decreases in emissions from 1999-2008 
#for Baltimore City? Which have seen increases in emissions from 1999-2008?
#Use the ggplot2 plotting system to make a plot answer this question.

if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}
#Baltimore City Subset
NEIFLIPS  <- NEI[NEI$fips=="24510", ]

   ##1.Aggreation using grouping of columns
	NEIGRPAGG <- as.data.frame(NEIFLIPS[, mean(Emissions, na.rm = TRUE),by = list(year,type)])
	colnames(NEIGRPAGG) = c("year","type", "Emissions")
	#View(NEIGRPAGG)
	
    ##1.Aggreation using grouping of columns
	NEIGRPAGG  <- aggregate(Emissions ~ year + type, NEIFLIPS, sum)
	#View(NEIGRPAGG)
   #Use the ggplot2 plotting system to make a plot answer this question.
     ##[[./plot3.png]]
     library(ggplot2)
	png("plot3.png", width=640, height=480)
	g <- ggplot(NEIGRPAGG, aes(year, Emissions, color = type))
	g <- g + geom_line() +
  	xlab("year") +
  	ylab(expression('Total PM'[2.5]*" Emissions")) +
  	ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999 to 2008')
	print(g)
	dev.off()