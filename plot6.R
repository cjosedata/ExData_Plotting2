#6.Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County,
#Which city has seen greater changes over time in motor vehicle emissions?
# 24510 is Baltimore, see plot2.R, 06037 is LA CA
# Searching for ON-ROAD type in NEI 

if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

#California (fips == "06037"). 

	#subset ON-ROAD CA and BALTIMORE FIPS
	NETBALAONROAD <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]
	NETBALAONROADAGG <- aggregate(Emissions ~ year + fips, NETBALAONROAD, sum)
	#View(NETBALAONROADAGG)
	## Assign names to flips
	NETBALAONROADAGG$fips[NETBALAONROADAGG$fips=="24510"] <- "Baltimore, MD"
	NETBALAONROADAGG$fips[NETBALAONROADAGG$fips=="06037"] <- "Los Angeles, CA"
	#View(NETBALAONROADAGG)

	##Plot 6
	#png("plot6.png", width=1040, height=480)
	g <- ggplot(NETBALAONROADAGG, aes(factor(year), Emissions))
	g <- g + facet_grid(. ~ fips)
	g <- g + geom_bar(stat="identity")  +
 		xlab("year") +
 		ylab(expression('Total PM'[2.5]*" Emissions")) +
  		ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(g)
dev.off()