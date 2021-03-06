## Start of the function
circle.segments <- function(filename="circle", proportions, grey.proportion="no", total.angle="", colors="", grey.color="grey") {
	
	if(grey.proportion=="no") {grey.proportion <- 0 ; gp <- TRUE } else{gp <- FALSE} # if there is no grey proportion specified
	
	# colors
	if(colors[1]==""){
		if(length(proportions)==3 | length(proportions)==5){
			if(length(proportions)==3) colors <- c("green", "yellow", "red")
			if(length(proportions)==5) colors <-c("darkgreen", "green", "yellow", "red", "darkred")
		} else {
			colors <- rainbow(length(proportions))
		}}
	
	# if( !(identical(length(colors),length(proportions)))) cat("Colors and Proportion not the same length")
	
	colors<- c(rep(as.character(colors), each=2), grey.color) 			# ad grey to the color-string
	colors <- paste('fill="',colors,'"', sep="")		  # change the "' so they are correctly displayed in the SVG
	
	
	proportions <- c(proportions, grey.proportion) / sum(c(proportions, grey.proportion), na.rm = TRUE)   # calculate the proportions so they add up to 1
	
	# Angles
	if(gp & total.angle=="") total.angle <- 360  # use the whole circle when no grey proportion
	if(total.angle=="") { total.angle <- ifelse(length(proportions)==5, 225, 180) }
	segment.angle <- total.angle/(length(proportions)-1)    # calculate the colored segments angles
	angles <- c( total.angle/2 ,total.angle/2 - segment.angle*(1:(length(proportions)-1)))
	angles <- c(angles[1],rep(angles[2:(length(angles)-1)],each=2),angles[length(angles)])  #calculate total angles
	angles <- c(angles, angles[length(angles)], angles[1])
	
	A <- (100^2*pi)*proportions 											# area of segments. Arbitrary standard to radius 100 pix
	a <-(360/total.angle)                             # calculate the factor to compensate for the grey area
	radii <- rep( sqrt(((a)*(length(proportions)-1)*A[-length(A)])/pi) , each=2)  # calculate the radiuses (?) for each segment (except grey)
	a <- 360/(360-total.angle)                        # calculate the factor to compensate for the coloured area
	radius.grey <- sqrt((a*A[length(A)])/pi)          # radius of the grey segment
	radii <- c(radii, radius.grey, radius.grey)       # connect the radiusses
	

	
	# Trigometric magic
	x <- cos(angles*pi/180)*radii
	y <- sin(angles*pi/180)*radii* -1
	
	
	# put all the measures (points and radixes) into the svg file
	xx <- character()
	for(i in 1:((length(radii))/2)*2-1 ){
		xx <- paste(xx,
								'<path d="M0 0',
								x[i], y[i],'A',radii[i], radii[i], 0, 0, 1, x[i+1], y[i+1],
								'Z" ', colors[i], '/>
								'
		)
	}
	
	#Axis
	axis <-     '<path
	d="M -110,0 H 110"
	style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:1;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1" />
	<path
	d="M 0,-110 V 110"
	style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:1;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1" />'
	
	
	mr <- 150 #max(radii)
	
	
	### Construct the svg file
	xxx <- paste(
		'<?xml version="1.0" encoding="UTF-8" standalone="no"?>
		<svg
		   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   id="svg16"
   version="1.1"
		 width="500" height="500" viewBox="0 0', 4*mr, 4*mr,'">
			<g transform="translate(',2*mr,',',2*mr,')" stroke="none" stroke-width="
">',
		
		xx,   
		axis,  # if axis is second it will be overplotting the proportions
		
		'  </g>
</svg>'
	)
	write(xxx, paste(filename,".svg", sep="")) # write the file
	
	}
# end of the function
