Sys.setlocale(category = "LC_ALL", locale = "hebrew")
library(shiny)
library(rgdal)
library(akima) 
library(reshape2)
library(ggmap)
library(raster)
library(plyr)
options(shiny.maxRequestSize = -1)

shinyServer(function(input, output,session) {
##-------------
##upload the data
##---------------
userdata <- reactive(function(){
    	Sys.setlocale(category = "LC_ALL", locale = "hebrew")
      read.csv("netanya.csv", header=F,stringsAsFactors =F,fileEncoding="windows-1255")
	 
  # return(data)
	   
  })
 #####--------------------------
 #show the data in a nice fancy data table
 ##--------------------
    output$datatable <- renderDataTable({
       data1<-userdata()
	 data1[[5]]<-enc2utf8(data1[[5]])
	 data1[[1]]<-substr(data1[[1]],0,nchar(data1[[1]])-3)
    return(data1)
  })
  
  ##----------------
  ##build the map
  #------------------------
    plotdatamap<-reactive({
    data<-userdata() 
	data[[5]]<-enc2utf8(data[[5]])
	 data[[1]]<-as.numeric(substr(data[[1]],0,nchar(data[[1]])-3))
    p<-ggmap(get_map(location = c(left = 34.78893, bottom = 32.22034, right =34.93546 , top = 32.40188),maptype="roadmap", scale=4))
   v<-p+geom_point(aes(x=V6, y=V7, colour = V1, size=V1),data=data, alpa=0.5)+ scale_colour_gradient(low = "blue", high="red")
    print(v)
  })
  ##------------
  ###show map
  ##-----------
  output$map<-renderPlot({
   plotdatamap()},height = 800, width = 1200
  )
  ##----------------
  ##build the heatmap
  #------------------------
    plotheatmap<-reactive({
    data<-userdata() 
	data[[5]]<-enc2utf8(data[[5]])
	 data[[1]]<-as.numeric(substr(data[[1]],0,nchar(data[[1]])-3))
    p<-ggmap(get_map(location = c(left = 34.78893, bottom = 32.22034, right =34.93546 , top = 32.40188),maptype="roadmap", scale=4))
	v<-p+stat_density2d(aes(x=V6, y=V7 ,fill = ..level..),data=data, size=0.5 ,bins=10,geom="polygon",colour = "grey95")+scale_fill_gradient(low = "yellow", high = "red") + scale_alpha(range = c(0.1,1) )
	print(v)
})
 ##------------
  ###show heatmap
  ##-----------
   output$heat_map<-renderPlot({
   plotheatmap()},height = 800, width = 1200
  )
    ##----------------
  ##build trends
  #------------------------
  output$trends<-renderPlot({
  data<-userdata()
  data[[5]]<-enc2utf8(data[[5]])
  data[[1]]<-as.numeric(substr(data[[1]],0,nchar(data[[1]])-3))
  data[[3]]<-strptime(data[[3]],format="%d.%m.%y")
  plot(ddply( data , .(V3),summarise ,mean_x=mean(V1) ),type="l", col="red", xlab="תאריך", ylab="ממוצע מחירי הדירות בשקלים", main="מגמת מחירי הדיור")
  })
 
	})
