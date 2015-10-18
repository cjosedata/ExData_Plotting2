#2. Have total emissions from PM2.5 decreased in the Baltimore City,
#Maryland (fips == "24510") from 1999 to 2008? 

if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

# Use the base plotting system to make a plot answering this question.
  ## subsetting
	NEIFLIPS  <- NEI[NEI$fips=="24510", ]
	#View(NEIFLIPS)

	NEIFIPAGG <- aggregate(Emissions ~ year, NEIFLIPS, sum)
	#View(NEIFIPAGG)

  ##Plot 2	
	png('plot2.png')
	barplot(height=NEIFIPAGG$Emissions, names.arg=NEIFIPAGG$year, 
		xlab="years",ylab=expression('total PM'[2.5]*' emission'),
		main=expression('Total PM'[2.5]*' in the Baltimore City, MD emissions at various years'))
	dev.off()