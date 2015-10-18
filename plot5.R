#5.How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# Download the file if necessary (29MB)
	## To subset Motor Vehicle source
		NETFLONROAD <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]
		#library(dplyr)
		NETONROADAGG <- aggregate(Emissions ~ year, NETFLONROAD, sum)
		#View(NETONROADAGG)
	#Plot
	library(ggplot2)
	#png("plot5.png", width=840, height=480)
	g <- ggplot(NETONROADAGG, aes(factor(year), Emissions))
	g <- g + geom_bar(stat="identity") +
  	xlab("year") +
  	ylab(expression('Total PM'[2.5]*" Emissions")) +
 	ggtitle('Total Emissions from motor vehicle sources (ON ROAD) in Baltimore City, 
	Maryland (fips = "24510") from 1999 to 2008')
	print(g)
	dev.off()